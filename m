Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264506AbUAHPMB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 10:12:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265102AbUAHPMB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 10:12:01 -0500
Received: from [200.49.101.40] ([200.49.101.40]:49163 "EHLO mail.skycop.net")
	by vger.kernel.org with ESMTP id S264506AbUAHPLz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 10:11:55 -0500
From: "Nicolas Nilles" <nnilles@skycop.net>
To: <linux-kernel@vger.kernel.org>, <sensors@stimpy.netroedge.com>
Cc: <greg@kroah.com>
Subject: RE: Kernel 2.6.0 and i2c-viapro posible Bug
Date: Thu, 8 Jan 2004 12:11:45 -0300
Message-ID: <OLEKJGKIEPMKIGIPLDBNCELKCDAA.nnilles@skycop.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <20040107223046.093ea670.khali@linux-fr.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
X-Spam-Processed: skycop.net, Thu, 08 Jan 2004 12:12:39 -0300
	(not processed: message from valid local sender)
X-Return-Path: nnilles@skycop.net
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Well with 2.6.1-rc2 Kernel works great, i dont have any kind of problem,
with 2.4.24 i dont try, i gonna try.. today or tomorrow... then i post the
results, but i use it with 2.4.20-gentoo-r9  (gentoo sources) +
i2c+lm-sensors, and it work with no problem at all...
	This is whenni try loading first i2c-viapro and then w82781d and the when i
unload the modules..  the problem persist..
	Without ACPI support in the kernel it happen the same thing...  no mother
whitch module i load first, when i load the 2nd module, stuck... if you want
i send you the dmesg, and code of this test.
	Now i going to download the 2.4.24 Kernel, and then i try with it and send
the results.


root@schoolgirl rem # hdparm -tT /dev/hda

/dev/hda:
 Timing buffer-cache reads:   668 MB in  2.01 seconds = 332.72 MB/sec
 Timing buffered disk reads:   66 MB in  3.05 seconds =  21.64 MB/sec
root@schoolgirl rem # lsmod
Module                  Size  Used by
root@schoolgirl rem # modprobe i2c-viapro
root@schoolgirl rem # lsmod
Module                  Size  Used by
i2c_viapro              4908  0
i2c_core               20836  1 i2c_viapro
root@schoolgirl rem # hdparm -tT /dev/hda

/dev/hda:
 Timing buffer-cache reads:   668 MB in  2.00 seconds = 333.38 MB/sec
 Timing buffered disk reads:   66 MB in  3.05 seconds =  21.62 MB/sec
root@schoolgirl rem # modprobe w83781d
root@schoolgirl rem # lsmod
Module                  Size  Used by
w83781d                33920  0
i2c_sensor              2272  1 w83781d
i2c_viapro              4908  0
i2c_core               20836  3 w83781d,i2c_sensor,i2c_viapro
root@schoolgirl rem # hdparm -tT /dev/hda

/dev/hda:
 Timing buffer-cache reads:   160 MB in  2.03 seconds =  78.64 MB/sec
 Timing buffered disk reads:   56 MB in  3.10 seconds =  18.08 MB/sec
root@schoolgirl rem # modprobe -r w83781d
root@schoolgirl rem # hdparm -tT /dev/hda

/dev/hda:
 Timing buffer-cache reads:   160 MB in  2.01 seconds =  79.46 MB/sec
 Timing buffered disk reads:   56 MB in  3.04 seconds =  18.42 MB/sec
root@schoolgirl rem # modprobe -r i2c_viapro
root@schoolgirl rem # hdparm -tT /dev/hda

/dev/hda:
 Timing buffer-cache reads:   160 MB in  2.03 seconds =  78.95 MB/sec
 Timing buffered disk reads:   56 MB in  3.02 seconds =  18.56 MB/sec
root@schoolgirl rem # lsmod
Module                  Size  Used by
root@schoolgirl rem # hdparm -tT /dev/hda

/dev/hda:
 Timing buffer-cache reads:   164 MB in  2.03 seconds =  80.96 MB/sec
 Timing buffered disk reads:   56 MB in  3.02 seconds =  18.56 MB/sec


root@schoolgirl rem # lspci -n
00:00.0 Class 0600: 1106:0691 (rev c4)
00:01.0 Class 0604: 1106:8598
00:04.0 Class 0601: 1106:0686 (rev 40)
00:04.1 Class 0101: 1106:0571 (rev 06)
00:04.2 Class 0c03: 1106:3038 (rev 16)
00:04.3 Class 0c03: 1106:3038 (rev 16)
00:04.4 Class 0600: 1106:3057 (rev 40)
00:09.0 Class 0200: 10ec:8139 (rev 10)
00:0a.0 Class 0401: 1102:0002 (rev 05)
00:0a.1 Class 0980: 1102:7002 (rev 05)
01:00.0 Class 0300: 10de:0181 (rev a2)




Thanks
Rem

------------
Nicolas Nilles (Rem)

http://schoolgirl.homeunix.net


-----Mensaje original-----
De: Jean Delvare [mailto:khali@linux-fr.org]
Enviado el: miercoles, 07 de enero de 2004 18:31
Para: Nicolas Nilles
CC: linux-kernel@vger.kernel.org; greg@kroah.com;
sensors@stimpy.netroedge.com
Asunto: Re: Kernel 2.6.0 and i2c-viapro posible Bug


> I thinks that thgere is  probably a bug in I2c-viapro module,
> cuz when i load i2c-viapro after loading w82781d, my computer  just
> put very slow..., i try loading as modules in the kernel or built in,
> in both cases i have the same problem.
>
> I use 2.6.0 Vanilla Kernel sources.
> Please i will really apreciate if some one responde to this
> mail, put my adress in the CC field please cuz i not in the LKML.
> If someone need another information about my computer, config..
> or somehting more, just ask for it.
>
> Thanks.

Tested this on my own system with similar hardware (as far as i2c is
concerned) under 2.6.1-rc2. I did not experience any slowdown.

Could you please provide the following information:

* Output of "lspci -n".

* Can you reproduce the problem with a 2.4.24 kernel and i2c+lm_sensors
  2.8.2?

* Can you reproduce the problem with a 2.6.1-rc2 kernel?

* Can you reproduce the problem without ACPI support enabled into your
  kernel?

* Does the slowdown affect only the hard-disk drive?

* Does the speed come back to normal if you remove i2c-viapro?

* Does the slowdown occur if you load i2c-viapro before w83781d?

Yeah, I know, this is much work, but we need a hint to start digging.

Thanks.

--
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

