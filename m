Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbWE0IMm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbWE0IMm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 04:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbWE0IMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 04:12:42 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.81]:5862 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S1751148AbWE0IMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 04:12:41 -0400
Message-ID: <44780A4B.7090905@cmu.edu>
Date: Sat, 27 May 2006 04:14:03 -0400
From: George Nychis <gnychis@cmu.edu>
User-Agent: Thunderbird 1.5.0.2 (X11/20060503)
MIME-Version: 1.0
To: George Nychis <gnychis@cmu.edu>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: ds.o: init_module: Operation not permitted (no socket drivers
 loaded)
References: <4477E3F3.7060708@cmu.edu> <4477F8B7.9020601@cmu.edu>
In-Reply-To: <4477F8B7.9020601@cmu.edu>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My final response to myself, so no one wastes time trying to help me, I
got it working by building the regular pcmcia support as modules with
the 2.4.32 kernel, then using the latest hostap drivers, and rebooting.

George Nychis wrote:
> 
> George Nychis wrote:
>> Hey guys,
>>
>> I have a prism card that I would like to get working with my 2.4.32
>> kernel.  I installed pcmcia-cs and removed pcmcia support from the
>> kernel, i am not sure if this was the right decision, if not please tell me.
>>
>> So after installing pcmcia_cs, i boot and modprobe pcmcia_core and
>> hostap, then i try to modprobe hostap_cs and i get:
>>
>> [root@emu-5 hostap-driver-0.4.9]# modprobe hostap_cs
>> /lib/modules/2.4.32/pcmcia/ds.o: init_module: Operation not permitted
>> Hint: insmod errors can be caused by incorrect module parameters,
>> including invalid IO or IRQ parameters.
>>       You may find more information in syslog or the output from dmesg
>>
>> So of course I dmesg:
>> ds: no socket drivers loaded!
>>
>> I can successfully get the card to work in my 2.6.9 kernel, here is my
>> lsmod... the only thing i see different is the yenta_socket which I am
>> not sure of:
>> [root@emu-5 ~]# lsmod
>> Module                  Size  Used by
>> parport_pc             24705  1
>> lp                     11565  0
>> parport                41737  2 parport_pc,lp
>> autofs4                24005  0
>> i2c_dev                10433  0
>> i2c_core               22081  1 i2c_dev
>> sunrpc                160421  1
>> hostap_cs              62656  3
>> hostap                117132  1 hostap_cs
>> ds                     16965  3 hostap_cs
>> button                  6481  0
>> battery                 8517  0
>> ac                      4805  0
>> md5                     4033  1
>> ipv6                  232577  10
>> yenta_socket           18753  1
>> pcmcia_core            59913  3 hostap_cs,ds,yenta_socket
>> uhci_hcd               31449  0
>> ehci_hcd               31557  0
>> snd_intel8x0           34829  0
>> snd_ac97_codec         64401  1 snd_intel8x0
>> snd_pcm_oss            47609  0
>> snd_mixer_oss          17217  1 snd_pcm_oss
>> snd_pcm                97993  2 snd_intel8x0,snd_pcm_oss
>> snd_timer              29765  1 snd_pcm
>> snd_page_alloc          9673  2 snd_intel8x0,snd_pcm
>> gameport                4801  1 snd_intel8x0
>> snd_mpu401_uart         8769  1 snd_intel8x0
>> snd_rawmidi            26725  1 snd_mpu401_uart
>> snd_seq_device          8137  1 snd_rawmidi
>> snd                    54053  9
>> snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device
>> soundcore               9889  1 snd
>> tg3                    85445  0
>> dm_snapshot            17029  0
>> dm_zero                 2369  0
>> dm_mirror              23341  2
>> ext3                  116809  2
>> jbd                    74969  1 ext3
>> dm_mod                 54741  6 dm_snapshot,dm_zero,dm_mirror
>> ata_piix                8389  2
>> libata                 40005  1 ata_piix
>> sd_mod                 16961  3
>> scsi_mod              118417  2 libata,sd_mod
>>
>>
>> I'd greatly appreciate any help!
>>
>> Thanks!
>> George
>>
> 
> Alright i'm going to respond to my own post real quick... I built pcmcia
> support into the kernel instead of using pcmcia-cs.  I now get the power
> light on the card light up.  So then I modprobe hostap and hostap_cs
> 
> I see this in dmesg:
> hostap_crypt: registered algorithm 'NULL'
> hostap_cs: 0.4.9 - 2006-05-06 (Jouni Malinen <jkmaline@cc.hut.fi>)
> 
> It also seems to be recognizing a card:
> [root@emu-5 pcmcia]# cardctl info
> PRODID_1="INTERSIL"
> PRODID_2="HFA384x/IEEE"
> PRODID_3="Version 01.02"
> PRODID_4=""
> MANFID=0156,0002
> FUNCID=6
> 
> However i see no wireless interfaces:
> [root@emu-5 pcmcia]# iwconfig
> lo        no wireless extensions.
> 
> eth0      no wireless extensions.
> 
> [root@emu-5 pcmcia]# ifconfig -a
> eth0      Link encap:Ethernet  HWaddr 00:11:43:43:D0:11
>           inet addr:192.168.1.101  Bcast:192.168.1.255  Mask:255.255.255.0
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:705 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:454 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:1000
>           RX bytes:65062 (63.5 KiB)  TX bytes:81096 (79.1 KiB)
>           Interrupt:11
> 
> lo        Link encap:Local Loopback
>           inet addr:127.0.0.1  Mask:255.0.0.0
>           UP LOOPBACK RUNNING  MTU:16436  Metric:1
>           RX packets:8 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:8 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:0
>           RX bytes:560 (560.0 b)  TX bytes:560 (560.0 b)
> 
> Any ideas?
> 
> Thanks!
> George
> 
