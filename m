Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbVJPAww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbVJPAww (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 20:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbVJPAww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 20:52:52 -0400
Received: from sccrmhc11.comcast.net ([63.240.76.21]:28385 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1751264AbVJPAwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 20:52:51 -0400
Date: Sat, 15 Oct 2005 17:53:41 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: jgarzik@pobox.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] RNG rewrite...
Message-ID: <20051016005341.GB5946@plexity.net>
Reply-To: dsaxena@plexity.net
References: <20051015043120.GA5946@plexity.net> <4350DCB1.7010201@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4350DCB1.7010201@pobox.com>
Organization: Plexity Networks
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 15 2005, at 06:40, Jeff Garzik was caught saying:
> Deepak Saxena wrote:
> >rewrite the damn thing to use the device model and have a rng
> >device class with individual drivers for each RNG model, including
> >IXP4xx. I'll keep the miscdev interface around but will add a
> >new interface under /sys/class/rng that the userspace tools 
> >can transition to. Is this OK with folks?
> 
> How does the hardware export RNG functionality?  CPU insn?  Magic memory 
> address?  Can it be done 100% in userspace?

It's a magic regsiter we just read/write and could be done in userspace.
I also took a look at MPC85xx and it has the same sort of interface but
also has an error interrupt capability. On second thought a class
interface is overkill b/c there will only be one RNG per system, so
I can just do something like watchdogs where we have a bunch of simple
drivers exposing the same interface. We could do it in user space but
then we have separate RNG implementations for  x86 and !x86 and I'd
rather not see that. Can we move the x86 code out to userspace and
just let the daemon eat the numbers directly from HW? We can mmap() 
PCI devices, but I don't know enough about x86 to say whether msr 
instructions can execute out of userspace (or if we want them to...).

~Deepak

-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

When law and duty are one, united by religion, you never become fully
conscious, fully aware of yourself. You are always a little less than
an individual. - Frank Herbert
