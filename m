Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131459AbRDFKW5>; Fri, 6 Apr 2001 06:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131460AbRDFKWr>; Fri, 6 Apr 2001 06:22:47 -0400
Received: from mail.axisinc.com ([193.13.178.2]:28167 "EHLO roma.axis.se")
	by vger.kernel.org with ESMTP id <S131459AbRDFKWm>;
	Fri, 6 Apr 2001 06:22:42 -0400
Message-ID: <1aa801c0be83$00a7e410$0a070d0a@axis.se>
From: "Johan Adolfsson" <johan.adolfsson@axis.com>
To: <cate@debian.org>, "Johan Adolfsson" <johan.adolfsson@axis.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <fa.ggqkpgv.9g0c0b@ifi.uio.no> <fa.k6fq96v.nhaq06@ifi.uio.no> <3ACD68FF.637D8958@math.ethz.ch> <018001c0be69$90dcb200$9db270d5@homeip.net> <3ACD73E0.2B1DFF6F@math.ethz.ch> <19da01c0be78$f9106c90$0a070d0a@axis.se> <3ACD8ECC.F2518B90@math.ethz.ch>
Subject: Re: Arch specific/multiple Configure.help files? [PATCH included]
Date: Fri, 6 Apr 2001 12:19:02 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2314.1300
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message -----
From: Giacomo Catenazzi <cate@math.ethz.ch>
To: Johan Adolfsson <johana@axis.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Friday, April 06, 2001 11:39
Subject: Re: Arch specific/multiple Configure.help files?


> Johan Adolfsson wrote:
> >
> > > - IIRC there is only few ARCH specific configuration, thus we
> > > don't
> > >   reduce the size of che Configure.help
> > >   Note that the arch/config.in have to much configuration item
> > >   (but they repeat in (nearly) all arch/config.in files, thus
> > > you
> > >   should count only the really arch specific item.
> >
> > Here are some results:
> > $ wc arch/cris/Configure.help
> >     621    4424   28373 arch/cris/Configure.help
> > $ wc Documentation/Configure.help
> >   17480  121037  773694 Documentation/Configure.help
> > $ grep CONFIG arch/cris/Configure.help |wc
> >      75     138    2337
> > $ grep CONFIG Documentation/Configure.help |wc
> >    1486    1640   30135
> >
> > it's not entiraly correct since the CONFIG_BLUETOOTH help
> > is in the arch/cris directory and that should probably be in
> > Documentation/ or in the OpenBT package and merged from there.
> > The file also contains the # LocalWords: rows from the original
> > Configure.help.
> >
> > But the ETRAX/CRIS config is 3-5% of the total config.
>
> This seem too much. If all arch have a so big CONFIG space, I
> think that your idea can do some improvement.

The file contains some stuff we used in the 2.0 uC-linux version
that we now implement using the netfilter and an application (6 options),
and the bluetooth stuff has 10 options, but the rest is more or less
hardware (ETRAX) specific stuff.

> But: user don't see the difference. Do you think that
> developers
> would like your proposal? (If arch maintainers agree, you can
> try to publish your patch)
As a developer I would ;-) (although I'm not the real maintainer)
Using this feature is not mandatory, but for SOC solutions
that are not PC based, I think it could be helpful.

> > Having the help close to the config sounds like a good idea
> > from a maintenance point of view.
>
> But in 2.5.x the config.in are centralized, thus also
> Configure.help sould be centralized.
> And in this case I think that a big file hurts nobody.
>
> >
> > Sounds better than dealing with two different help files in the
> > config system.
> > Is there an ETA when ESR CML2 will be in the official kernel?
> > (I guess I should catch up on what it will provide instead of
> >  wasting peoples time...)
>
> In 2.5.2 kernel. What We don't know is when 2.5.2 will be
> released!
>
> >
> > Would adding support for merging help files in the current config
> > system be accepted in the meanwhile?
>
> In 2.4: No. Distribution expect a stable interface.

I'm not sure about the definition of a "stable interface",
but this will not really change the interface at all.

> In 2.5 will be the new CML2.
> Again if arch maintainer agree with your proposal, you can
> change
> the CML2. Not so difficult (and you change only in one place
> for all interfaces (olconfig/config/menuconfig/xconfig)
>
> > E.g. Configure, Menuconfig and header.tk is changed to use
> > Documentation/Configure.help.generated
> > and the top Makefile does
> > cat $(HELPFILES) >Documentation/Configure.help.generated 2>/dev/null
> > for oldconfig, config, menuconfig and xconfig targets?
> > And HELPFILES is set to:
> > HELPFILES = arch/$(ARCH)/Configure.help Documentation/Configure.help
> >
> > External patches that add functionality could easaly add
> > HELPFILES += some new help files
> > rows to get the help as well.
>
> This change is too big for 2.4 kernel.

It doesnt look that big to mee, so here it is for everyones consideration
(the mailprogram probably screws up tabs etc. but you get the idea,
I apologise if posting patches like this is the wrong way)

The normal user/developer shouldn't even notice the difference,
the patch shouldn't break anything, just make it possible to
use multiple help files.

linux/Makefile: (linenumber probably a bit off)
@@ -40,6 +44,10 @@ MODFLAGS = -DMODULE
 CFLAGS_KERNEL =
 PERL = perl

+# Helpfiles used in the config system
+# (merged to Documentation/Configure.help.generated)
+HELPFILES       = arch/$(ARCH)/Configure.help Documentation/Configure.help
+
 export VERSION PATCHLEVEL SUBLEVEL EXTRAVERSION KERNELRELEASE ARCH \
  CONFIG_SHELL TOPDIR HPATH HOSTCC HOSTCFLAGS CROSS_COMPILE AS LD CC \
  CPP AR NM STRIP OBJCOPY OBJDUMP MAKE MAKEFILES GENKSYMS MODFLAGS PERL
@@ -260,19 +270,22 @@ symlinks:
  @if [ ! -d include/linux/modules ]; then \
  mkdir include/linux/modules; \
  fi
+
+helpfiles:
+ -cat $(HELPFILES) >Documentation/Configure.help.generated 2>/dev/null

-oldconfig: symlinks
+oldconfig: symlinks helpfiles
  $(CONFIG_SHELL) scripts/Configure -d arch/$(ARCH)/config.in

-xconfig: symlinks
+xconfig: symlinks helpfiles
  $(MAKE) -C scripts kconfig.tk
  wish -f scripts/kconfig.tk

-menuconfig: include/linux/version.h symlinks
+menuconfig: include/linux/version.h symlinks helpfiles
  $(MAKE) -C scripts/lxdialog all
  $(CONFIG_SHELL) scripts/Menuconfig arch/$(ARCH)/config.in

-config: symlinks
+config: symlinks helpfiles
  $(CONFIG_SHELL) scripts/Configure arch/$(ARCH)/config.in

 include/config/MARKER: scripts/split-include include/linux/autoconf.h


RCS file: /n/cvsroot/os/linux/scripts/Configure,v
retrieving revision 1.1.1.2
diff -u -p -r1.1.1.2 Configure
--- scripts/Configure 2001/01/10 13:28:58 1.1.1.2
+++ scripts/Configure 2001/04/06 09:57:44
@@ -48,6 +48,10 @@
 #
 # 24 January 1999, Michael Elizabeth Chastain, <mec@shout.net>
 # - Improve the exit message (Jeff Ronne).
+#
+#  6 April 2000, Johan Adolfsson <Johan.Adolfsson@axis.com>
+# - Use Documentation/Configure.help.generated to support merging help
files
+

 #
 # Make sure we're really running bash.
@@ -81,7 +85,7 @@ function endmenu () {
 #       help variable
 #
 function help () {
-  if [ -f Documentation/Configure.help ]
+  if [ -f Documentation/Configure.help.generated ]
   then
      #first escape regexp special characters in the argument:
      var=$(echo "$1"|sed 's/[][\/.^$*]/\\&/g')
@@ -93,7 +97,7 @@ ${var}:\\
  /^#/b
  /^[^ ]/q
  p
-     }" Documentation/Configure.help)
+     }" Documentation/Configure.help.generated)
      if [ -z "$text" ]
      then
    echo; echo "  Sorry, no help available for this option yet.";echo


RCS file: /n/cvsroot/os/linux/scripts/Menuconfig,v
retrieving revision 1.1.1.2
diff -u -p -r1.1.1.2 Menuconfig
--- scripts/Menuconfig 2001/01/10 13:28:58 1.1.1.2
+++ scripts/Menuconfig 2001/04/06 09:58:40
@@ -74,6 +74,8 @@
 # - Implemented new functions: define_tristate(), define_int(),
define_hex(),
 #   define_string(), dep_bool().
 #
+#  6 April 2000, Johan Adolfsson <Johan.Adolfsson@axis.com>
+# - Use Documentation/Configure.help.generated to support merging help
files


 #
@@ -364,7 +366,7 @@ function choice () {
 # Configure script.
 #
 function extract_help () {
-  if [ -f Documentation/Configure.help ]
+  if [ -f Documentation/Configure.help.generated ]
   then
      #first escape regexp special characters in the argument:
      var=$(echo "$1"|sed 's/[][\/.^$*]/\\&/g')
@@ -377,7 +379,7 @@ ${var}:\\
                         /^[^ ]/q
                         s/^  //
                         p
-                    }" Documentation/Configure.help)
+                    }" Documentation/Configure.help.generated)

      if [ -z "$text" ]
      then


RCS file: /n/cvsroot/os/linux/scripts/header.tk,v
retrieving revision 1.1.1.1
diff -u -p -r1.1.1.1 header.tk
--- scripts/header.tk 2000/07/10 15:30:13 1.1.1.1
+++ scripts/header.tk 2001/04/06 09:59:59
@@ -15,6 +15,9 @@
 #
 # 24 January 1999, Michael Elizabeth Chastain, <mec@shout.net>
 # - Improve the exit message (Jeff Ronne).
+#
+#  6 April 2000, Johan Adolfsson <Johan.Adolfsson@axis.com>
+# - Use Documentation/Configure.help.generated to support merging help
files

 #
 # This is a handy replacement for ".widget cget" that requires neither tk4
@@ -453,7 +456,7 @@ proc dohelp {w var parent}  {
  set found 0
  set lineno 0

- if { [file readable Documentation/Configure.help] == 1} then {
+ if { [file readable Documentation/Configure.help.generated] == 1} then {
  set filefound 1
  # First escape sed regexp special characters in var:
  set var [exec echo "$var" | sed s/\[\]\[\/.^$*\]/\\\\&/g]
@@ -468,7 +471,7 @@ ${var}:\\
  s/^  //
  p
  }
- " Documentation/Configure.help]
+ " Documentation/Configure.help.generated]
  set found [expr [string length "$message"] > 0]
  }


/Johan

