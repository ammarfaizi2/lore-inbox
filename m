Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129059AbRBMTo3>; Tue, 13 Feb 2001 14:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129098AbRBMToU>; Tue, 13 Feb 2001 14:44:20 -0500
Received: from mx.interplus.ro ([193.231.252.3]:35081 "EHLO mx.interplus.ro")
	by vger.kernel.org with ESMTP id <S129059AbRBMToP>;
	Tue, 13 Feb 2001 14:44:15 -0500
Message-ID: <3A898EDE.8A8ED25F@interplus.ro>
Date: Tue, 13 Feb 2001 21:45:34 +0200
From: Mircea Ciocan <mirceac@interplus.ro>
Organization: Home Office
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-ac10 i686)
X-Accept-Language: ro, en
MIME-Version: 1.0
To: Linux-kernel@vger.kernel.org
Subject: Issues with parport/parport_pc/lp
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

	Yesterday I see a request for help from the cups printing system
mentainer:
http://linuxtoday.com/news_story.php3?ltsn=2001-02-12-009-04-OS-CY-HW
	Basicly it ask you to read the options from the PJL enabled printer you
may have by running this small shell script:

#!/bin/sh
echo "Writing PJL options into opts.txt"
echo -en "\033%-12345X@PJL\r\n@PJL INFO VARIABLES\r\n" > /dev/lp0
sleep 1
echo "Press Ctrl+C"
cat < /dev/lp0 > opts.txt

 on a machine with CONFIG_PRINTER_READBACK enabled, and send the
renamed, non-empty opts.txt to a more intuitive printer_name.txt to
till.kamppeter@gmx.net. (I strongly advise you all to read the link and
do the deed if you like better printing support with Linux)

	I've got a Kyocera FS-800 that is PJL compatible and have 2.4.1ac10
with all the parport and printing stuff compiled as modules, and tryed
running the script.
	Now the issue:
The script partially works only first time when is runned, any other
time it just blocks and wait for Ctrl-C.
If I remove ALL the modules involved (lp, parport_pc, parport, in that
order) it works again once and so on.
It is working only partialy because it only reads a fixed amount of
data, no matter what the printer have to say :(.
	This amount is on my machine ( dual PIII 950, Winbond SUPER-i/o chip,
ECC+EPP dma 3 and irq7 port) always 483 chars.
By booting in the default Mandrake-7.2 kernel (2.2.17-SMP) the script
has a totaly different behaviour:
	It returns different amount of data on each run but is not necessary to
remove and reload the modules and the maximum data amount that I can
read back was 1649 chars.
	I want to know if this issue could be solved with 2.4.x kernels and I'm
available for testing eventual patches.

				Thank you,

				Mircea C.
