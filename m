Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbTJXPOe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 11:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbTJXPOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 11:14:34 -0400
Received: from main.gmane.org ([80.91.224.249]:5774 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262283AbTJXPOb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 11:14:31 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: [PM][ACPI] No ACPI interrupts after resume from S1
Date: Fri, 24 Oct 2003 17:14:25 +0200
Message-ID: <yw1xbrs6652m.fsf@kth.se>
References: <20031020141512.GA30157@hell.org.pl> <yw1x8yngj7xg.fsf@users.sourceforge.net>
 <20031020184750.GA26154@hell.org.pl> <yw1xekx7afrz.fsf@kth.se>
 <20031023082534.GD643@openzaurus.ucw.cz> <yw1xr813f1a3.fsf@kth.se>
 <3F98FDDF.1040905@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:iOshajCOrjpHlKFs3k24o56HVP4=
Cc: acpi-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <piggin@cyberone.com.au> writes:

>>I've been trying the new suspend to disk implementation (pmdisk, I
>>think) lately.  I get these lines in the kernel log when starting
>>after a suspend:
>>
>>PM: Reading pmdisk image.
>>PM: Resume from disk failed.
>>ACPI: (supports S0 S1 S3 S4 S5)
>>
>>Last time I tried swsusp, I did pass the resume= option, but it didn't
>>work.
>>
>>Could it be that some disk cache is never flushed properly?
>>Occasionally, some random filesystem is reported as not being cleanly
>>unmounted when booting normally, which seems to point in the same
>>direction.
>>
>
> Try turning your disk cache off, or set it to write through caching
> (even so I heard some IDE drives don't turn it off anyway!). See if
> it helps.

That took me one step further.  Now it loaded the image swap, but them
immediately rebooted.  I didn't have time to see if there were any
error messages.  I don't have a serial port, so I can't put a console
there.  This was with lots of modules loaded, so maybe unloading some
would help.  Are there any known broken drivers in this list:

Module                  Size  Used by
ide_cd                 36612  0 
cdrom                  32160  1 ide_cd
evdev                   7808  1 
ipv6                  226496  12 
iptable_filter          2304  1 
ip_tables              15616  1 iptable_filter
sis_agp                 4224  1 
agpgart                25896  1 sis_agp
ohci_hcd               16128  0 
usbcore                94940  3 ohci_hcd
snd_intel8x0           28164  0 
snd_ac97_codec         50948  1 snd_intel8x0
snd_pcm                84004  1 snd_intel8x0
snd_timer              20996  1 snd_pcm
snd_page_alloc          9092  2 snd_intel8x0,snd_pcm
snd_mpu401_uart         6144  1 snd_intel8x0
snd_rawmidi            19616  1 snd_mpu401_uart
snd                    43364  6 snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi
soundcore               7104  1 snd
ohci1394               31112  0 
ieee1394               68396  1 ohci1394
sis900                 16516  0 
crc32                   4096  1 sis900
ds                     10884  4 
yenta_socket           14336  0 
pcmcia_core            60768  2 ds,yenta_socket
rtc                    10552  0 

In case it matters, sisfb is compiled into the kernel.

-- 
Måns Rullgård
mru@kth.se

