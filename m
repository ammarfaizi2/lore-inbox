Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267506AbTBNXR2>; Fri, 14 Feb 2003 18:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268035AbTBNXR2>; Fri, 14 Feb 2003 18:17:28 -0500
Received: from pl750.nas911.n-yokohama.nttpc.ne.jp ([210.139.39.238]:33731
	"EHLO standard.erephon") by vger.kernel.org with ESMTP
	id <S267506AbTBNXRJ>; Fri, 14 Feb 2003 18:17:09 -0500
Message-ID: <3E4D7B42.E7B1D76B@yk.rim.or.jp>
Date: Sat, 15 Feb 2003 08:26:58 +0900
From: Ishikawa <ishikawa@yk.rim.or.jp>
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: ja, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Subtle kernel configuration tool problem. Support for viper.
 	Hi,
 	I know that kernel configuration tool(s) are undergoing chnage,
 	but here is one anomaly I noticed.
 	I have an ABIT K7G raid motherboard, and
 	attach an ATA/IDE disk to its non-raid controller.
 	This board uses AMD chipset.
 	I am using the kernel 2.4.20.
 	(I use Debian GNU/Linux, but upgrade the kernel on my own
 	regularly.)
 	I notied earlier that the dmesg showed the following message:
 	    VP_IDE: IDE controller on PCI bus 00 dev 39
 	    VP_IDE: detected chipset, but driver not compiled in!
 	    VP_IDE: chipset revision 6
 	    VP_IDE: not 100% native mode: will probe irqs later
 	After seeing this, I realized that
 	I didn't enable the viper support and so
 	I made sure that I have enabled
 	the VIPER support in
 		make xconfig
 	Then I recompiled and installed the kernel for next boot, etc.
 	However, no matter how I tried (and a few times), the message lines
 	still appeared.
 	(Actually, I have enabled the viper support a few weeks ago in make 
 xconfig, 
 	and was suprised to find the message again, and this time I 
 investigated
 	a little on my own.)
 	I re-checked the produced .config and was surprised
 	to find there were NO mention of the supposedly
 	enabled AMD viper support flag(!?).
 	Just being curious, I DISABLED the viper support
 	and saved the configuration under a different name
 	and compared the file to the original config file.
 	They were IDENTICAL! (This was done under make xconfig)
 	(At this stage, I probably reenabled the viper support under
 	make xconfig. Also, I ran make oldconfig just to be sure
 	my .config is in sane state with respect to 2.4.20.
 	But there were not discernable output, and make oldconfig 
 	finished without prompting input. At the end is the
 	history of commands which I ran during this investigation.)
 	Now I wasn't quite sure what to do, but
 	then I tried the different configuration method, namely: 
 		make menuconfig
 	What was really strange, is that
 	the AMD VIPER support was marked [*] and so the tools
 	seem to think that I have enabled it, but why not the 
 	proper line in .config file? (Are user preferences
 	stored somewhere else other than the .config file itself ?)
 	Now I was not trusting the tool(s) at this time
 	very much, there must be some internal consistency problem.
 	So I ticked off the [*] mark and saved it (under 
 	make menuconfig).
 	I compared it with the old config produced
 	by xconfig. Then I realized that diff output
 	had lots of marked comment lines (probably, 
 	somehow the lines inside were re-ordered by make menuconfig
 	or make oldconfig?).
 	Anyway, AMD viper support was not in. Since I have
 	tikced the mark off, this was to be expected.
 	THEN, I ticked the AMD viper support
 	in make menuconfig, and finally I found 
 	the AMD viper support flag line in .config:
 		CONFIG_BLK_DEV_AMD74XX=y
 	The above story is very strange, but it happened.
 	For people working to improve the kernel configuration tool(s), I hope
 	this post provides a data point for problem(s), which might face the
 	people trying to configure the kernel.
 	To people's credit, I think this is the first time something like this
 	happened with the kernel configuration in my use of Linux for the last
 	few years.
 	Just to be complete, here is the command I ran while I tried to track
 	down the problem and made sure the AMD74XX support is in.
 	  106  make xconfig
 	  107  dmesg  grep VIPER
 	  108  dmesg  | grep VIPER
 	  109  dmesg  | grep Viper
 	  110  dmesg  | grep viper
 	  111  dmesg | VP_IDE
 	  112  dmesg | grep VP_IDE
 	  113  grep AM /usr/src/linux/.config
 	  114  cp ./config ./config.saved
 	  115  cp ./.config ./config.saved
 	  116  make xconfig
 	  117  ls -ltr
 	  118  diff -cibw ./.config new-config
 	  119  make oldconfig
 	  120  make xconfig
 	  121  diff -cibw .config config.saved 
 	  122  make menuconfig
 	  123  ls -ltr
 	  124  diff -cibw .config new-config
 	  125  diff -cibw .config new-config | grep -v ^#
 	  126  diff -cibw .config new-config | grep -v "^! #"
 	  127  diff -cibw .config new-config | grep -v "^[!+] #"
 	  128  diff -cibw .config new-config | grep -v "^[!+] #" | more
 	  129  make menuconfig
 	  130  pwd
 	  131  history
 	  132  diff -cibw .config new-config | grep -v "^[!+] #" | more
 	  133  make clean; make dep; make bzImage; make modules; make 
 modules_install
 	  134  history
 	PS: it could be that my .config file contained some crufts left over
 	from much earlier releases (2.3.x, 2.2.y, 2.0.z) and this may explain
 	the problem.
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subtle kernel configuration tool problem. Support for viper.

Hi,

I know that kernel configuration tool(s) are undergoing chnage,
but here is one anomaly I noticed.

I have an ABIT K7G raid motherboard, and
attach an ATA/IDE disk to its non-raid controller.
This board uses AMD chipset.

I am using the kernel 2.4.20.
(I use Debian GNU/Linux, but upgrade the kernel on my own
regularly.)


I notied earlier that the dmesg showed the following message:

    VP_IDE: IDE controller on PCI bus 00 dev 39
    VP_IDE: detected chipset, but driver not compiled in!
    VP_IDE: chipset revision 6
    VP_IDE: not 100% native mode: will probe irqs later

After seeing this, I realized that
I didn't enable the viper support and so
I made sure that I have enabled
the VIPER support in

	make xconfig

Then I recompiled and installed the kernel for next boot, etc.
However, no matter how I tried (and a few times), the message lines
still appeared.
(Actually, I  enabled the viper support a few weeks ago in make xconfig
and
re-installed kernel, 
and was suprised to find the message again, and this time I investigated
a little on my own.)

I re-checked the produced .config and was surprised
to find there were NO mention of the supposedly
enabled AMD viper support flag(!?).

Just being curious, I DISABLED the viper support
and saved the configuration under a different name
and compared the file to the original config file.
They were IDENTICAL! (This was done under make xconfig)

(At this stage, I probably reenabled the viper support under
make xconfig. Also, I ran make oldconfig just to be sure
my .config is in sane state with respect to 2.4.20.
But there were not discernable output, and make oldconfig 
finished without prompting input. At the end is the
history of commands which I ran during this investigation.)

Now I wasn't quite sure what to do, but
then I tried the different configuration method, namely: 

	make menuconfig

What was really strange is that
the AMD VIPER support was marked [*] and so the tools
seem to think that I have enabled it, but why not the 
proper line in .config file? (Are user preferences
stored somewhere else other than the .config file itself ?)

Now I was not trusting the tool(s) at this time
very much, there must be some internal consistency problem.
So I ticked off the [*] mark and saved it (under 
make menuconfig).

I compared it with the old config produced
by xconfig. Then I realized that diff output
had lots of marked comment lines (probably, 
somehow the lines inside were re-ordered by make menuconfig
or make oldconfig?).

Anyway, AMD viper support was not in. Since I have
ticked the mark off, this was to be expected.

THEN, I ticked the AMD viper support
in make menuconfig, and finally I found 
the AMD viper support flag line in .config:

	CONFIG_BLK_DEV_AMD74XX=y

The above story is very strange, but it happened.

For people working to improve the kernel configuration tool(s), I hope
this post provides a data point for problem(s), which might face the
people trying to configure the kernel.

To people's credit, I think this is the first time something like this
happened with the kernel configuration in my use of Linux for the last
few years.

Just to be complete, here is the command I ran while I tried to track
down the problem and made sure the AMD74XX support is in.

  106  make xconfig
  107  dmesg  grep VIPER
  108  dmesg  | grep VIPER
  109  dmesg  | grep Viper
  110  dmesg  | grep viper
  111  dmesg | VP_IDE
  112  dmesg | grep VP_IDE
  113  grep AM /usr/src/linux/.config
  114  cp ./config ./config.saved
  115  cp ./.config ./config.saved
  116  make xconfig
  117  ls -ltr
  118  diff -cibw ./.config new-config
  119  make oldconfig
  120  make xconfig
  121  diff -cibw .config config.saved 
  122  make menuconfig
  123  ls -ltr
  124  diff -cibw .config new-config
  125  diff -cibw .config new-config | grep -v ^#
  126  diff -cibw .config new-config | grep -v "^! #"
  127  diff -cibw .config new-config | grep -v "^[!+] #"
  128  diff -cibw .config new-config | grep -v "^[!+] #" | more
  129  make menuconfig
  130  pwd
  131  history
  132  diff -cibw .config new-config | grep -v "^[!+] #" | more
  133  make clean; make dep; make bzImage; make modules; make
modules_install
  134  history


PS: it could be that my .config file contained some crufts left over
from much earlier releases (2.3.x, 2.2.y, 2.0.z) and this may explain
the problem.

PPS:
	I ran 	make xconfig for the last time and
	saved the configuration under make-config.

	I did the following to compare the lines that contain
	the substring "AM" in the now .config (that contains
	the VIPER support flag) and
	the file that make xconfig produed finally.

	It seems that whatever internal tool(s) "make xconfig"
	and "make menuconfig" use don't seem to agree
	on the set of flags.
	make menuconfig seems to produce
	one extra flag called CONFIG_AMD74XX_OVERRIDE,
	while make xconfig doesn't.

	
  135  make xconfig
  136  ls -ltr
  137  diff -cibw ./config make-xconfig 
  138  diff -cibw ./.config make-xconfig 
  139  diff -cibw ./.config make-xconfig 
  140  grep AM ./.config make-xconfig 
  141  grep AM ./.config > /tmp/.config.AM
  142  grep AM ./make-config > /tmp/make-config.AM
  143  grep AM ./make-xconfig > /tmp/make-xconfig.AM
  144  diff -cibw /tmp/.config.AM /tmp/make-config.AM
  145  diff -cibw /tmp/.config.AM /tmp/make-xconfig.AM
  146  history
duron:/usr/src/linux# 


duron:/usr/src/linux# !145
diff -cibw /tmp/.config.AM /tmp/make-xconfig.AM
*** /tmp/.config.AM     2003-02-15 08:00:03.000000000 +0900
--- /tmp/make-xconfig.AM        2003-02-15 08:00:24.000000000 +0900
***************
*** 2,8 ****
  CONFIG_BLK_DEV_RAM=y
  CONFIG_BLK_DEV_RAM_SIZE=4096
  CONFIG_BLK_DEV_AMD74XX=y
- # CONFIG_AMD74XX_OVERRIDE is not set
  # CONFIG_SCSI_AM53C974 is not set
  # CONFIG_HAMACHI is not set
  # CONFIG_HAMRADIO is not set
--- 2,7 ----
duron:/usr/src/linux# 

-- 
int main(void){int j=2003;/*(c)2003 cishikawa. */
char t[] ="<CI> @abcdefghijklmnopqrstuvwxyz.,\n\"";
char *i ="g>qtCIuqivb,gCwe\np@.ietCIuqi\"tqkvv is>dnamz"
while(*i)((j+=strchr(t,*i++)-(int)t),(j%=sizeof t-1),
(putchar(t[j])));return 0;}/* under GPL */
