Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937701AbWLFWCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937701AbWLFWCI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 17:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937695AbWLFWCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 17:02:08 -0500
Received: from enyo.dsw2k3.info ([195.71.86.239]:47577 "EHLO enyo.dsw2k3.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937701AbWLFWCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 17:02:07 -0500
Message-ID: <45773DD2.10201@citd.de>
Date: Wed, 06 Dec 2006 23:01:54 +0100
From: Matthias Schniedermeyer <ms@citd.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217 Mnenhy/0.7
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
Subject: single bit errors on files stored on USB-HDDs via USB2/usb_storage
Content-Type: multipart/mixed;
 boundary="------------040402040700000402010603"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040402040700000402010603
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi


I'm using a Bunch auf HDDs in USB-Enclosures for storing files.
(currently 38 HDD, with a total capacity of 9,5 TB of which 8,5 TB is used)

After i realised about a year(!) ago that the files copied to the HDDs
sometimes aren't identical to the "original"-files i changed my
procedured so that each file is MD5 before and after and deleted/copied
again if an error is detected.

My averate file size is about 1GB with files from about 400MB to 5000MB
I estimate the average error-rate at about one damaged file in about
10GB of data.

I'm not sure and haven't checked if the files are wrongly written or
"only" wrongly read back as i delete the defective files and copy them
again.

Today i copied a few files back and checked them against the stored MD5
sums and 5 files of 86 (each about 700 MB) had errors. So i copied the 5
files again. 4 of the files were OK after that and coping the last file
the third time also resulted in the correct MD5.

This time i kept the defective files and used "vbindiff" to show me the
difference. Strangly in EVERY case the difference is a single bit in a
sequence of "0xff"-Bytes inside a block of varing bit-values that
changed a "0xff" into a "0xf7".
Also interesting is that each error is at a 0xXXXXXXX5-Position

Attached is a file with 5 of the 6 differences named 1-5. Of each of the
5 2x3 lines-blocks the first 3 lines are the original the following 3
lines contain the error in the middle row 6th value.

NEVER did i see any messages in syslog regarding erros or an aborting
program due to errors passed down from the kernel or something like that.

Data for the computer/software:
Hardware:
Computer is a Dual P3-933Mhz with 3GB (ECC) SD-RAM, Severworks HE-SL-Chipset
Source-HDD is a 200GB S-ATA device connected to a Promise TX-4 using libata.
Destination-HDDs: Several different models in several different
enclosures and different chipsets, mostly Genesys Logic)
USB-controller: Currently i use a EHCI/OHCI-NEC-Chipset add-on card but
since about 4-5 month ago i used a EHCI/UHCI-VIA-Chipset add-on card
with same results.
Software:
Kernel: <What was current 1 year ago> up to 2.6.18, self compiled
vanilla kernels.
I haven't tried 2.6.19 and i don't expect any changes from it.
Distribution: Debian SID


I you need any other information i will provide them as good as i can.




Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated,
cryptic, powerful, unforgiving, dangerous.


--------------040402040700000402010603
Content-Type: text/plain;
 name="errors.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="errors.txt"

1:
245A E2F0: 0E D9 35 01 00 F4 7B F8  00 00 01 E0 09 00 80 00  ..5...{. ........
245A E300: 0D FF FF FF FF FF FF FF  FF FF FF FF FF FF DF FC  ........ ........
245A E310: 20 92 50 90 DC F4 0C 1A  1A 18 DB 80 4E 61 25 80   .P..... ....Na%.

245A E2F0: 0E D9 35 01 00 F4 7B F8  00 00 01 E0 09 00 80 00  ..5...{. ........
245A E300: 0D FF FF FF FF F7 FF FF  FF FF FF FF FF FF DF FC  ........ ........
245A E310: 20 92 50 90 DC F4 0C 1A  1A 18 DB 80 4E 61 25 80   .P..... ....Na%.

2:
24F9 F770: 00 00 01 E0 09 00 80 00  0D FF FF FF FF FF FF FF  ........ ........
24F9 F780: FF FF FF FF FF FF FC 13  64 0B 38 68 EA A2 11 86  ........ d.8h....
24F9 F790: 61 7A EE EC ED 1D 6F 31  32 6E 4D D9 B5 31 37 66  az....o1 2nM..17f

24F9 F770: 00 00 01 E0 09 00 80 00  0D FF FF FF FF FF FF FF  ........ ........
24F9 F780: FF FF FF FF FF F7 FC 13  64 0B 38 68 EA A2 11 86  ........ d.8h....
24F9 F790: 61 7A EE EC ED 1D 6F 31  32 6E 4D D9 B5 31 37 66  az....o1 2nM..17f

3:
20CB C6B0: 00 FB 3F F8 00 00 01 E0  09 00 80 80 0D 21 2A 1B  ..?..... .....!*.
20CB C6C0: 65 F1 FF FF FF FF FF FF  FF FF 3E C4 BC 2B 39 A4  e....... ..>..+9.
20CB C6D0: 8E 85 50 EB 7B 02 7B 93  79 77 50 EF 60 32 8C 03  ..P.{.{. ywP.`2..

20CB C6B0: 00 FB 3F F8 00 00 01 E0  09 00 80 80 0D 21 2A 1B  ..?..... .....!*.
20CB C6C0: 65 F1 FF FF FF F7 FF FF  FF FF 3E C4 BC 2B 39 A4  e....... ..>..+9.
20CB C6D0: 8E 85 50 EB 7B 02 7B 93  79 77 50 EF 60 32 8C 03  ..P.{.{. ywP.`2..

4:
1F13 06B0: 00 00 01 E0 09 00 80 00  0D FF FF FF FF FF FF FF  ........ ........
1F13 06C0: FF FF FF FF FF FF 7F 5C  14 05 F2 9E 90 0F 6F A4  .......\ ......o.
1F13 06D0: B8 10 BF E9 6A 78 A3 00  13 00 FD 9C 00 A5 5B EB  ....jx.. ......[.

1F13 06B0: 00 00 01 E0 09 00 80 00  0D FF FF FF FF FF FF FF  ........ ........
1F13 06C0: FF FF FF FF FF F7 7F 5C  14 05 F2 9E 90 0F 6F A4  .......\ ......o.
1F13 06D0: B8 10 BF E9 6A 78 A3 00  13 00 FD 9C 00 A5 5B EB  ....jx.. ......[.

5:
1F13 06B0: 00 00 01 E0 09 00 80 00  0D FF FF FF FF FF FF FF  ........ ........
1F13 06C0: FF FF FF FF FF FF 7F 5C  14 05 F2 9E 90 0F 6F A4  .......\ ......o.
1F13 06D0: B8 10 BF E9 6A 78 A3 00  13 00 FD 9C 00 A5 5B EB  ....jx.. ......[.

1F13 06B0: 00 00 01 E0 09 00 80 00  0D FF FF FF FF FF FF FF  ........ ........
1F13 06C0: FF FF FF FF FF F7 7F 5C  14 05 F2 9E 90 0F 6F A4  .......\ ......o.
1F13 06D0: B8 10 BF E9 6A 78 A3 00  13 00 FD 9C 00 A5 5B EB  ....jx.. ......[.


--------------040402040700000402010603--
