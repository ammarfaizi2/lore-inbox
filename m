Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265506AbUAZE5I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 23:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265512AbUAZE5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 23:57:08 -0500
Received: from opersys.com ([64.40.108.71]:18 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S265506AbUAZE5F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 23:57:05 -0500
Message-ID: <40149F25.1040209@opersys.com>
Date: Mon, 26 Jan 2004 00:01:25 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Dan Aloni <da-x@gmx.net>
CC: Nuno Silva <nuno.silva@vgertech.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Cooperative Linux
References: <20040125193518.GA32013@callisto.yi.org> <40148C1C.5040102@vgertech.com> <20040126042631.GA401@callisto.yi.org>
In-Reply-To: <20040126042631.GA401@callisto.yi.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dan Aloni wrote:
> I can't say exactly when, but several people volunteered to work on this. 

BTW, I've been looking at the code. Many of the tricks done for forcing
NT to share resources with Linux should be unnecessary for a Linux setup.
Also, the code apparently assumes only two OSes. You probably want to
check the detailed discussion I had written some time ago about how to
easily obtain an SMP cluster with Linux (N instances on separate CPUs
with very few code modifications required):
http://www.opersys.com/adeos/dox/practical-smp-clusters/practical-smp-clusters.html
Some of the code you've already written can be used as-is to this end.
The nanokernel side still needs some extending, but you've brought things
one step closer to completion.

On a UP system, instead of running just 2 instances, you can load a
nanokernel in a fixed RAM region and remap it in every instance's
virtual memory. You can then use a slightly modified kexec to start
independent images in different RAM regions. I had discussed this
with Eric at the last OLS and he was interested. The added
advantage with Adeos is that you could then share a single interrupt
pipeline among all OSes, and have different OSes manage different hardware
components. Of course, if you add the PCI allocation code I cover in the
above paper, you can then have things like two kernels independently
managing, for example, two seperate sets of ethernet card and SCSI disk.
There's some pretty cool stuff to be done here, away from the simple
virtual devices. You could also have a virtual ethernet layer which is
shared by all OS images, and then have a private network between all
OS instances. With Adeos, you can also have one kernel take care of
all hard-rt operations and another kernel take care of the soft-rt
operations. All of it is fairly hardware independent.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546

