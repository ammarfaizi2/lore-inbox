Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbTIOUK3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 16:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbTIOUK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 16:10:29 -0400
Received: from k-kdom.nishanet.com ([65.125.12.2]:35600 "EHLO
	mail2k.k-kdom.nishanet.com") by vger.kernel.org with ESMTP
	id S261567AbTIOUKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 16:10:18 -0400
Message-ID: <3F6619C0.5020009@boxho.com>
Date: Mon, 15 Sep 2003 15:57:52 -0400
From: Resident Boxholder <resid@boxho.com>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Debugging hard lockups (hardware?): Power Supply!
References: <3E8FC9FB.A030ACFB@vtc.edu.hk> <1049654048.1600.11.camel@dhcp22.swansea.linux.org.uk> <3F657CFD.96B5E974@vtc.edu.hk>
In-Reply-To: <3F657CFD.96B5E974@vtc.edu.hk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

faq's for acpi and ide and no-ping or unrecognized ethernet problems,
seek error, random crash

When it seems like there's a bug in hardware or linux but it's just no acpi
id, default code runs slower, timing issues crop up, something breaks,
kill the scapegoats(swap cards, motherboards, try all config/kern opts,
ebay 3ware).

Power supply was the first thing I replaced, going to a 550w Coolmax
with the 3 amp 5v standby voltage.

The second thing one should do is flash bios. If bios acpi does not
recognize hardware id's, linux reasonable defaults institute pretty good
alright solutions which are slower than ideal, and on a system faster than
133fsb and 1ghz cpu that's enough to cause io to miss the love boat
with regard to resources and anything relating to timing.

memtest86

I set aside a pile of Promise cards, tried a SiI680, got almost there by
setting all options that allowed more time for dma resources to become
available. That got me pretty stable, but the bios flash I should have
done first finished the job, proper acpi hardware id's making all the
fastest code available so dma resources came available soon
enough.

Options that may improve stability are--
  --don't use acpi=off
  --don't use pci=noacpi
  --don't go back to a previous kernel
  --cmos setup apic off, let linux activate apic
  --don't oc or push memory before stable(somebody)
  --kernel local apic on, but try sub-option ioapic off if you
       can't ping through your ethernet onboard or card or
       you see garbage scrolling on boot or you have random
        freeze-ups
  --kernel opt try anticipatory-scheduling instead of
     deadline scheduling for more time for ide ops to live
  --cmos pci-delay transaction and hdparm -u1 to unmask
      irq would buy time but can't do with sii680 or cmd640
  --hdparm -d1 -c1 -p9 -X70 -u0 drive on sii680, pio9 is
     a special escape pseudo-mode for sii680, probably -p9
     just says "-d1 -c1 -u0 -p4", redundancy doesn't hurt
  --turn off unused usb, parallell, audio, acpi sleep and
     battery options, anything you don't need, at least until
     you get the system stable
  --3ware cards are cheap on ebay! try everything else first
     or you may be disappointed by throwing money at
     problems. success can strike at any moment--my
     3ware card is still in the mail but system passes
     bonnie++ and cp -aR /usr /tmp [different md's]

-Bob

Nick Urbanik wrote:

>Dear Folks,
>
>Alan Cox wrote:
>
>  
>
>>On Sul, 2003-04-06 at 07:32, Nick Urbanik wrote:
>>    
>>
>>>This machine locks up solid every few days.  Caps Lock, Num Lock, Scroll Lock do
>>>not respond.  The NMI watchdog does not kick in.
>>>      
>>>
>>For the NMI watchdog to fail (if you have it enabled) requires pretty
>>major disaster to have occurred since the NMI will be delivered through
>>any kind of system hang
>>
>>    
>>
>>>I guess hardware.  But memtest run exhaustively shows no problem.
>>>      
>>>
>>Memory errors normally generate "Oops" type lines rather than other
>>stuff
>>
>>    
>>
>>>I have six 80 G IDE disks, software RAID, LVM on top.  On Red Hat 8.0 and 9.
>>>
>>>Any hints on how to troubleshoot this (besides replacing motherboard and other
>>>components I cannot afford to replace?)
>>>      
>>>
>>Is your PSU up to scratch for six disks ?
>>    
>>
>
>It seems that the 470W ToTheMax power supply was the problem, though I've not tested
>for more than 17 hours yet.
>
>Yesterday, after adding two disks to the motherboard IDE together with the new 3ware
>7506-8 with 8 x 80G disks (a total of 10 disks), the 3ware RAID 5 unit refused to
>rebuild.  Then I noticed that many dma timeout messages appeared in the logs for all
>the disks.  I promptly shut the system down, took my little boy Linus for a walk to
>the fabled Golden Shopping Center and bought an Antec 550W supply, plus a few more
>case fans.  The 3ware RAID5 unit, and also the kernel md RAID1 built nicely.  So far
>no dma_intr messages have appeared (and it has not locked up).
>
>I wish I had changed the power supply before buying the 3ware card so that I could
>find out whether the Si680 cards were okay or not!  HK$135 * 3 <<< HK$3800 (comparing
>price of 3 Si680 cards with one 3ware 7506-8).  Unfortunately the disks cannot be
>moved from the 3ware back to the Si680s without another mighty backup and restore.
>
>  
>
>>>/dev/md3:
>>> Timing buffer-cache reads:   128 MB in  0.35 seconds =365.71 MB/sec
>>> Timing buffered disk reads:  64 MB in 21.93 seconds =  2.92 MB/sec
>>>(last horribly. slow; get zillions of lines in syslog saying stuff like:
>>>Apr  6 14:08:50 nicksbox kernel: raid5: switching cache buffer size, 0 --> 4096
>>>Apr  6 14:08:50 nicksbox kernel: raid5: switching cache buffer size, 0 --> 1024
>>>Apr  6 14:08:50 nicksbox kernel: raid5: switching cache buffer size, 1024 -->
>>>      
>>>
>>Im not sure what this one indicates actually
>>
>>    
>>
>>>Any pointers to web sites, information that may help, any hints, suggestions,
>>>ideas,... all most welcome.  Actually, if replacing the motherboard would fix
>>>it, I'd do it, but I cannot guess why it should help; Asus motherboards have
>>>always been good to me before.
>>>      
>>>
>>Your choice of components looks fine, its all stuff I trust, even if the
>>ethernet card is not good for performance it ought to be fine in
>>general. If it is a faulty part most likely its a one off fault.
>>
>>Which bits of the system are not being used (sound, video, network ?)
>>    
>>
>
>--
>Nick Urbanik   RHCE                               nicku(at)vtc.edu.hk
>Dept. of Information & Communications Technology
>Hong Kong Institute of Vocational Education (Tsing Yi)
>Tel:   (852) 2436 8576, (852) 2436 8713          Fax: (852) 2436 8526
>PGP: 53 B6 6D 73 52 EE 1F EE EC F8 21 98 45 1C 23 7B     ID: 7529555D
>GPG: 7FFA CDC7 5A77 0558 DC7A 790A 16DF EC5B BB9D 2C24   ID: BB9D2C24
>
>
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

