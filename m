Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbUCVKQf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 05:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261866AbUCVKQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 05:16:35 -0500
Received: from postfix4-1.free.fr ([213.228.0.62]:715 "EHLO postfix4-1.free.fr")
	by vger.kernel.org with ESMTP id S261869AbUCVKQa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 05:16:30 -0500
Message-ID: <405EBCF1.4010403@free.fr>
Date: Mon, 22 Mar 2004 11:16:17 +0100
From: Eric Valette <eric.valette@free.fr>
Reply-To: eric.valette@free.fr
Organization: HOME
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040116
X-Accept-Language: en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: akpm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.5-rc2-mm1 does not boot. 2.6.5-rc1-mm2 + small fix from axboe
 was fine
References: <405DFA02.8090504@free.fr> <Pine.LNX.4.58.0403211550430.28727@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.58.0403211550430.28727@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> On Sun, 21 Mar 2004, Eric Valette wrote:
> 
>> System starts but hang just before giving hand to init, sometimes I see
>>
>> Mounted devfs on /dev <=== Hangs here
>> Freeing unused kernel memory: 216k freed
>>
>> Sometimes it goes a little bit further but hangs nearly at calling 
>> init...
>>
>> Is there something tagged __init that should not be? Or does some of the
>> new SCSI stuff breaks (swap on sda1, ...).
>>
>> Keyboard still gets interrupt (CAPS lock led), but nothing happens. Like
>> if there was a deadlock. No kdbg...
> 
> 
> initramfs-search-for-init.patch
> 
> That patch may be freeing initmem before you get to prepare_namespace()

After a sleep, I build up a clean 2.6.5-rc2-mm1, removed the two 
initramfs-* from the broken-out patches, and problem looks *quite* the same.

I managed to start init, but it fails somewhere in running scripts in 
rcS.d. I have :

README                S30checkfs.sh       S40networking
S01devfsd             S30etc-setserial    S41portmap
S02mountvirtfs        S30procps.sh        S45mountnfs.sh
S05bootlogd           S35devpts.sh        S46setserial
S05keymap.sh          S35mountall.sh      S48console-screen.sh
S09scsitools-pre.sh   S35mountkernfs      S50hwclock.sh
S10checkroot.sh       S38pppd-dns         S51ntpdate
S18hwclockfirst.sh    S39dns-clean        S55bootmisc.sh
S20dns-clean          S39ifupdown         S55urandom
S20module-init-tools  S39pppstatus-clean  S70nviboot
S20modutils           S40hostname.sh      S70xfree86-common
S22scsitools.sh       S40hotplug          S75sudo

I see *sometimes* the first devfsd message but almost nothing else. I 
think I also manage to partially initialize usbdevfs on /proc/bus/usb. 
It looks like due to an asynchronuous (irq) event, something deadlocks 
the machine.

-- 
    __
   /  `                   	Eric Valette
  /--   __  o _.          	6 rue Paul Le Flem
(___, / (_(_(__         	35740 Pace

Tel: +33 (0)2 99 85 26 76	Fax: +33 (0)2 99 85 26 76
E-mail: eric.valette@free.fr



