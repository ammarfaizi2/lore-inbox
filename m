Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264271AbTH1WJx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 18:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264317AbTH1WJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 18:09:53 -0400
Received: from k-kdom.nishanet.com ([65.125.12.2]:53003 "EHLO
	mail2k.k-kdom.nishanet.com") by vger.kernel.org with ESMTP
	id S264271AbTH1WJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 18:09:48 -0400
Message-ID: <3F4E7AAB.20303@boxho.com>
Date: Thu, 28 Aug 2003 17:56:59 -0400
From: Resident Boxholder <resid@boxho.com>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: undisclosed-recipients:;
Subject: Re: how to log reiser and raid0 crash? 2.6.0-t4
References: <785F348679A4D5119A0C009027DE33C105CDAFC0@mcoexc04.mlm.maxtor.com>
In-Reply-To: <785F348679A4D5119A0C009027DE33C105CDAFC0@mcoexc04.mlm.maxtor.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://www.promise.com/product/product_detail_eng.asp?productId=87&familyId=3
promise bios flash page--
http://www.promise.com/support/download/download2_eng.asp?productId=87&category=bios&os=100
wget this bios flash if today--(will try later tonight)
http://www.promise.com/support/file/bios/ultra133tx2b220015.zip

Mudama, Eric wrote:

>LBA48 shouldn't affect 60GB drives.
>
>To my understanding, it is only an issue with drives >137GB (128GiB) that
>are moved to some controllers (promise?) after being used on other systems.
>
>--eric
>
True, but I think Alan Cox mentioned something about new code setting 
pio4 and udma6
at the same time so I was hoping new code might relate to system hangs 
on mkfs, fsck,
cp to raid on commodity-promise-controlled drives. I might try the lba48 
patch on a
null-modem serial setup in case there's other code in there. I could use 
a promise
sx-6000 according to Oliver Pitzeier oliver@linux-kernel.at (see below) 
but that's
an expensive onboard raid card, not commodity booty using linux software 
raid.
Lost time moots the expense issue but commodity servers need a cheap 
reliable controller
card, a tulip equivalent in the controller card category, to make a 
cheap net-speed
file-server.
-Bob D

>2.6.0-t4 amd 3000+ 1G four maxtor 60G drives on two 
>> controllers(mb's and promise)
>
As I always tell my customers: Promise means trouble; At least within Linux.

The only Promise controller that works fine for me is a SX-6000 with 6 drives (raid-5, 1 spare).

Best regards,
 Oliver








>
>-----Original Message-----
>From: Resident Boxholder [mailto:resid@boxho.com]
>Sent: Thursday, August 28, 2003 1:29 AM
>To: Oleg Drokin
>Subject: Re: how to log reiser and raid0 crash? 2.6.0-t4
>
>
>2.6.0-t4 amd 3000+ 1G four maxtor 60G drives on two controllers(mb's and 
>promise)
>
>problem isolated to promise card(have to verify the other is error-free 
>longer though)
>
>Oleg Drokin wrote:
>
>  
>
>>Hello!
>>
>>On Tue, Aug 26, 2003 at 03:57:39PM -0400, Resident Boxholder wrote:
>>
>> 
>>
>>    
>>
>>>I cause a lock up by doing a cp -aR /usr/src /mnt/usr...
>>>   
>>>
>>>      
>>>
>>Is there any chance of using sirial console to see if you can capture
>>    
>>
>something on that?
>  
>
>>Bye,
>>   Oleg
>>
>>    
>>
>I have a second linux pc and I can google whether to use null or regular 
>serial cable,
>howto put a console on serial, then log to that, I guess that's all. As 
>a bonus I won't
>need a kvm switch anymore.
>
>Here's some repeatable "high-level(monkey-level)" info.
>
>I have four drives, two on mboard controller and two on a 133 Promise card.
>If I make a four-drive four-partition raid zero md device, I get enough 
>lockups
>to draw my attention, so then I make two-drive md devices to see which
>controller works, if any. Without really flogging it I got ext2 and 
>reiserfs on
>the mboard's two drives to work for mkfs, fsck, and copy /usr/src/ /tmp
>so maybe this is a Promise problem. The mboard controller handles udma6
>no problem for that two-drive md.
>
>With only two drives on the promise card forming a raid zero md device,
>crashes happen on mkfs and fscks and even though no md's are mounted
>on boot, the boot won't happen sometimes after a crash.
>
>I have no errors logging anymore. The only one I got was by switching to
>vc/5 and seeing reiserfs info but I don't see that anymore since fixing one
>thing, it was because of mdadm and debian config conflict, forget that.
>The irq error storm was a false lead as well, no more such errors, no
>errors at all logged, since removing cd's and second promise card and
>turning usb off and turning apic off in bios and letting linux turn apic on.
>ACPI is smooth, no errors, just sudden death.
>
>Things I've tried are no fastrak in promise kernel config, hdparm no dma,
>hdparm udma4 instead of udma6. I'll try pio4 pio3 on the promise md
>and really flog the mboard-controlled md to verify that there is no
>problem except on the promise card. I'm reading what Alan Cox is
>saying about "LBA48 pio and udma" so I will try turning dma off
>and going down in pio modes.
>
>Swap is working with four drives, so two on the promise card, but with 1G of
>ram swap on the promise card may never be used.
>
>-Bob D
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>

