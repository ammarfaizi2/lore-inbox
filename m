Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280200AbRKIWI3>; Fri, 9 Nov 2001 17:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280228AbRKIWIT>; Fri, 9 Nov 2001 17:08:19 -0500
Received: from [195.66.192.167] ([195.66.192.167]:34579 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S280200AbRKIWIL>; Fri, 9 Nov 2001 17:08:11 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Robert Love <rml@tech9.net>
Subject: Re: [PATCH] Adding KERN_INFO to some printks #2
Date: Sat, 10 Nov 2001 00:07:58 +0000
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01110913474600.02130@nemo> <01110923204702.00807@nemo> <1005342348.808.18.camel@phantasy>
In-Reply-To: <1005342348.808.18.camel@phantasy>
MIME-Version: 1.0
Message-Id: <01111000075801.07593@nemo>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 November 2001 21:45, Robert Love wrote:
> I went over the patch and found a few things...
>
> printk(KERN_INFO "No local APIC present or hardware disabled\n");
>
>  I'd make this a KERN_WARNING.  Consider the case where I compile my own
> kernel and I add APIC support.  If the driver is failing to find my APIC
> then either (a) my BIOS is broken or (b) I should remove the driver.
> Either way I would want to know.

Ok I'll do

> printk (KERN_WARNING "mtrr: your CPUs had inconsistent fixed MTRR
> printk (KERN_WARNING "mtrr: your CPUs had inconsistent variable MTRR
> printk (KERN_WARNING "mtrr: your CPUs had inconsistent MTRRdefType
> printk (KERN_WARNING "mtrr: probably your BIOS does not setup all
>
>  These can actually be KERN_INFO, because it is not a problem and the
> mtrr driver fixes the issue.

I'd rather not overdo my patch. Better leave some KERN_WARNINGs where they 
are now than hide something important. I am concentrated on killing
_obviously_ informative msgs.

> There are a _lot_ of printk statements in your patch where you didn't
> add a loglevel.  You modified them for some reason (in many cases to
> change printk("%s" ...) to printk(pf: ...).  You can easily find them
> via a search on `printk("' ... that same search can be a grep to find
> on-specified printks in the whole tree, too :)

I modified printks which were hard to find due to lack of
any greppable [ :-) ] string. Next poor soul will be more lucky :-)

I don't think adding log levels massively is good: I'd like to see
real world bogus warning log files and fix only those ('don't overdo it' 
policy)
--
vda
