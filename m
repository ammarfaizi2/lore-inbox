Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263831AbTH1Hla (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 03:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263842AbTH1Hla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 03:41:30 -0400
Received: from k-kdom.nishanet.com ([65.125.12.2]:62472 "EHLO
	mail2k.k-kdom.nishanet.com") by vger.kernel.org with ESMTP
	id S263831AbTH1Hl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 03:41:26 -0400
Message-ID: <3F4DAF33.3030506@boxho.com>
Date: Thu, 28 Aug 2003 03:28:51 -0400
From: Resident Boxholder <resid@boxho.com>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oleg Drokin <green@namesys.com>
Subject: Re: how to log reiser and raid0 crash? 2.6.0-t4
References: <20030826102233.GA14647@namesys.com> <1061922037.1670.3.camel@spc9.esa.lanl.gov> <20030826182609.GO5448@backtop.namesys.com> <1061926566.1076.2.camel@teapot.felipe-alfaro.com> <3F4BBBB3.2080100@boxho.com> <20030827103523.GA30728@namesys.com>
In-Reply-To: <20030827103523.GA30728@namesys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.0-t4 amd 3000+ 1G four maxtor 60G drives on two controllers(mb's and 
promise)

problem isolated to promise card(have to verify the other is error-free 
longer though)

Oleg Drokin wrote:

>Hello!
>
>On Tue, Aug 26, 2003 at 03:57:39PM -0400, Resident Boxholder wrote:
>
>  
>
>>I cause a lock up by doing a cp -aR /usr/src /mnt/usr...
>>    
>>
>
>Is there any chance of using sirial console to see if you can capture something on that?
>
>Bye,
>    Oleg
>
I have a second linux pc and I can google whether to use null or regular 
serial cable,
howto put a console on serial, then log to that, I guess that's all. As 
a bonus I won't
need a kvm switch anymore.

Here's some repeatable "high-level(monkey-level)" info.

I have four drives, two on mboard controller and two on a 133 Promise card.
If I make a four-drive four-partition raid zero md device, I get enough 
lockups
to draw my attention, so then I make two-drive md devices to see which
controller works, if any. Without really flogging it I got ext2 and 
reiserfs on
the mboard's two drives to work for mkfs, fsck, and copy /usr/src/ /tmp
so maybe this is a Promise problem. The mboard controller handles udma6
no problem for that two-drive md.

With only two drives on the promise card forming a raid zero md device,
crashes happen on mkfs and fscks and even though no md's are mounted
on boot, the boot won't happen sometimes after a crash.

I have no errors logging anymore. The only one I got was by switching to
vc/5 and seeing reiserfs info but I don't see that anymore since fixing one
thing, it was because of mdadm and debian config conflict, forget that.
The irq error storm was a false lead as well, no more such errors, no
errors at all logged, since removing cd's and second promise card and
turning usb off and turning apic off in bios and letting linux turn apic on.
ACPI is smooth, no errors, just sudden death.

Things I've tried are no fastrak in promise kernel config, hdparm no dma,
hdparm udma4 instead of udma6. I'll try pio4 pio3 on the promise md
and really flog the mboard-controlled md to verify that there is no
problem except on the promise card. I'm reading what Alan Cox is
saying about "LBA48 pio and udma" so I will try turning dma off
and going down in pio modes.

Swap is working with four drives, so two on the promise card, but with 1G of
ram swap on the promise card may never be used.

-Bob D

