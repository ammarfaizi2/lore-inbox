Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbTI3TYo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 15:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbTI3TYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 15:24:43 -0400
Received: from mtaw4.prodigy.net ([64.164.98.52]:57809 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S261692AbTI3TYl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 15:24:41 -0400
Message-ID: <3F79D9E4.4060701@pacbell.net>
Date: Tue, 30 Sep 2003 12:30:44 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Arkadiusz Miskiewicz <arekm@pld-linux.org>
CC: Johannes Erdfelt <johannes@erdfelt.com>, Greg KH <greg@kroah.com>,
       Milton Miller <miltonm@bga.com>, linux-kernel@vger.kernel.org
Subject: Re: USB problem. 'irq 9: nobody cared!' (FIXED!)
References: <200309242257.h8OMvR5d090443@sullivan.realtime.net> <20030925180020.GB28876@kroah.com> <3F733DF1.7010008@pacbell.net> <200309301141.18595.arekm@pld-linux.org>
In-Reply-To: <200309301141.18595.arekm@pld-linux.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arkadiusz Miskiewicz wrote:
> On Thursday 25 of September 2003 21:11, David Brownell wrote:
> 
> 
>>The problem is that nobody has ever reported back with results from
>>testing any updated patch (see attachment, the guts of this being
>>from Alan Stern).  Sort of makes trying be a moot point ... :)
> 
> So I'm the first one? ;)

Since then I got mixed reports -- not sure I trust them.


> Your patch (http://www.ussg.iu.edu/hypermail/linux/kernel/0309.3/0341.html) 
> FIXES things for me :-)

OK, that's good to hear.  There are two patches that seem
to work to various degrees.  This isn't the least conservative
fix (that'd be http://lkml.org/lkml/2003/9/29/74, returning
to that odd "reset before kicking bios off" sequence) but it's
good to know this also behaves.

- Dave



> This time I've tried 2.6.0test6 + all acpi patches from 2.6.0-mm1 (ls *acpi* 
> in akpm broken-out directory) + your patch and things work fine :)
> Note that 2.6.0+all acpi patches from 2.6.0-mm1 without your patch doesn't 
> work.
> 
> [arekm@mobarm arekm]$ cat /proc/interrupts
>            CPU0
>   0:     698946          XT-PIC  timer
>   1:       1712          XT-PIC  i8042
>   2:          0          XT-PIC  cascade
>   3:       1561          XT-PIC  irda0
>   5:          4          XT-PIC  yenta
>   8:          0          XT-PIC  rtc
>   9:       2657          XT-PIC  acpi, eth0
>  10:      77708          XT-PIC  VIA686A, uhci-hcd, uhci-hcd
>  12:         18          XT-PIC  i8042
>  14:      12408          XT-PIC  ide0
>  15:         20          XT-PIC  ide1
> NMI:          0
> ERR:          0
> 
> More details about my case in lkml archives and 
> http://bugme.osdl.org/show_bug.cgi?id=905
> 
> 
>>It's OK with me if you just revert the patch that adds a uhci_reset()
>>entry, but based on what I saw with EHCI and OHCI that'll just turn
>>up a different set of problems with certain BIOS configurations (none
>>of which I have) ... which will need to be fixed by having a UHCI
>>reset sequence that works correctly from _all_ initial states.
>>
>>- Dave
> 
> 


