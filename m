Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261610AbSJNMXg>; Mon, 14 Oct 2002 08:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261611AbSJNMXg>; Mon, 14 Oct 2002 08:23:36 -0400
Received: from mario.gams.at ([194.42.96.10]:29796 "EHLO mario.gams.at")
	by vger.kernel.org with ESMTP id <S261610AbSJNMXe> convert rfc822-to-8bit;
	Mon, 14 Oct 2002 08:23:34 -0400
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.3
From: Bernd Petrovitsch <bernd@gams.at>
To: Russell King <rmk@arm.linux.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: open("/dev/ttyS1", O_LARGEFILE) blocks 
References: <20021014125206.A2902@flint.arm.linux.org.uk> 
In-reply-to: Your message of "Mon, 14 Oct 2002 12:52:06 BST."
             <20021014125206.A2902@flint.arm.linux.org.uk> 
X-url: http://www.luga.at/~bernd/
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Mon, 14 Oct 2002 14:29:23 +0200
Message-ID: <2994.1034598563@frodo.gams.co.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk@arm.linux.org.uk> wrote:
>On Mon, Oct 14, 2002 at 01:39:07PM +0200, Bernd Petrovitsch wrote:
>> Hi all!
>> 
>> Is is normal/correct/intended that an open() of /dev/ttyS1 blocks?
>> ----  snip  ----
>> {81}strace ./test-open /dev/ttyS0
>> [...]
>> open("/dev/ttyS0", O_RDONLY|O_NONBLOCK) = 3
>> close(3)                                = 0
>> open("/dev/ttyS0", O_RDONLY|O_NONBLOCK|O_LARGEFILE) = 3
>> close(3)                                = 0
>> open("/dev/ttyS0", O_RDONLY|O_LARGEFILE) = 3
>> close(3)                                = 0
>> _exit(0)                                = ?
>> {82}strace ./test-open /dev/ttyS1
>> [...]
>> open("/dev/ttyS1", O_RDONLY|O_NONBLOCK) = 3
>> close(3)                                = 0
>> open("/dev/ttyS1", O_RDONLY|O_NONBLOCK|O_LARGEFILE) = 3
>> close(3)                                = 0
>> open("/dev/ttyS1", O_RDONLY|O_LARGEFILE <unfinished ...>
>> {83}lsof /dev/ttyS0
>> {84}lsof /dev/ttyS1
>> {85}uname -a
>> Linux xxx 2.4.20-pre10aa1 #6 Fri Oct 11 13:41:20 CEST 2002 i686 unknown
>> ----  snip  ----
>> 
>> The second one was terminated with a Ctrl-C.
>> Nothing was connected to none of the ports.
>> Is there a reason that an open() on /dev/ttyS0 works and blocks
>> on /dev/ttyS1?
>
>stty -aF /dev/ttyS0
>stty -aF /dev/ttyS1
>
>I bet ttyS0 has clocal set, whereas ttyS1 doesn't.

ACK. 
----  snip  ----
{91}stty -aF /dev/ttyS0
speed 57600 baud; rows 0; columns 0; line = 0;
intr = ^C; quit = ^\; erase = ^?; kill = ^U; eof = ^D; eol = <undef>; eol2 = <undef>; start = ^Q; stop = ^S; susp = ^Z;
rprnt = ^R; werase = ^W; lnext = ^V; flush = ^O; min = 1; time = 0;
-parenb -parodd cs8 -hupcl -cstopb cread clocal -crtscts
                                         ^^^^^^
ignbrk -brkint -ignpar -parmrk -inpck -istrip -inlcr -igncr -icrnl ixon ixoff -iuclc -ixany -imaxbel
-opost -olcuc -ocrnl -onlcr -onocr -onlret -ofill -ofdel nl0 cr0 tab0 bs0 vt0 ff0
-isig -icanon -iexten -echo -echoe -echok -echonl -noflsh -xcase -tostop -echoprt -echoctl -echoke
{92}stty -aF /dev/ttyS1
speed 19200 baud; rows 0; columns 0; line = 0;
intr = ^C; quit = ^\; erase = ^?; kill = ^U; eof = ^D; eol = <undef>; eol2 = <undef>; start = ^Q; stop = ^S; susp = ^Z;
rprnt = ^R; werase = ^W; lnext = ^V; flush = ^O; min = 1; time = 0;
-parenb -parodd cs8 hupcl -cstopb cread -clocal crtscts
                                        ^^^^^^^
-ignbrk -brkint -ignpar -parmrk -inpck -istrip -inlcr -igncr -icrnl -ixon -ixoff -iuclc -ixany -imaxbel
-opost -olcuc -ocrnl -onlcr -onocr -onlret -ofill -ofdel nl0 cr0 tab0 bs0 vt0 ff0
-isig -icanon -iexten -echo -echoe -echok -echonl -noflsh -xcase -tostop -echoprt -echoctl -echoke
----  snip  ----
Sigh, perhaps reading more in Stevens' "Adv. Programming in the
Unix Environment" could help .....

Hmm, so I conclude that using something like "stty < /dev/ttyS0" is 
evil in general and one should always use "stty -F /dev/ttyS0" instead.

	Bernd
-- 
Bernd Petrovitsch                              Email : bernd@gams.at
g.a.m.s gmbh                                  Fax : +43 1 205255-900
Prinz-Eugen-Straße 8                    A-1040 Vienna/Austria/Europe
                     LUGA : http://www.luga.at


