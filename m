Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261834AbTCGWlS>; Fri, 7 Mar 2003 17:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261829AbTCGWlR>; Fri, 7 Mar 2003 17:41:17 -0500
Received: from s383.jpl.nasa.gov ([137.78.170.215]:42977 "EHLO
	s383.jpl.nasa.gov") by vger.kernel.org with ESMTP
	id <S261813AbTCGWlP>; Fri, 7 Mar 2003 17:41:15 -0500
Message-ID: <3E692281.10906@jpl.nasa.gov>
Date: Fri, 07 Mar 2003 14:51:45 -0800
From: Bryan Whitehead <driver@jpl.nasa.gov>
Organization: Jet Propulsion Laboratory
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en, zh, zh-cn, zh-hk, zh
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-newbie@vger.kernel.org
Subject: devfs + PCI serial card = no extra serial ports
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems devfsd has an annoying "feature". I bought a PCI card to get a 
couple (2) more serial ports. The kernel doesn't seem to set up the 
serial ports at boot, so devfs never creates an entry. However, post 
boot, since there is no entries, I cannot configure the serial ports 
with setserial. So basically devfsd = no PCI based serial add on?

03:05.0 Serial controller: NetMos Technology 222N-2 I/O Card (2S+1P) 
(rev 01) (prog-if 02 [16550])
	Subsystem: LSI Logic / Symbios Logic (formerly NCR): Unknown device 0002
	Flags: medium devsel, IRQ 17
	I/O ports at ecf8 [size=8]
	I/O ports at ece8 [size=8]
	I/O ports at ecd8 [size=8]
	I/O ports at ecc8 [size=8]
	I/O ports at ecb8 [size=8]
	I/O ports at eca0 [size=16]


mknod ttyS2 c 4 66
mknod ttyS3 c 4 67
setserial ttyS2 port 0xecf8 UART 16550A irq 17 Baud_base 9600
setserial ttyS3 port 0xece8 UART 16550A irq 17 Baud_base 9600

I hoped after "setting up" the serial ports with setserial some magic 
would happen and they would apear in /dev/tts... but I was wrong.

gets me working serial ports... but it's not in /dev... :O

Am I just screwed?

If so, what would be a good add on PCI based solution for more serial 
ports that WORKS with devfsd? (I don't want to disable devfs as this 
opens up a different set of problems)

Thanks for any replay!

-- 
Bryan Whitehead
SysAdmin - JPL - Interferometry Systems and Technology
Phone: 818 354 2903
driver@jpl.nasa.gov

