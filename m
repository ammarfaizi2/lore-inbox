Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbWB1ROE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbWB1ROE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 12:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbWB1ROE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 12:14:04 -0500
Received: from mail.suse.de ([195.135.220.2]:60086 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932171AbWB1ROB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 12:14:01 -0500
From: Andi Kleen <ak@suse.de>
To: Paul Jackson <pj@sgi.com>
Subject: Re: [PATCH 01/02] cpuset memory spread slab cache filesys
Date: Tue, 28 Feb 2006 18:13:46 +0100
User-Agent: KMail/1.9.1
Cc: Christoph Lameter <clameter@engr.sgi.com>, dgc@sgi.com, steiner@sgi.com,
       Simon.Derr@bull.net, linux-kernel@vger.kernel.org, clameter@sgi.com
References: <20060227070209.1994.26823.sendpatchset@jackhammer.engr.sgi.com> <Pine.LNX.4.64.0602271510320.12637@schroedinger.engr.sgi.com> <20060227175603.e858eade.pj@sgi.com>
In-Reply-To: <20060227175603.e858eade.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602281813.47234.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 February 2006 02:56, Paul Jackson wrote:
> Hmmm ... your thread with Andi confuses me ...
> 
> Oh well.
> 
> I take it that Andi is suggesting that there be the option to override
> the tasks mempolicy, in the particular case of these file i/o slab
> caches, with an interleave over the online nodes.

Yep exactly.
 
> This option would be useful in the case that a system is not using
> cpusets, but still wants to spread out these particular (sometimes
> large) file i/o caches.

Yep.
 
> Questions for Andi:
> 
>  1) Are you content to have such a interleave of these particular file
>     i/o slabs triggered by a mm/mempolicy.c option?  Or do you think
>     we need some sort of task external API to invoke this policy?

Task external. mempolicy.c has no good way to handle multiple policies
like this. I was thinking of a simple sysctl

I guess I can cook up a patch once your code is merged.


>  2) Do you recommend that the page (file buffer) cache also be
>     interleavable, across all online nodes, if optionally requested,
>     on systems not using cpusets?

Yes, but as a separate option.

-Andi

