Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310339AbSCLCfl>; Mon, 11 Mar 2002 21:35:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310348AbSCLCfc>; Mon, 11 Mar 2002 21:35:32 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:18193 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S310339AbSCLCfT>; Mon, 11 Mar 2002 21:35:19 -0500
Date: Tue, 12 Mar 2002 13:35:15 +1100 (EST)
From: DaZZa <dazza@zip.com.au>
To: <linux-kernel@vger.kernel.org>
Subject: Problems compiling kernel greater than 2.4.7
Message-ID: <Pine.LNX.4.30.0203121326420.12771-100000@zipperii.zip.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My apologies if this has gone to the wrong place, or if the answer is
something really obvious, and I'm just too stupid to see it, but I'm at my
wits end.

I'm attempting to compile a new kernel. 2.4.14 by preference, but this
problem also exists with every version I've tried beyond 2.4.7.

My box is running SuSE 7.2 Professional, pretty much standard - I haven't
applied any updates from SuSE because I can't find any which seem relavent
to my problem.

On installing a clean copy of the kernel source tree for ANY version after
2.4.7, I perform the following

cd /usr/src
ln -s linux-2.4.14 linux
cd linux
make mrproper
make menuconfig

At this point, menuconfig runs, and I receive the initial, "Linux 2.4.14
Kernel Configuration" blue yellow and white screen.

However, selecting *ANY* menu option at this point gives the following
error message

===cut===
There seems to be a problem with the lxdialog companion utility which is
built prior to running Menuconfig.  Usually this is an indicator that you
have upgraded/downgraded your ncurses libraries and did not remove the
old ncurses header file(s) in /usr/include or /usr/include/ncurses.

It is VERY important that you have only one set of ncurses header files
and that those files are properly version matched to the ncurses libraries
installed on your machine.

You may also need to rebuild lxdialog.  This can be done by moving to
the /usr/src/linux/scripts/lxdialog directory and issuing the
"make clean all" command.

If you have verified that your ncurses install is correct, you may email
the maintainer <mec@shout.net> or post a message to
<linux-kernel@vger.kernel.org> for additional assistance.

make: *** [menuconfig] Error 139
fred:/usr/src/linux #
===cut===

At this point, I follow instructions, and attempt to rebuild the lxdialog
script wit this result.

===cut===
fred:/usr/src/linux # cd scripts/lxdialog
fred:/usr/src/linux/scripts/lxdialog # make clean all
rm -f core *.o *~ lxdialog
gcc -DLOCALE  -DCURSES_LOC="<ncurses.h>" -c -o checklist.o checklist.c
gcc -DLOCALE  -DCURSES_LOC="<ncurses.h>" -c -o menubox.o menubox.c
gcc -DLOCALE  -DCURSES_LOC="<ncurses.h>" -c -o textbox.o textbox.c
gcc -DLOCALE  -DCURSES_LOC="<ncurses.h>" -c -o yesno.o yesno.c
gcc -DLOCALE  -DCURSES_LOC="<ncurses.h>" -c -o inputbox.o inputbox.c
gcc -DLOCALE  -DCURSES_LOC="<ncurses.h>" -c -o util.o util.c
gcc -DLOCALE  -DCURSES_LOC="<ncurses.h>" -c -o lxdialog.o lxdialog.c
gcc -DLOCALE  -DCURSES_LOC="<ncurses.h>" -c -o msgbox.o msgbox.c
gcc -o lxdialog checklist.o menubox.o textbox.o yesno.o inputbox.o util.o
lxdialog.o msgbox.o -lncurses
fred:/usr/src/linux/scripts/lxdialog #
===cut===

Returning to the /usr/src/linux directory and attempting to run make
menuconfig gets me back where I started.

I have traced ncurses until I am blue in the face - as far as I can tell,
there is only one libncurses.so link on my box, and it points to a file
which matches the ncurses.h header file version.

Can anyone shed some light on why this has become a problem _only_ since
kernel version 2.4.7? Can anyone suggest some way I can make the compile
work?

Any assistance appreciated - I will try anything suggested along the way
by anyone.

Again, my apologies if this has gone to the wrong place.

Thanks for any help received.

DaZZa

