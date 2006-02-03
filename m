Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964863AbWBCDBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbWBCDBp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 22:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964864AbWBCDBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 22:01:45 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:7811 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S964863AbWBCDBp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 22:01:45 -0500
Date: Fri, 3 Feb 2006 04:01:43 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Kirill Korotaev <dev@openvz.org>
Cc: serue@us.ibm.com, arjan@infradead.org, frankeh@watson.ibm.com,
       clg@fr.ibm.com, haveblue@us.ibm.com, mrmacman_g4@mac.com,
       alan@lxorguk.ukuu.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, devel@openvz.org
Subject: Re: [RFC][PATCH] VPIDs: Virtualization of PIDs (OpenVZ approach)
Message-ID: <20060203030143.GC1075@MAIL.13thfloor.at>
Mail-Followup-To: Kirill Korotaev <dev@openvz.org>, serue@us.ibm.com,
	arjan@infradead.org, frankeh@watson.ibm.com, clg@fr.ibm.com,
	haveblue@us.ibm.com, mrmacman_g4@mac.com, alan@lxorguk.ukuu.org.uk,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, devel@openvz.org
References: <43E22B2D.1040607@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E22B2D.1040607@openvz.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2006 at 06:54:21PM +0300, Kirill Korotaev wrote:
> [RFC][PATCH] VPIDs: Virtualization of PIDs (OpenVZ approach)
> 
> OpenVZ project would like to present another approach for VPIDs
> developed by Alexey Kuznetsov. These patches were heavily tested and
> used for half a year in OpenVZ already.
>
> OpenVZ VPIDs serves the same purpose of VPS (container) checkpointing
> and restore. OpenVZ VPS checkpointing code will be released soon.
>
> These VPIDs patches look less intrusive than IBM's, so I would ask to
> consider it for inclusion. Other projects can benefit from this code
> as well.

well, IMHO this approach lacks a few things which would
be very useful in a mainline pid virtualization, which
pretty much explains why it is relatively small

 - hierarchical structure (it's flat, only one level)
 - a proper administration scheme
 - a 'view' into the child pid spaces
 - handling of inter context signalling

and, more important, it does not deal with the existing
issues and error cases, where references to pids, tasks,
task groups and sessions aren't handled properly ...

I think that in real world virtualization scenarios
with hundreds of namespaces those 'imprecisions' will 
occasionally lead to very strange and random behaviour
which in many cases will go completely unnoticed.

so I really prefer to cleanup the existing pid handling
first, to avoid big surprises later ...

best,
Herbert

> Patch set consists of 7 patches. The main patches are: -
> diff-vpids-macro, which introduces pid access interface -
> diff-vpids-core, which introduces pid translations where required
> using new interfaces - diff-vpids-virt, which introduces virtual pids
> handling in pid.c and pid mappings for VPSs
>
> Patches are against latest 2.6.16-rc1-git6
> 
> Kirill Korotaev,
> OpenVZ team
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
