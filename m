Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932594AbVHJXNn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932594AbVHJXNn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 19:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932596AbVHJXNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 19:13:43 -0400
Received: from n1.cetrtapot.si ([212.30.80.17]:23793 "EHLO n1.cetrtapot.si")
	by vger.kernel.org with ESMTP id S932595AbVHJXNm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 19:13:42 -0400
Message-ID: <42FA89FE.9050101@cetrtapot.si>
Date: Thu, 11 Aug 2005 01:13:02 +0200
From: Hinko Kocevar <hinko.kocevar@cetrtapot.si>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jean Delvare <khali@linux-fr.org>
Cc: LM Sensors <lm-sensors@lm-sensors.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: I2C block reads with i2c-viapro: testers wanted
References: <20050809231328.0726537b.khali@linux-fr.org>	<42FA6406.4030901@cetrtapot.si> <20050810230633.0cb8737b.khali@linux-fr.org>
In-Reply-To: <20050810230633.0cb8737b.khali@linux-fr.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Delvare wrote:
> 
> Could you try running "i2cdump 0 0x50" and "i2cdump 0 0x50 i" (with the
> patch still applied), and compare both the outputs and the time each
> command takes? You should see similar outputs, but the second command
> should be magnitudes faster. This would confirm that the I2C block mode
> works as intended on your VT8233 chip.

Hmm, not really. Here it takes 6 seconds for the first test nad about 5 seconds 
for the second test (I just read the WARNING - need to substract 5s from the 
results...).

noa xtrm # time i2cdump 0 0x50
No size specified (using byte-data access)
   WARNING! This program can confuse your I2C bus, cause data loss and worse!
   I will probe file /dev/i2c-0, address 0x50, mode byte
   You have five seconds to reconsider and press CTRL-C!

      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 80 08 07 0d 09 02 40 00 04 75 75 00 82 10 00 01    ??????@.?uu.??.?
10: 0e 04 0c 01 02 20 00 a0 75 00 00 50 3c 50 2d 20    ????? .?u..P<P-
20: 90 90 50 50 00 00 00 00 00 00 00 00 00 00 00 00    ??PP............
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 a7    ...............?
40: ce 00 00 00 00 00 00 00 01 4d 34 20 37 30 4c 33    ?.......?M4 70L3
50: 32 32 34 44 54 30 2d 43 42 30 20 30 44 02 51 45    224DT0-CB0 0D?QE
60: 0b c8 db 00 4c 39 41 37 43 33 4e 00 00 00 00 00    ???.L9A7C3N.....
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
80: 00 20 12 02 22 07 ff ff ff ff ff 18 04 16 ff ff    . ??"?.....???..
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................

real	0m6.033s
user	0m0.000s
sys	0m0.004s
noa xtrm # time i2cdump 0 0x50 i
   WARNING! This program can confuse your I2C bus, cause data loss and worse!
   I will probe file /dev/i2c-0, address 0x50, mode i2c block
   You have five seconds to reconsider and press CTRL-C!

      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 80 08 07 0d 09 02 40 00 04 75 75 00 82 10 00 01    ??????@.?uu.??.?
10: 0e 04 0c 01 02 20 00 a0 75 00 00 50 3c 50 2d 20    ????? .?u..P<P-
20: 90 90 50 50 00 00 00 00 00 00 00 00 00 00 00 00    ??PP............
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 a7    ...............?
40: ce 00 00 00 00 00 00 00 01 4d 34 20 37 30 4c 33    ?.......?M4 70L3
50: 32 32 34 44 54 30 2d 43 42 30 20 30 44 02 51 45    224DT0-CB0 0D?QE
60: 0b c8 db 00 4c 39 41 37 43 33 4e 00 00 00 00 00    ???.L9A7C3N.....
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
80: 00 20 12 02 22 07 ff ff ff ff ff 18 04 16 ff ff    . ??"?.....???..
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................

real	0m5.174s
user	0m0.001s
sys	0m0.002s

while simple cat takes a lot less time:
noa xtrm # time dd if=/sys/bus/i2c/devices/0-0050/eeprom bs=4 | hexdump -C
00000000  80 08 07 0d 09 02 40 00  04 75 75 00 82 10 00 01  |......@..uu.....|
00000010  0e 04 0c 01 02 20 00 a0  75 00 00 50 3c 50 2d 20  |..... ..u..P<P- |
00000020  90 90 50 50 00 00 00 00  00 00 00 00 00 00 00 00  |..PP............|
00000030  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 a7  |................|
00000040  ce 00 00 00 00 00 00 00  01 4d 34 20 37 30 4c 33  |.........M4 70L3|
00000050  32 32 34 44 54 30 2d 43  42 30 20 30 44 02 51 45  |224DT0-CB0 0D.QE|
00000060  0b c8 db 00 4c 39 41 37  43 33 4e 00 00 00 00 00  |....L9A7C3N.....|
00000070  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
00000080  00 20 12 02 22 07 ff ff  ff ff ff 18 04 16 ff ff  |. .."...........|
00000090  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
*
64+0 zapisov na vhodu
64+0 zapisov na izhodu
00000100

real	0m0.600s
user	0m0.002s
sys	0m0.005s

It seems pretty fast in all cases (i2cdump, i2cdump block and cat) and results 
are close too (taing WARNING delay into account).

regards,
hinko k
-- 
..because under Linux "if something is possible in principle,
then it is already implemented or somebody is working on it".

					--LKI
