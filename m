Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261301AbVABTM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbVABTM5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 14:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbVABTM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 14:12:57 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:17310 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261301AbVABTMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 14:12:54 -0500
Date: Mon, 27 Dec 2004 20:36:37 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux-VServer <vserver@list.linux-vserver.org>
Subject: Re: The Future of Linux Capabilities ...
Message-ID: <20041227193637.GH1043@openzaurus.ucw.cz>
References: <20041227014041.GA30550@mail.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041227014041.GA30550@mail.13thfloor.at>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> I would not spend too much time on that, if we would
> not need to improve that system by splitting up (or
> working around) some capabilities which are too coarse
> (or too general) to be useful ...
> 
> good examples for such capabilities are:
> 
> 	#define CAP_NET_ADMIN        12
> especially CAP_NET_ADMIN and CAP_SYS_ADMIN contain
> more than 20 different aspects ...
> 
> we are currently aware of three different solutions
> to refine the capability system, and I would like to
> hear some opinions and get a statement from mainline
> (good, impossible, crap, don't care, or whatever ;) 
> 
>    I)	extend the capability type kernel_cap_t to
> 	64 (or more) bit, add new syscalls cap*64()	 
> 	and let the 'old' interface just see the lower
> 	32 bit
> 
>   II)	add 32 (or more) sub-capabilities which depend
> 	on the parent capability to be usable, and add
> 	appropriate syscalls for them.
> 
> 	example: CAP_IPC_LOCK gets two subcapabilities
> 	(e.g. SCAP_SHM_LOCK and SCAP_MEM_LOCK) which
> 
>  III)	(linux-vserver specific solution)
> 	add a (compile time) CAP_MASK to declare which
> 	caps have subcaps, then use per context subcaps
> 	for known subfeatures and an additional cap_t
> 	to cover 'all other' aspects of the capability
> 
> 	example: CAP_IPC_LOCK in CAP_MASK, plus the
> 	SCAP_MEM_LOCK subcapability, now having IPC_LOCK
> 	in the tasks caps doesn't do anything without
> 	the corresponding IPC_LOCK in the context or
> 	the SCAP_MEM_LOCK capability where appropriate
> 
> I think that all three solutions are usable for our
> project, so I can live pretty well with III, but I think
> refining the capability system might be something which
> is useful for mainline ...

1) seems acceptable, as long as 64bits is enough. 2) looks ugly.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

