Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264589AbRFPGkV>; Sat, 16 Jun 2001 02:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264590AbRFPGkC>; Sat, 16 Jun 2001 02:40:02 -0400
Received: from [203.143.19.4] ([203.143.19.4]:2067 "EHLO kitul.learn.ac.lk")
	by vger.kernel.org with ESMTP id <S264589AbRFPGjw>;
	Sat, 16 Jun 2001 02:39:52 -0400
Date: Sat, 16 Jun 2001 11:22:27 +0600 (LKT)
From: Anuradha Ratnaweera <anuradha@gnu.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Few thoughts about CML2 and kernel configuration
Message-ID: <Pine.LNX.4.21.0106160026320.7462-100000@presario>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello all,

I used CML2 on my laptop running Debian 2.2 (Linux 2.4.5). I think that it
would be fruitful to share my first CML2 experience with others as someone
who know the whereabouts of the kernel tree and very much used to CML1.

Most of the things worked great, except few exceptions.

Notice that I will be giving many details such as colors of the menus etc.
so that many others who haven't used CML2 yet would get an idea about it.

Also I would be describing my thoughts all over the process, which, I
believe, is an important feedback for good user interface design.

I remember Alan Cox seperating issues related to cml2 kernel configuration
into four of so different catagories. In that light, many things that
follow would apply to cml2 configuration tools and kernel cml2 rulebase,
and not to the cml2 language itself.

- I started with a fresh kernel source tree (2.4.2 + 2.4.[3-5] patches)

- CML2 installation (install-cml2) was quite straightforward. It found
  /usr/src/linux and applied necessary "patches".

- I ran make menuconfig, to which I am much used to. I rushed through the
  initial help screen, hoping that nothing unexpected would happen.

- The menu items were of different colors (and the meanings were obvious -
  good!). The architecture (x86) was frozen and _shown_ (in blue). Some
  items had the familiar [ ] and < > mark to the left while others didn't.
  I assumed that the latter should be leading to sub-menus (which was
  correct). The selected (y or m) items and sub-menu items were green
  while the others (unselected) were white.

- I entered "Configuration policy options" and turned on "Prompt for
  expert choices". CONFIG_EXPERIMENTAL was already set.

- "Architecture independent features" were quite straightforward.
  Here I turned on "BSD process accounting" (this had a "(NEW)" to its
  right, which I was rather suprised at) and turned off SMP.

- Intel x86 specific options were again straightforward where I set
  processor type to Pentium MMX, turned off MTTR, and turned on IO-APIC.
  Since the processor type selection had to turn off the already selected
  default processor, a dialog-box appeared to inform that it was set to n.

- "System busses and controller types" selection was again easy. "ISA BUS"
  was selected and marked frozen. The others were EISA, PCI, PNP/ISAPNP,
  PARPORT, HOTPLUG, PCMCIA, IDE, SCSI, USB, IEEE1394 and I2O.

  Here I ran into two problems. The first is not really a problem.

  Both "PNP" and "ISAPNP" were selected to be build static into the
  kernel. I turned "PNP" to a module, and expected "ISAPNP" also to be
  converted to a module automatically, but it didn't. I had to do this
  by hand.

  Then I tried to turn on "Parallel port support". Here a dialog-box
  informed that this violates the rule

    (X86 implies (PARPORT_PC == PARPORT))

  Although the message is very clear (tristate values of PARPORT_PC
  should be the same as PARPORT for X86 boxes) I hadn't seen PARPORT_PC
  yet.

  A better option would be to change PARPORT_PC at this poing and
  inform that (in a similar manner to processor type selection). Most,
  if not all, who configure an x86 box and trying to select PARPORT would
  give the same answer to PARPORT_PC.

  I also turned off SCSI and USB.

- I came back to the main menu and noticed that the sub-menu items related
  to SCSI and USB are gone (as expected - good!)

- PM and "Architecture specific hacks" was fine.

- MTD was turned off

- Block devices and Networking options, Network device support was
  alright.

- Linux telephony support was rather different from others. For some
  sub-menus (such as MTD, SOUND) a question is asked on the main screen
  and if the answer is y or m the sub-menu is shown. But for telephony,
  the sub-menu is shown and items in it are shown only if its first
  item "Linux telephony support" is selected (which is similar to
  cml1 configuration).

- The other configuration options were also quite straighforward.

- I didn't find PARPORT_PC (probably I missed it somewhere) ;-(


I have some comments about the cml2 configuration system for Linux kernel.
These are my own comments and would be very different from someone else's,
because many of them depends on the taste.

- Its design is much better than cml1 which is simply a way of showing
  a hierachy of menus.

- The feeling is much similar to that of using lynx (especially using
  left-arrow). It would be very nice if pressing right-arrow gives the
  same effect as pressing enter.

- Some changes (say changing Y of "loadable module support" to M) would
  change many other selections and the configuration will first do
  those changes and tell us that it did them. Isn't it better to ask a
  question like "This would change the followings, so do you want to
  do those changes, too? or do you want to revert this selection?", so
  that accidents will not cause big problems.

- Some sub-menus on the main screen are turned on/off by a selection of an
  item in a sub-menu (e.g.: SCSI, USB) while others are turned on/off at 
  the main screen itself (e.g.: MTD, SOUND). How about moving them also to
  a seperate sub-menu (say "Miscellaneous ..."). Then we have two kinds of
  sub-menus on the main screen. Some are always shown (e.g. "System busses
  and controller types"). Depending on the user's selections of the items
  in these menus, other submenus are shown or supressed. Then the main
  menu doesn't contain any tristate questions, but only sub-menus.


CML2 is a great way to configure a system with complicated dependencies
and I am already starting to use it for some. Hope that its original and
most important (to me at least ;) application, the configuration of the
Linux kernel would be a great success.

Regards and greetings,

Anuradha


Lanka Linux User Group (LKLUG)
http://www.lklug.pdn.ac.lk

----------------------------------
http://www.bee.lk/people/anuradha/

