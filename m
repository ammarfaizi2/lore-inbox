Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264990AbSKOJ5k>; Fri, 15 Nov 2002 04:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265978AbSKOJ5j>; Fri, 15 Nov 2002 04:57:39 -0500
Received: from m3.azalea.se ([217.75.96.207]:59808 "HELO m3.azalea.se")
	by vger.kernel.org with SMTP id <S264990AbSKOJ5i>;
	Fri, 15 Nov 2002 04:57:38 -0500
From: "Mikael Olenfalk" <mikael@netgineers.se>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.19-xfs eating filehandles when compiled with gcc 3.2
Date: Fri, 15 Nov 2002 11:17:18 +0100
Organization: Netgineers HB
Message-ID: <000a01c28c90$2d3c6ff0$0501a8c0@devnet.vodha>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,

I know you might be very busy with the 2.5 -> 2.6 transition, but this
is the only list I could imagine that has the answer to my problem.


I have a Gentoo Linux 1.4 RC1 system, that ships with a GCC 3.2 compiler
and 2.4.19 with the XFS patches (and IMON btw).

I have just bootstrapped my system and everything went fine until I
first started (tried to) Gnome. It just freezes for a while and after
that it breaks and jumps back to the console.

Nothing in syslog, nothing anywhere.

A little bit later (I think after a kernel recompile) I discovered a
message like "too many open files" and catted /proc/sys/fs/file-nr which
gives this output:

8196 8006 8196

I rebooted and started this script on VC/2:

# while true; do sleep 3; cat /proc/sys/fs/file-nr; done

I then did some testing on the other console, just ran some commands
while watching the output of my script :)

First I ran a find / -name \*, which brought the second file-nr value to
6. There was some jumping between 4-6 for a while but it kept at six
after that.

Then I did recompile the kernel, the value went to 175. Then I
recompiled glibc which made it jump to 400 something. Funnily enough a
find / -name \* lowered the value by certain amount again. (But it kept
increasing after a while).

I have bootstrapped my whole system once with CFLAGS="-march=athlon-xp
-O3 -mpipe" and CXXFLAGS=$CFLAGS.

And once with "-march=athlon-xp -mcpu=athlon-xp ..." don't ask me why, I
don't know so much about these two flags, the seconds approach did at
least remove some warnings.


My first thought was that gcc 3.2 has some compatibility issues with the
kernel and glibc. Of course it could be gnome, too.

Perhaps anybody knows of any issues with gcc 3.2??



Regards,
mikael

