Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316773AbSFATuo>; Sat, 1 Jun 2002 15:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316801AbSFATun>; Sat, 1 Jun 2002 15:50:43 -0400
Received: from p508872AA.dip.t-dialin.net ([80.136.114.170]:4282 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316773AbSFATuX>; Sat, 1 Jun 2002 15:50:23 -0400
Date: Sat, 1 Jun 2002 13:49:57 -0600 (MDT)
From: Lightweight patch manager <patch@luckynet.dynu.com>
X-X-Sender: patch@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Kernel Build -- Daniel Phillips <phillips@bonn-fries.net>,
        Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
        Keith Owens <kaos@ocs.com.au>, Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][2.5] kbuild-2.5: 
Message-ID: <Pine.LNX.4.44.0206011348370.4854-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kbuild-2.5 - core (config scripts & co.)

We have several corrections here, accompanied by new scripts.

You will need this patch in generic for kbuild-2.5.
You will need most other kbuild-2.5 patches, too!

This patch is also available from
<URL:ftp://luckynet.dynu.com/pub/linux/kbuild-2.5/many-files/kbuild-2.5-config-scripting.patch>
--
Lightweight patch manager using pine. If you have any objections, tell me.

diff -Nur kbuild-2.5/Config.help kbuild-2.5/Config.help
--- kbuild-2.5/Config.help Fri May 31 15:49:42 2002
+++ kbuild-2.5/Config.help Fri May 31 15:49:42 2002 +0000 thunder (thunder-2.5/Config.help 1.1 0644)
@@ -0,0 +1,201 @@
+# Global configure options, applying to the entire kernel over all
+# architectures.
+
+Format to compile kernel in
+CONFIG_VMLINUX
+  This specifies the format to produce the compiled kernel in. Not all
+  choices are available on all architectures, it depends on the
+  bootloader used by each architecture.
+
+    vmlinux  This is the raw format that is produced by the kernel
+             build.  It is required to use any of the various source
+             debugging tools on the kernel itself and is the only
+             bootable format on some architectures.  It is generally
+             too large to be used otherwise.
+
+    vmlinuz  vmlinux after being stripped to remove debugging
+             information then compressed using gzip.  This is still the
+             same basic format as vmlinux, just smaller.
+
+    zImage   This is the result of running the vmlinux format kernel
+             through `gzip -9` to produce a much compressed version of
+             the same, then adding a old style ix86 boot routine.
+
+             This format can only boot if the resultant image is less
+             than 508k in size. As a result, it is of little use with
+             recent kernels.  Only use zImage if your hardware will not
+             boot with bzImage, and only after a kernel hacker says to
+             use zImage.  This format may be removed.
+
+    bzImage  This is also the result of running the vmlinux format
+             kernel through `gzip -9` but it has a different ix86 boot
+             routine that can handle kernels whose compressed size
+             exceeds 508k. In theory, the boot routine can handle
+             kernel image files up to 15M in size, but this limit has
+             not yet been tested.
+
+    vmlinux.srec  This is the vmlinux file converted to Motorola
+             S-Record format, often required for transferring the
+             kernel to boot loaders on embedded systems.
+
+    vmlinux.bin   This is the raw kernel image in binary format -- an
+             exact copy of which is loaded into memory before booting.
+             This is used for primitive bootloaders on embedded
+             systems, which cannot understand ELF or SREC images, or
+             when the kernel is to reside in flash and be executed
+             directly.
+
+    tftpboot.img   This is the vmlinux file converted to a.out format
+             so that it can be booted over a network using tftp
+             (trivial file transfer protocol).  Mostly used on Sun
+             machines for sparc32 and sparc64 kernels.
+
+  Note that bzImage format does NOT use the `bzip' or `bzip2' compression
+  programs, as some have suggested.
+
+  Also note that the `vmlinux' format is produced by ALL compilations,
+  either as the target step, or as an intermediate step in the
+  production of one of the other formats.
+
+  Select the format required by your bootloader.  If unsure, take the
+  suggested default.
+
+Use a prefix on install paths
+CONFIG_INSTALL_PREFIX
+  If you want to copy the installed kernel and modules to another
+  machine or you are installing on another disk on this machine, you
+  can set a prefix on the install paths.  To install in the standard
+  locations on the current machine, do not set an install prefix.  Most
+  users will want N.
+
+Prefix for install paths
+CONFIG_INSTALL_PREFIX_NAME
+  This string is prefixed to all the paths when installing the kernel
+  and modules.  If you want to copy the installed kernel and modules to
+  another machine or another disk, use the install prefix to point to
+  another directory, say "/var/tmp".  The target directories will be
+  created under this prefix, if necessary.
+
+  Modules are always installed in
+  CONFIG_INSTALL_PREFIX_NAME/lib/modules/KERNELRELEASE.
+
+  Any words in the path that start with an upper case letter and
+  consist only of upper case letters, '_' and digits are replaced by
+  the value of the corresponding variable.  This includes
+  KERNELRELEASE, VERSION, PATCHLEVEL, SUBLEVEL, EXTRAVERSION,
+  USERVERSION, KBUILD_SRCTREE_nnn.
+
+Where to install the kernel
+CONFIG_INSTALL_KERNEL_NAME
+  Specifies which file name the kernel will be installed under.  If
+  your boot loader requires the kernel to be in a specific directory or
+  in a specific area of the disk then follow the loader instructions.
+  Otherwise follow the standard for your distribution, or your own
+  preference.  The path will be prefixed by CONFIG_INSTALL_PREFIX.
+
+  Any words in the path that start with an upper case letter and
+  consist only of upper case letters, '_' and digits are replaced by
+  the value of the corresponding variable.  This includes
+  KERNELRELEASE, VERSION, PATCHLEVEL, SUBLEVEL, EXTRAVERSION,
+  USERVERSION, KBUILD_SRCTREE_nnn.  KERNELFULLNAME and KERNELBASENAME
+  are set to the full name (relative to the object directory) and the
+  base name of the kernel respectively.
+
+  Examples:  /boot/efi/KERNELBASENAME-KERNELRELEASE - IA64 requires
+               /boot/efi
+             /boot/KERNELBASENAME-KERNELRELEASE - old "standard"
+             /lib/modules/KERNELRELEASE/KERNELBASENAME - preferred,
+	       unless the boot loader or lack of space requires another
+	       location.
+
+Install System.map
+CONFIG_INSTALL_SYSTEM_MAP
+  The System.map is not required for booting, but it is used by a lot
+  of kernel utilities, including ps and ksymoops.  Unless you have a
+  good reason not to install the System.map, say Y.
+
+Where to install System.map
+CONFIG_INSTALL_SYSTEM_MAP_NAME
+  Specifies which file name the System.map will be installed under.
+  Because System.map is not required for booting, it should not be
+  installed in a special boot directory.  Unless you have a good reason
+  to install System.map somewhere else, use the default value of
+  /lib/modules/KERNELRELEASE/System.map.  The path will be prefixed by
+  CONFIG_INSTALL_PREFIX.
+
+  Any words in the path that start with an upper case letter and
+  consist only of upper case letters, '_' and digits are replaced by
+  the value of the corresponding variable.  This includes
+  KERNELRELEASE, VERSION, PATCHLEVEL, SUBLEVEL, EXTRAVERSION,
+  USERVERSION, KBUILD_SRCTREE_nnn.
+
+Install .config
+CONFIG_INSTALL_CONFIG
+  It is a good idea to save the .config used to build the kernel and
+  modules, it is useful for bug reporting and for building a new
+  version of the kernel.  Unless you have a good reason not to install
+  the .config, say Y.
+
+Where to install .config
+CONFIG_INSTALL_CONFIG_NAME
+  Specifies which file name the .config will be installed under.
+  Because .config is not required for booting, it should not be
+  installed in a special boot directory.  Unless you have a good reason
+  to install .config somewhere else, use the default value of
+  /lib/modules/KERNELRELEASE/.config.  The path will be prefixed by
+  CONFIG_INSTALL_PREFIX.
+
+  Any words in the path that start with an upper case letter and
+  consist only of upper case letters, '_' and digits are replaced by
+  the value of the corresponding variable.  This includes
+  KERNELRELEASE, VERSION, PATCHLEVEL, SUBLEVEL, EXTRAVERSION,
+  USERVERSION, KBUILD_SRCTREE_nnn.
+
+Install vmlinux for debugging
+CONFIG_INSTALL_VMLINUX
+  If you are debugging a kernel, you usually need vmlinux as well as
+  the bootable kernel.  Unless you plan to debug the kernel, reply N.
+
+Where to install vmlinux
+CONFIG_INSTALL_VMLINUX_NAME
+  If you are debugging a kernel, you usually need vmlinux as well as
+  the bootable kernel.  For debugging, the recommended value is
+  /lib/modules/KERNELRELEASE/vmlinux.  The path will be prefixed by
+  CONFIG_INSTALL_PREFIX.
+
+  Any words in the path that start with an upper case letter and
+  consist only of upper case letters, '_' and digits are replaced by
+  the value of the corresponding variable.  This includes
+  KERNELRELEASE, VERSION, PATCHLEVEL, SUBLEVEL, EXTRAVERSION,
+  USERVERSION, KBUILD_SRCTREE_nnn.
+
+Run a post-install script or command
+CONFIG_INSTALL_SCRIPT
+  If you perform some extra work after installing the kernel and
+  modules, specify Y here.  This includes automatically updating your
+  boot loader with the new kernel.
+
+Post-install script or command name
+CONFIG_INSTALL_SCRIPT_NAME
+  If you perform some extra work after installing the kernel and
+  modules, specify the name of your script or command here.  It will be
+  invoked after copying the kernel and modules to the target locations.
+  The CONFIG_INSTALL_* variables will be in the environment of your
+  script, as well as all variables exported by the top level Makefile,
+  including KERNELRELEASE, VERSION, PATCHLEVEL, SUBLEVEL, EXTRAVERSION,
+  USERVERSION, KBUILD_OBJTREE, KBUILD_SRCTREE_nnn.
+
+  If your boot loader needs to be run to pick up the new kernel
+  location, you can insert the loader command in this field.  The
+  command or script must be executable.  LILO users might find this to
+  be useful,
+    KBUILD_SRCTREE_000/scripts/lilo_new_kernel
+  It adds CONFIG_INSTALL_PREFIX_NAME/CONFIG_INSTALL_KERNEL_NAME to
+  /etc/lilo.conf with a label of KERNELRELEASE (truncated to 15
+  characters) then runs lilo.
+
+  Any words in the path that start with an upper case letter and
+  consist only of upper case letters, '_' and digits are replaced by
+  the value of the corresponding variable.  This includes
+  KERNELRELEASE, VERSION, PATCHLEVEL, SUBLEVEL, EXTRAVERSION,
+  USERVERSION, KBUILD_SRCTREE_nnn.
diff -Nur kbuild-2.5/Config.in kbuild-2.5/Config.in
--- kbuild-2.5/Config.in Fri May 31 15:54:29 2002
+++ kbuild-2.5/Config.in Fri May 31 15:54:29 2002 +0000 thunder (thunder-2.5/Config.in 1.1 0644)
@@ -0,0 +1,2 @@
+# Dummy entry for makefile 2.5 add on menu
+# Dummy entry for makefile 2.5 add on menu
diff -Nur kbuild-2.5/have_config kbuild-2.5/have_config
--- kbuild-2.5/have_config Fri May 31 15:54:29 2002
+++ kbuild-2.5/have_config Fri May 31 15:54:29 2002 +0000 thunder (thunder-2.5/have_config 1.1 0644)
@@ -0,0 +1,2 @@
+# Base kernel should have an empty have_config file.
+# Base kernel should have an empty have_config file.
diff -Nur kbuild-2.5/scripts/Configure kbuild-2.5/scripts/Configure
--- kbuild-2.5/scripts/Configure Fri May 31 15:49:38 2002
+++ kbuild-2.5/scripts/Configure Fri May 31 15:49:38 2002 +0000 thunder (thunder-2.5/scripts/Configure 1.1 0644)
@@ -48,6 +48,10 @@
 #
 # 24 January 1999, Michael Elizabeth Chastain, <mec@shout.net>
 # - Improve the exit message (Jeff Ronne).
+#
+# 7 October 2000, Ghozlane Toumi, <gtoumi@messel.emse.fr>
+# added switches for "random" , "all yes" and "all modules"
+#
 
 #
 # Make sure we're really running bash.
@@ -76,6 +80,43 @@
 }
 
 #
+# returns a random number between 1 and $1
+#
+function rnd () {
+	rnd=$[ $RANDOM  %  $1 + 1 ]
+}
+
+#
+# randomly chose a number in a config list (LIST_CONFIG_NAME)
+# or in a range ( MIN_CONFIG_NAME MAX_CONFIG_NAME )
+# ONLY if there is no forced default (and we are in an "auto" mode)
+# we are limited by the range of values taken by  "$RANDOM"
+#
+#       rndval CONFIG_NAME
+#
+
+function rndval () {
+	[ "$AUTO" != "yes" -o -n "$old" ] && return
+	def_list=$(eval echo "\${LIST_$1}")
+	def_min=$(eval echo "\${MIN_$1}")
+	def_max=$(eval echo "\${MAX_$1}")
+
+	if [ -n "$def_list" ]; then
+	  set -- $(echo $def_list | sed 's/,/ /g')
+	  rnd $#
+	  while [ $rnd -le $# ] ; do
+	    def=$1
+	    shift
+	  done
+	  return
+	fi
+	if [ -n "$def_min" -a -n "$def_max" ]; then
+	  rnd $[ $def_max - $def_min ]
+	  def=$[ $def_min + $rnd ]
+	fi
+}
+
+#
 # help prints the corresponding help text from Configure.help to stdout
 #
 #       help variable
@@ -109,7 +150,11 @@
 #	readln prompt default oldval
 #
 function readln () {
-	if [ "$DEFAULT" = "-d" -a -n "$3" ]; then
+	if [ "$AUTO" = "yes" ]; then 
+		echo -n "$1"
+		ans=$2
+		echo $ans
+	elif [ "$DEFAULT" = "-d" -a -n "$3" ]; then
 		echo "$1"
 		ans=$2
 	else
@@ -169,6 +214,17 @@
 function bool () {
 	old=$(eval echo "\${$2}")
 	def=${old:-'n'}
+	if [ "$AUTO" = "yes" -a -z "$old" ]; then
+	  if [ "$RND" = "-r" ]; then
+	    rnd 2
+	    case $rnd in
+	      "1") def="y" ;;
+	      "2") def="n" ;;
+	    esac
+	  else
+	    def=$DEF_ANS;
+	  fi
+	fi
 	case "$def" in
 	 "y" | "m") defprompt="Y/n/?"
 	      def="y"
@@ -200,6 +256,18 @@
 	else 
 	  old=$(eval echo "\${$2}")
 	  def=${old:-'n'}
+	  if [ "$AUTO" = "yes" -a -z "$old" ]; then
+	     if [ "$RND" = "-r" ]; then 
+	      rnd 3
+	      case $rnd in
+	        "1") def="y" ;;
+	        "2") def="n" ;;
+	        "3") def="m" ;;
+	      esac
+	    else
+	      def=$DEF_ANS
+	    fi
+	  fi
 	  case "$def" in
 	   "y") defprompt="Y/m/n/?"
 		;;
@@ -256,6 +324,17 @@
 
 	if [ $need_module = 1 ]; then
 	   if [ "$CONFIG_MODULES" = "y" ]; then
+		if [ "$AUTO" = "yes" -a -z "$old" ]; then
+		   if [ "$RND" = "-r" ]; then
+		      rnd 2
+		      case $rnd in
+			"1") def="m" ;;
+			"2") def="n" ;;
+		      esac
+		   else
+		      def=$DEF_ANS
+		   fi
+		fi
 		case "$def" in
 		 "y" | "m") defprompt="M/n/?"
 		      def="m"
@@ -351,6 +430,7 @@
 	else
 	  max=10000000     # !!
 	fi
+	rndval $2
 	while :; do
 	  readln "$1 ($2) [$def] " "$def" "$old"
 	  if expr \( \( $ans + 0 \) \>= $min \) \& \( $ans \<= $max \) >/dev/null 2>&1 ; then
@@ -382,6 +462,7 @@
 	old=$(eval echo "\${$2}")
 	def=${old:-$3}
 	def=${def#*[x,X]}
+	rndval $2
 	while :; do
 	  readln "$1 ($2) [$def] " "$def" "$old"
 	  ans=${ans#*[x,X]}
@@ -464,6 +545,15 @@
 		shift; shift
 	done
 
+	if [ "$RND" = "-r" -a -z "$old" ] ; then 
+	  set -- $choices
+	  rnd $#
+	  while [ $rnd -le $# ] ; do 
+	    def=$1
+	    shift ; shift
+	  done
+	fi
+
 	val=""
 	while [ -z "$val" ]; do
 		ambg=n
@@ -512,6 +602,7 @@
 
 CONFIG=.tmpconfig
 CONFIG_H=.tmpconfig.h
+FORCE_DEFAULT=.force_default
 trap "rm -f $CONFIG $CONFIG_H ; exit 1" 1 2
 
 #
@@ -532,34 +623,57 @@
 	shift
 fi
 
+RND=""
+DEF_ANS=""
+AUTO=""
+case "$1" in 
+	-r) RND="-r" ; AUTO="yes" ; shift ;;
+	-y) DEF_ANS="y" ; AUTO="yes" ; shift ;;
+	-m) DEF_ANS="m" ; AUTO="yes" ; shift ;;
+	-n) DEF_ANS="n" ; AUTO="yes" ; shift ;;
+esac
+
 CONFIG_IN=./config.in
 if [ "$1" != "" ] ; then
 	CONFIG_IN=$1
 fi
 
-DEFAULTS=.config
-if [ ! -f .config ]; then
-  DEFAULTS=/etc/kernel-config
-  if [ ! -f $DEFAULTS ]; then
-    DEFAULTS=/boot/config-`uname -r`
-    if [ ! -f $DEFAULTS ]; then
-      DEFAULTS=arch/$ARCH/defconfig
-    fi
+for DEFAULTS in .config /lib/modules/`uname -r`/.config /etc/kernel-config /boot/config-`uname -r` arch/$ARCH/defconfig
+do
+  [ -r $DEFAULTS ] && break
+done
+
+if [ "$AUTO" != "yes" ]; then
+  if [ -f $DEFAULTS ]; then
+    echo "#"
+    echo "# Using defaults found in" $DEFAULTS
+    echo "#"
+    . $DEFAULTS
+    sed -e 's/# \(CONFIG_[^ ]*\) is not.*/\1=n/' <$DEFAULTS >.config-is-not.$$
+    . .config-is-not.$$
+    rm .config-is-not.$$
+  else
+    echo "#"
+    echo "# No defaults found"
+    echo "#"
   fi
-fi
-
-if [ -f $DEFAULTS ]; then
-  echo "#"
-  echo "# Using defaults found in" $DEFAULTS
-  echo "#"
-  . $DEFAULTS
-  sed -e 's/# \(CONFIG_[^ ]*\) is not.*/\1=n/' <$DEFAULTS >.config-is-not.$$
-  . .config-is-not.$$
-  rm .config-is-not.$$
 else
-  echo "#"
-  echo "# No defaults found"
-  echo "#"
+  if [ -f $FORCE_DEFAULT ]; then
+    echo "#"
+    echo "# Forcing defaults found in $FORCE_DEFAULT"
+    echo "#"
+    sed -e '
+s/# \(CONFIG_[^ ]*\) is not.*/\1=n/;
+s/# range \(CONFIG_[^ ]*\) \([^ ][^ ]*\) \([^ ][^ ]*\)/MIN_\1=\2; MAX_\1=\3/;
+s/# list \(CONFIG_[^ ]*\) \([^ ][^ ]*\)/LIST_\1=\2/
+' <$FORCE_DEFAULT >.default_val.$$
+    . .default_val.$$
+    rm .default_val.$$
+  else
+    echo "#"
+    echo "# No defaults found"
+    echo "#"
+  fi 
 fi
 
 . $CONFIG_IN
diff -Nur kbuild-2.5/scripts/Menuconfig kbuild-2.5/scripts/Menuconfig
--- kbuild-2.5/scripts/Menuconfig Fri May 31 15:49:36 2002
+++ kbuild-2.5/scripts/Menuconfig Fri May 31 15:49:36 2002 +0000 thunder (thunder-2.5/scripts/Menuconfig 1.1 0644)
@@ -73,6 +73,10 @@
 # - Support for multiple conditions in dep_tristate().
 # - Implemented new functions: define_tristate(), define_int(), define_hex(),
 #   define_string(), dep_bool().
+#
+# 12 November 2001, Keith Owens <kaos@ocs.com.au>
+# Escape double quotes on eval so the quotes are still there on the second
+# evaluation, required to handle strings with special characters.
 # 
 
 
@@ -105,11 +109,11 @@
     eval x=\$$1
     if [ -z "$x" ]; then
 	eval `sed -n -e 's/# \(.*\) is not set.*/\1=n/' -e "/^$1=/p" arch/$ARCH/defconfig`
-	eval x=\${$1:-"$2"}
+	eval x=\${$1:-\"$2\"}
 	eval $1=$x
 	eval INFO_$1="' (NEW)'"
     fi
-    eval info="\$INFO_$1"
+    eval info=\"\$INFO_$1\"
 }
 
 #
@@ -151,7 +155,7 @@
 }
 
 function define_string () {
-	eval $1="$2"
+	eval $1=\"$2\"
 }
 
 #
@@ -333,7 +337,7 @@
 
 	while [ -n "$2" ]
 	do
-		if eval [ "_\$$2" = "_y" ]
+		if eval [ \"_\$$2\" = \"_y\" ]
 		then
 			current=$1
 			break
@@ -543,9 +547,9 @@
 			# we avoid them:
 			if expr "$answer" : '0$' '|' "$answer" : '[1-9][0-9]*$' '|' "$answer" : '-[1-9][0-9]*$' >/dev/null
 			then
-				eval $2="$answer"
+				eval $2=\"$answer\"
 			else
-				eval $2="$3"
+				eval $2=\"$3\"
 				echo -en "\007"
 				${DIALOG} --backtitle "$backtitle" \
 					--infobox "You have made an invalid entry." 3 43
@@ -576,9 +580,9 @@
 
 			if expr "$answer" : '[0-9a-fA-F][0-9a-fA-F]*$' >/dev/null
 			then
-				eval $2="$answer"
+				eval $2=\"$answer\"
 			else
-				eval $2="$3"
+				eval $2=\"$3\"
 				echo -en "\007"
 				${DIALOG} --backtitle "$backtitle" \
 					--infobox "You have made an invalid entry." 3 43
@@ -676,9 +680,9 @@
 	do
 		if [ "$2" = "$choice" ]
 		then
-			eval $2="y"
+			eval $2=\"y\"
 		else
-			eval $2="n"
+			eval $2=\"n\"
 		fi
 		
 		shift ; shift
@@ -941,9 +945,9 @@
 
 			[ "_" = "_$ALT_CONFIG" ] && break
 
-			if eval [ -r "$ALT_CONFIG" ]
+			if eval [ -r \"$ALT_CONFIG\" ]
 			then
-				eval load_config_file "$ALT_CONFIG"
+				eval load_config_file \"$ALT_CONFIG\"
 				break
 			else
 				echo -ne "\007"
@@ -1067,12 +1071,12 @@
 	#
 	function bool () {
 		set_x_info "$2" "n"
-		eval define_bool "$2" "$x"
+		eval define_bool \"$2\" \"$x\"
 	}
 
 	function tristate () {
 		set_x_info "$2" "n"
-		eval define_tristate "$2" "$x"
+		eval define_tristate \"$2\" \"$x\"
 	}
 
 	function dep_tristate () {
@@ -1138,19 +1142,19 @@
 	}
 
 	function define_hex () {
-		eval $1="$2"
+		eval $1=\"$2\"
                	echo "$1=$2"			>>$CONFIG
 		echo "#define $1 0x${2##*[x,X]}"	>>$CONFIG_H
 	}
 
 	function define_int () {
-		eval $1="$2"
+		eval $1=\"$2\"
 		echo "$1=$2" 			>>$CONFIG
 		echo "#define $1 ($2)"		>>$CONFIG_H
 	}
 
 	function define_string () {
-		eval $1="$2"
+		eval $1=\"$2\"
 		echo "$1=\"$2\""		>>$CONFIG
 		echo "#define $1 \"$2\""	>>$CONFIG_H
 	}
@@ -1160,7 +1164,7 @@
 	}
 
 	function define_tristate () {
-		eval $1="$2"
+		eval $1=\"$2\"
 
    		case "$2" in
          	y)
@@ -1199,7 +1203,7 @@
 		set -- $choices
 		while [ -n "$2" ]
 		do
-			if eval [ "_\$$2" = "_y" ]
+			if eval [ \"_\$$2\" = \"_y\" ]
 			then
 				current=$1
 				break
diff -Nur kbuild-2.5/scripts/find_srcfile kbuild-2.5/scripts/find_srcfile
--- kbuild-2.5/scripts/find_srcfile Fri May 31 15:54:31 2002
+++ kbuild-2.5/scripts/find_srcfile Fri May 31 15:54:31 2002 +0000 thunder (thunder-2.5/scripts/find_srcfile 1.1 0644)
@@ -0,0 +1,22 @@
+#!/bin/sh
+for i in $(env | sed -ne '/^KBUILD_SRCTREE_[0-9][0-9][0-9]=/s/=.*//p' | sort -r)
+do
+	eval file="\$$i/$1"
+	if [ -f $file ]
+	then
+		echo $file
+		exit 0
+	fi
+done
+exit 1
+#!/bin/sh
+for i in $(env | sed -ne '/^KBUILD_SRCTREE_[0-9][0-9][0-9]=/s/=.*//p' | sort -r)
+do
+	eval file="\$$i/$1"
+	if [ -f $file ]
+	then
+		echo $file
+		exit 0
+	fi
+done
+exit 1
diff -Nur kbuild-2.5/scripts/get_one_config kbuild-2.5/scripts/get_one_config
--- kbuild-2.5/scripts/get_one_config Fri May 31 15:54:30 2002
+++ kbuild-2.5/scripts/get_one_config Fri May 31 15:54:30 2002 +0000 thunder (thunder-2.5/scripts/get_one_config 1.1 0644)
@@ -0,0 +1,30 @@
+#!/bin/sh
+
+# In an ideal world the top level makefile would be completely independent of
+# the config, it should only contain global settings that apply to all builds.
+# However at least one architecture (ppc) is breaking the rules, its include
+# path depends on the config settings instead of using the same include paths as
+# everyone else.
+#
+# I do _not_ want to include .config in the top level makefile, it leads to make
+# recursion hell, see the barf bag code in scripts/Makefile-2.5.  The script
+# below extracts and prints one option from .config, without tripping the
+# recursion problem.  If .config does not exist or the option is not set then it
+# prints nothing.  KAO
+
+[ -r $KBUILD_OBJTREE/.config ] && sed -ne "/^$1=/s/^$1=//p" $KBUILD_OBJTREE/.config
+#!/bin/sh
+
+# In an ideal world the top level makefile would be completely independent of
+# the config, it should only contain global settings that apply to all builds.
+# However at least one architecture (ppc) is breaking the rules, its include
+# path depends on the config settings instead of using the same include paths as
+# everyone else.
+#
+# I do _not_ want to include .config in the top level makefile, it leads to make
+# recursion hell, see the barf bag code in scripts/Makefile-2.5.  The script
+# below extracts and prints one option from .config, without tripping the
+# recursion problem.  If .config does not exist or the option is not set then it
+# prints nothing.  KAO
+
+[ -r $KBUILD_OBJTREE/.config ] && sed -ne "/^$1=/s/^$1=//p" $KBUILD_OBJTREE/.config
diff -Nur kbuild-2.5/scripts/include_list.awk kbuild-2.5/scripts/include_list.awk
--- kbuild-2.5/scripts/include_list.awk Fri May 31 15:54:29 2002
+++ kbuild-2.5/scripts/include_list.awk Fri May 31 15:54:29 2002 +0000 thunder (thunder-2.5/scripts/include_list.awk 1.1 0644)
@@ -0,0 +1,172 @@
+BEGIN {
+  outfile1 = ARGV[1]
+  outfile2 = ARGV[2]
+  printf("#!/bin/sh\n") > outfile1
+  printf("set -e\n") > outfile1
+  printf("if [ \"$KBUILD_WRITABLE\" = \"y\" ]\n") > outfile1
+  printf("then\n") > outfile1
+  printf("  rm -rf .tmp_include\n") > outfile1
+  printf("fi\n") > outfile1
+  obj = ENVIRON["KBUILD_OBJTREE"]
+  if (obj == "") {
+    printf("echo KBUILD_OBJTREE is not defined\n") > outfile1
+    exit(1)
+  }
+  gsub(/\/*$/, "", obj)
+  obj = obj "/"
+  printf("override KBUILD_OBJTREE := %s\n", obj) > outfile2
+  paths = ENVIRON["KBUILD_INCLUDE_PATHS"]
+  if (paths == "") {
+    printf("echo KBUILD_INCLUDE_PATHS is not defined\n") > outfile1
+    exit(1)
+  }
+  split(paths, path)
+  for (p in path) {
+    gsub(/\/*$/, "", path[p])
+    path[p] = path[p] "/"
+  }
+  dirs = ENVIRON["KBUILD_INCLUDE_DIRS"]
+  if (dirs == "") {
+    printf("echo KBUILD_INCLUDE_DIRS is not defined\n") > outfile1
+    exit(1)
+  }
+  split(dirs, dir)
+  for (d in dir) {
+    gsub(/\/*$/, "", dir[d])
+    # dir cannot have trailing '/', ln -s complains
+  }
+  arch = ENVIRON["ARCH"]
+  if (arch == "") {
+    printf("echo ARCH is not defined\n") > outfile1
+    exit(1)
+  }
+  for (p in path) {
+    # objtree comes first to read generated include files.
+    printf("echo -I%s\n", path[p]) > outfile1
+    if (common_src_obj) {
+      printf("rm -f %s%sasm\n", src, path[p]) > outfile1
+      printf("ln -s asm-%s %s%sasm\n", arch, src, path[p]) > outfile1
+    }	
+    else {
+      for (i = 998; i >= 0; --i) {
+	srcname = sprintf("KBUILD_SRCTREE_%03d", i)
+	src = ENVIRON[srcname]
+	if (src != "") {
+	  common_src_obj = src == obj
+	  gsub(/\/*$/, "", src)
+	  src = src "/"
+	  printf("override %s := %s\n", srcname, src) > outfile2
+	  printf("result=\n") > outfile1
+	  printf("if [ -d %s%sasm-%s ]\n", src, path[p], arch) > outfile1
+	  printf("then\n") > outfile1
+	  printf("  if [ \"$KBUILD_WRITABLE\" = \"y\" ]\n") > outfile1
+	  printf("  then\n") > outfile1
+	  printf("    mkdir -p .tmp_include/src_%03d/%s\n", i, path[p]) > outfile1
+	  printf("    ln -s %s%sasm-%s .tmp_include/src_%03d/%sasm\n", src, path[p], arch, i, path[p]) > outfile1
+	  printf("  fi\n") > outfile1
+	  printf("  result='-I.tmp_include/src_%03d/%s'\n", i, path[p]) > outfile1
+	  printf("fi\n") > outfile1
+	  for (d in dir) {
+	    printf("if [ -d %s%s%s ]\n", src, path[p], dir[d]) > outfile1
+	    printf("then\n") > outfile1
+	    printf("  if [ \"$KBUILD_WRITABLE\" = \"y\" ]\n") > outfile1
+	    printf("  then\n") > outfile1
+	    printf("    mkdir -p .tmp_include/src_%03d/%s\n", i, path[p]) > outfile1
+	    printf("    ln -s %s%s%s .tmp_include/src_%03d/%s%s\n", src, path[p], dir[d], i, path[p], dir[d]) > outfile1
+	    printf("  fi\n") > outfile1
+	    printf("  result='-I.tmp_include/src_%03d/%s'\n", i, path[p]) > outfile1
+	    printf("fi\n") > outfile1
+	  }
+	  printf("echo $result | sed -e 's:/*$::'\n") > outfile1
+	}
+      }
+    }
+  }
+  stop
+}
+BEGIN {
+  outfile1 = ARGV[1]
+  outfile2 = ARGV[2]
+  printf("#!/bin/sh\n") > outfile1
+  printf("set -e\n") > outfile1
+  printf("if [ \"$KBUILD_WRITABLE\" = \"y\" ]\n") > outfile1
+  printf("then\n") > outfile1
+  printf("  rm -rf .tmp_include\n") > outfile1
+  printf("fi\n") > outfile1
+  obj = ENVIRON["KBUILD_OBJTREE"]
+  if (obj == "") {
+    printf("echo KBUILD_OBJTREE is not defined\n") > outfile1
+    exit(1)
+  }
+  gsub(/\/*$/, "", obj)
+  obj = obj "/"
+  printf("override KBUILD_OBJTREE := %s\n", obj) > outfile2
+  paths = ENVIRON["KBUILD_INCLUDE_PATHS"]
+  if (paths == "") {
+    printf("echo KBUILD_INCLUDE_PATHS is not defined\n") > outfile1
+    exit(1)
+  }
+  split(paths, path)
+  for (p in path) {
+    gsub(/\/*$/, "", path[p])
+    path[p] = path[p] "/"
+  }
+  dirs = ENVIRON["KBUILD_INCLUDE_DIRS"]
+  if (dirs == "") {
+    printf("echo KBUILD_INCLUDE_DIRS is not defined\n") > outfile1
+    exit(1)
+  }
+  split(dirs, dir)
+  for (d in dir) {
+    gsub(/\/*$/, "", dir[d])
+    # dir cannot have trailing '/', ln -s complains
+  }
+  arch = ENVIRON["ARCH"]
+  if (arch == "") {
+    printf("echo ARCH is not defined\n") > outfile1
+    exit(1)
+  }
+  for (p in path) {
+    # objtree comes first to read generated include files.
+    printf("echo -I%s\n", path[p]) > outfile1
+    if (common_src_obj) {
+      printf("rm -f %s%sasm\n", src, path[p]) > outfile1
+      printf("ln -s asm-%s %s%sasm\n", arch, src, path[p]) > outfile1
+    }	
+    else {
+      for (i = 998; i >= 0; --i) {
+	srcname = sprintf("KBUILD_SRCTREE_%03d", i)
+	src = ENVIRON[srcname]
+	if (src != "") {
+	  common_src_obj = src == obj
+	  gsub(/\/*$/, "", src)
+	  src = src "/"
+	  printf("override %s := %s\n", srcname, src) > outfile2
+	  printf("result=\n") > outfile1
+	  printf("if [ -d %s%sasm-%s ]\n", src, path[p], arch) > outfile1
+	  printf("then\n") > outfile1
+	  printf("  if [ \"$KBUILD_WRITABLE\" = \"y\" ]\n") > outfile1
+	  printf("  then\n") > outfile1
+	  printf("    mkdir -p .tmp_include/src_%03d/%s\n", i, path[p]) > outfile1
+	  printf("    ln -s %s%sasm-%s .tmp_include/src_%03d/%sasm\n", src, path[p], arch, i, path[p]) > outfile1
+	  printf("  fi\n") > outfile1
+	  printf("  result='-I.tmp_include/src_%03d/%s'\n", i, path[p]) > outfile1
+	  printf("fi\n") > outfile1
+	  for (d in dir) {
+	    printf("if [ -d %s%s%s ]\n", src, path[p], dir[d]) > outfile1
+	    printf("then\n") > outfile1
+	    printf("  if [ \"$KBUILD_WRITABLE\" = \"y\" ]\n") > outfile1
+	    printf("  then\n") > outfile1
+	    printf("    mkdir -p .tmp_include/src_%03d/%s\n", i, path[p]) > outfile1
+	    printf("    ln -s %s%s%s .tmp_include/src_%03d/%s%s\n", src, path[p], dir[d], i, path[p], dir[d]) > outfile1
+	    printf("  fi\n") > outfile1
+	    printf("  result='-I.tmp_include/src_%03d/%s'\n", i, path[p]) > outfile1
+	    printf("fi\n") > outfile1
+	  }
+	  printf("echo $result | sed -e 's:/*$::'\n") > outfile1
+	}
+      }
+    }
+  }
+  stop
+}
diff -Nur kbuild-2.5/scripts/kernel-doc kbuild-2.5/scripts/kernel-doc
--- kbuild-2.5/scripts/kernel-doc Fri May 31 15:49:33 2002
+++ kbuild-2.5/scripts/kernel-doc Fri May 31 15:49:33 2002 +0000 thunder (thunder-2.5/scripts/kernel-doc 1.1 0644)
@@ -1417,7 +1417,7 @@
 
 # Read the file that maps relative names to absolute names for
 # separate source and object directories and for shadow trees.
-if (open(SOURCE_MAP, "<.tmp_filelist.txt")) {
+if (open(SOURCE_MAP, "<.tmp_filelist")) {
 	my ($relname, $absname);
 	while(<SOURCE_MAP>) {
 		chop();
diff -Nur kbuild-2.5/scripts/kwhich kbuild-2.5/scripts/kwhich
--- kbuild-2.5/scripts/kwhich Fri May 31 15:54:29 2002
+++ kbuild-2.5/scripts/kwhich Fri May 31 15:54:29 2002 +0000 thunder (thunder-2.5/scripts/kwhich 1.1 0644)
@@ -0,0 +1,48 @@
+# kwhich 1.0 (C) 2000 Miquel van Smoorenburg
+# This program is GPLed
+
+if [ $# -lt 1 ]
+then
+        echo "Usage: $0 cmd [cmd..]" >&2
+        exit 1
+fi
+
+IFS=:
+for cmd in "$@"
+do
+        for path in $PATH
+        do
+                if [ -x "$path/$cmd" ]
+                then
+                        echo "$path/$cmd"
+                        exit 0
+                fi
+        done
+done
+
+echo "$@: not found" >&2
+exit 1
+# kwhich 1.0 (C) 2000 Miquel van Smoorenburg
+# This program is GPLed
+
+if [ $# -lt 1 ]
+then
+        echo "Usage: $0 cmd [cmd..]" >&2
+        exit 1
+fi
+
+IFS=:
+for cmd in "$@"
+do
+        for path in $PATH
+        do
+                if [ -x "$path/$cmd" ]
+                then
+                        echo "$path/$cmd"
+                        exit 0
+                fi
+        done
+done
+
+echo "$@: not found" >&2
+exit 1
diff -Nur kbuild-2.5/scripts/lilo_new_kernel kbuild-2.5/scripts/lilo_new_kernel
--- kbuild-2.5/scripts/lilo_new_kernel Fri May 31 15:54:30 2002
+++ kbuild-2.5/scripts/lilo_new_kernel Fri May 31 15:54:30 2002 +0000 thunder (thunder-2.5/scripts/lilo_new_kernel 1.1 0644)
@@ -0,0 +1,58 @@
+#!/bin/sh
+#
+#  This is a sample script to add a new kernel to /etc/lilo.conf.  If it
+#  does not do what you want, copy this script to somewhere outside the
+#  kernel, change the copy and point your .config at the modified copy.
+#  Then you do not need to change the script when you upgrade your kernel.
+#
+
+label=$(echo "$KERNELRELEASE" | cut -c1-15)
+if ! grep "label=$label\$" /etc/lilo.conf > /dev/null
+then
+  ed /etc/lilo.conf > /dev/null 2>&1 <<EODATA 
+/^image/
+i
+image=$CONFIG_INSTALL_PREFIX_NAME$CONFIG_INSTALL_KERNEL_NAME
+	label=$label
+	optional
+
+.
+w
+q
+EODATA
+  if [ ! $? ]
+  then
+    echo edit of /etc/lilo.conf failed
+    exit 1
+  fi
+fi
+lilo
+#!/bin/sh
+#
+#  This is a sample script to add a new kernel to /etc/lilo.conf.  If it
+#  does not do what you want, copy this script to somewhere outside the
+#  kernel, change the copy and point your .config at the modified copy.
+#  Then you do not need to change the script when you upgrade your kernel.
+#
+
+label=$(echo "$KERNELRELEASE" | cut -c1-15)
+if ! grep "label=$label\$" /etc/lilo.conf > /dev/null
+then
+  ed /etc/lilo.conf > /dev/null 2>&1 <<EODATA 
+/^image/
+i
+image=$CONFIG_INSTALL_PREFIX_NAME$CONFIG_INSTALL_KERNEL_NAME
+	label=$label
+	optional
+
+.
+w
+q
+EODATA
+  if [ ! $? ]
+  then
+    echo edit of /etc/lilo.conf failed
+    exit 1
+  fi
+fi
+lilo
diff -Nur kbuild-2.5/scripts/mkdep.c kbuild-2.5/scripts/mkdep.c
--- kbuild-2.5/scripts/mkdep.c Fri May 31 15:49:35 2002
+++ kbuild-2.5/scripts/mkdep.c Fri May 31 15:49:35 2002 +0000 thunder (thunder-2.5/scripts/mkdep.c 1.1 0644)
@@ -268,7 +268,7 @@
 
 	for (i = 0; i < len; i++) {
 	    char c = name[i];
-	    if (isupper(c)) c = tolower(c);
+	    if (isupper((int)c)) c = tolower((int)c);
 	    if (c == '_')   c = '/';
 	    pc[i] = c;
 	}
@@ -496,7 +496,7 @@
 
 /* \<CONFIG_(\w*) */
 cee:
-	if (next >= map+2 && (isalnum(next[-2]) || next[-2] == '_'))
+	if (next >= map+2 && (isalnum((int)next[-2]) || next[-2] == '_'))
 		goto start;
 	GETNEXT NOTCASE('O', __start);
 	GETNEXT NOTCASE('N', __start);
diff -Nur kbuild-2.5/scripts/shadow.pl kbuild-2.5/scripts/shadow.pl
--- kbuild-2.5/scripts/shadow.pl Fri May 31 15:54:30 2002
+++ kbuild-2.5/scripts/shadow.pl Fri May 31 15:54:30 2002 +0000 thunder (thunder-2.5/scripts/shadow.pl 1.1 0644)
@@ -0,0 +1,40 @@
+#!/usr/bin/perl -w
+require 5;
+use strict;
+my @nametree;
+my @field;
+my ($line, $index);
+
+while (defined($line = <>)) {
+	chomp($line);
+	@field = (split(' ', $line));
+	if ($field[0] =~ m:^/\.tmp_nametree/:) {
+		$field[0] =~ m:/\.tmp_nametree(.*)/0*(\d+)$:;
+		$nametree[$2] = $1;
+	}
+	if ($field[0] =~ m:^/\.tmp_shadow/:) {
+		$field[0] =~ m:/\.tmp_shadow/(.*)/0*(\d+)$:;
+		printf("%s %s %s %s %s\n",
+			$1, $2, $field[2], $nametree[$2], $nametree[$field[2]]);
+	}
+}
+#!/usr/bin/perl -w
+require 5;
+use strict;
+my @nametree;
+my @field;
+my ($line, $index);
+
+while (defined($line = <>)) {
+	chomp($line);
+	@field = (split(' ', $line));
+	if ($field[0] =~ m:^/\.tmp_nametree/:) {
+		$field[0] =~ m:/\.tmp_nametree(.*)/0*(\d+)$:;
+		$nametree[$2] = $1;
+	}
+	if ($field[0] =~ m:^/\.tmp_shadow/:) {
+		$field[0] =~ m:/\.tmp_shadow/(.*)/0*(\d+)$:;
+		printf("%s %s %s %s %s\n",
+			$1, $2, $field[2], $nametree[$2], $nametree[$field[2]]);
+	}
+}
diff -Nur kbuild-2.5/scripts/split-include.c kbuild-2.5/scripts/split-include.c
--- kbuild-2.5/scripts/split-include.c Fri May 31 15:49:34 2002
+++ kbuild-2.5/scripts/split-include.c Fri May 31 15:49:34 2002 +0000 thunder (thunder-2.5/scripts/split-include.c 1.1 0644)
@@ -115,10 +115,10 @@
 
 	/* Make the output file name. */
 	str_config += sizeof("CONFIG_") - 1;
-	for (itarget = 0; !isspace(str_config[itarget]); itarget++)
+	for (itarget = 0; !isspace((int)str_config[itarget]); itarget++)
 	{
 	    char c = str_config[itarget];
-	    if (isupper(c)) c = tolower(c);
+	    if (isupper((int)c)) c = tolower((int)c);
 	    if (c == '_')   c = '/';
 	    ptarget[itarget] = c;
 	}
diff -Nur kbuild-2.5/scripts/tkparse.c kbuild-2.5/scripts/tkparse.c
--- kbuild-2.5/scripts/tkparse.c Fri May 31 15:49:36 2002
+++ kbuild-2.5/scripts/tkparse.c Fri May 31 15:49:36 2002 +0000 thunder (thunder-2.5/scripts/tkparse.c 1.1 0644)
@@ -74,12 +74,12 @@
 
 
 /*
- * Find index of a specyfic variable in the symbol table.
+ * Find index of a specific variable in the symbol table.
  * Create a new entry if it does not exist yet.
  */
-#define VARTABLE_SIZE 4096
-struct variable vartable[VARTABLE_SIZE];
+struct variable *vartable;
 int max_varnum = 0;
+static int vartable_size = 0;
 
 int get_varnum( char * name )
 {
@@ -88,8 +88,13 @@
     for ( i = 1; i <= max_varnum; i++ )
 	if ( strcmp( vartable[i].name, name ) == 0 )
 	    return i;
-    if (max_varnum > VARTABLE_SIZE-1)
-	syntax_error( "Too many variables defined." );
+    while (max_varnum+1 >= vartable_size) {
+	vartable = realloc(vartable, (vartable_size += 1000)*sizeof(*vartable));
+	if (!vartable) {
+	    fprintf(stderr, "tkparse realloc vartable failed\n");
+	    exit(1);
+	}
+    }
     vartable[++max_varnum].name = malloc( strlen( name )+1 );
     strcpy( vartable[max_varnum].name, name );
     return max_varnum;
@@ -818,5 +823,6 @@
     do_source        ( "-"         );
     fix_conditionals ( config_list );
     dump_tk_script   ( config_list );
+    free(vartable);
     return 0;
 }
diff -Nur kbuild-2.5/scripts/tkparse.h kbuild-2.5/scripts/tkparse.h
--- kbuild-2.5/scripts/tkparse.h Fri May 31 15:49:37 2002
+++ kbuild-2.5/scripts/tkparse.h Fri May 31 15:49:37 2002 +0000 thunder (thunder-2.5/scripts/tkparse.h 1.1 0644)
@@ -115,7 +115,7 @@
     char	global_written;
 };
 
-extern struct variable vartable[];
+extern struct variable *vartable;
 extern int max_varnum;
 
 /*
diff -Nur kbuild-2.5/symbols-2.5.cml kbuild-2.5/symbols-2.5.cml
--- kbuild-2.5/symbols-2.5.cml Fri May 31 15:54:30 2002
+++ kbuild-2.5/symbols-2.5.cml Fri May 31 15:54:30 2002 +0000 thunder (thunder-2.5/symbols-2.5.cml 1.1 0644)
@@ -0,0 +1,352 @@
+# Additional symbols for kbuild 2.5, merge with the main list later.
+
+symbols
+VMLINUX_help 'vmlinux' text
+This is the raw format that is produced by the kernel build.  It is
+required to use any of the various source debugging tools on the kernel
+itself and is the only bootable format on some architectures.  It is
+generally too large to be used otherwise.
+
+Note that the `vmlinux' format is produced by ALL compilations, either
+as the target step, or as an intermediate step in the production of one
+of the other formats.
+.
+VMLINUZ_help 'vmlinuz' text
+vmlinux after being stripped to remove debugging information then
+compressed using gzip.  This is still the same basic format as vmlinux,
+just smaller.
+.
+ZIMAGE_help 'zImage' text
+This is the result of running the vmlinux format kernel through `gzip
+-9` to produce a much compressed version of the same, then adding a old
+style ix86 boot routine.
+
+This format can only boot if the resultant image is less than 508k in
+size. As a result, it is of little use with recent kernels.  Only use
+zImage if your hardware will not boot with bzImage, and only after a
+kernel hacker says to use zImage.  This format may be removed.
+.
+BZIMAGE_help 'bzImage' text
+This is the result of running the vmlinux format kernel through `gzip
+-9` but it has a newer ix86 boot routine that can handle kernels whose
+compressed size exceeds 508k. In theory, the boot routine can handle
+kernel image files up to 15M in size, but this limit has not yet been
+tested.
+
+Note that bzImage format does NOT use the `bzip' or `bzip2' compression
+programs, as some have suggested.
+.
+VMLINUX_SREC_help 'vmlinux.srec' text
+This is the vmlinux file converted to Motorola S-Record format, often
+required for transferring the kernel to boot loaders on embedded
+systems.
+.
+VMLINUX_BIN_help 'vmlinux.bin' text
+This is the raw kernel image in binary format -- an exact copy of which
+is loaded into memory before booting.  This is used for primitive
+bootloaders on embedded systems, which cannot understand ELF or SREC
+images, or when the kernel is to reside in flash and be executed
+directly.
+.
+
+INSTALL_PREFIX 'Use a prefix on install paths' text
+If you want to copy the installed kernel and modules to another machine
+or you are installing on another disk on this machine, you can set a
+prefix on the install paths.  To install in the standard locations on
+the current machine, do not set an install prefix.  Most users will
+want N.
+.
+INSTALL_PREFIX_NAME 'Prefix for install paths' text
+This string is prefixed to all the paths when installing the kernel and
+modules.  If you want to copy the installed kernel and modules to
+another machine or another disk, use the install prefix to point to
+another directory, say "/var/tmp".  The target directories will be
+created under this prefix, if necessary.
+
+Modules are always installed in
+CONFIG_INSTALL_PREFIX_NAME/lib/modules/KERNELRELEASE.
+
+Any words in the path that start with an upper case letter and consist
+only of upper case letters, '_' and digits are replaced by the value of
+the corresponding variable.  This includes KERNELRELEASE, VERSION,
+PATCHLEVEL, SUBLEVEL, EXTRAVERSION, USERVERSION, KBUILD_SRCTREE_nnn.
+.
+INSTALL_KERNEL_NAME 'Where to install the kernel' text
+Specifies which file name the kernel will be installed under.  If your
+boot loader requires the kernel to be in a specific directory or in a
+specific area of the disk then follow the loader instructions.
+Otherwise follow the standard for your distribution, or your own
+preference.  The path will be prefixed by CONFIG_INSTALL_PREFIX.
+
+Any words in the path that start with an upper case letter and consist
+only of upper case letters, '_' and digits are replaced by the value of
+the corresponding variable.  This includes KERNELRELEASE, VERSION,
+PATCHLEVEL, SUBLEVEL, EXTRAVERSION, USERVERSION, KBUILD_SRCTREE_nnn.
+KERNELFULLNAME and KERNELBASENAME are set to the full name (relative
+to the object directory) and the base name of the kernel respectively.
+
+Examples:  /boot/efi/KERNELBASENAME-KERNELRELEASE - IA64 requires
+             /boot/efi
+	   /boot/KERNELBASENAME-KERNELRELEASE - old "standard"
+           /lib/modules/KERNELRELEASE/KERNELBASENAME - preferred,
+             unless the boot loader or lack of space requires another
+             location.
+.
+INSTALL_SYSTEM_MAP 'Install System.map' text
+The System.map is not required for booting, but it is used by a lot of
+kernel utilities, including ps and ksymoops.  Unless you have a good
+reason not to install the System.map, say Y.
+.
+INSTALL_SYSTEM_MAP_NAME 'Where to install System.map' text
+Specifies which file name the System.map will be installed under.
+Because System.map is not required for booting, it should not be
+installed in a special boot directory.  Unless you have a good reason
+to install System.map somewhere else, use the default value of
+/lib/modules/KERNELRELEASE/System.map.  The path will be prefixed by
+CONFIG_INSTALL_PREFIX.
+
+Any words in the path that start with an upper case letter and consist
+only of upper case letters, '_' and digits are replaced by the value of
+the corresponding variable.  This includes KERNELRELEASE, VERSION,
+PATCHLEVEL, SUBLEVEL, EXTRAVERSION, USERVERSION, KBUILD_SRCTREE_nnn.
+.
+INSTALL_CONFIG 'Install .config' text
+It is a good idea to save the .config used to build the kernel and
+modules, it is useful for bug reporting and for building a new version
+of the kernel.  Unless you have a good reason not to install the
+.config, say Y.
+.
+INSTALL_CONFIG_NAME 'Where to install .config' text
+Specifies which file name the .config will be installed under.  Because
+.config is not required for booting, it should not be installed in a
+special boot directory.  Unless you have a good reason to install
+.config somewhere else, use the default value of
+/lib/modules/KERNELRELEASE/.config.  The path will be prefixed by
+CONFIG_INSTALL_PREFIX.
+
+Any words in the path that start with an upper case letter and consist
+only of upper case letters, '_' and digits are replaced by the value of
+the corresponding variable.  This includes KERNELRELEASE, VERSION,
+PATCHLEVEL, SUBLEVEL, EXTRAVERSION, USERVERSION, KBUILD_SRCTREE_nnn.
+.
+INSTALL_VMLINUX 'Install vmlinux for debugging' text
+If you are debugging a kernel, you usually need vmlinux as well as the
+bootable kernel.  Unless you plan to debug the kernel, reply N.
+.
+INSTALL_VMLINUX_NAME 'Where to install vmlinux' text
+If you are debugging a kernel, you usually need vmlinux as well as the
+bootable kernel.  For debugging, the recommended value is
+/lib/modules/KERNELRELEASE/vmlinux.  The path will be prefixed by
+CONFIG_INSTALL_PREFIX.
+
+Any words in the path that start with an upper case letter and consist
+only of upper case letters, '_' and digits are replaced by the value of
+the corresponding variable.  This includes KERNELRELEASE, VERSION,
+PATCHLEVEL, SUBLEVEL, EXTRAVERSION, USERVERSION, KBUILD_SRCTREE_nnn.
+.
+INSTALL_SCRIPT 'Run a post-install script or command' text
+If you perform some extra work after installing the kernel and modules,
+specify Y here.  This includes automatically updating your boot loader
+with the new kernel.
+.
+INSTALL_SCRIPT_NAME 'Post-install script or command name' text
+If you perform some extra work after installing the kernel and modules,
+specify the name of your script or command here.  It will be invoked
+after copying the kernel and modules to the target locations.  The
+CONFIG_INSTALL_* variables will be in the environment of your script,
+as well as all variables exported by the top level Makefile, including
+KERNELRELEASE, VERSION, PATCHLEVEL, SUBLEVEL, EXTRAVERSION,
+USERVERSION, KBUILD_OBJTREE, KBUILD_SRCTREE_nnn.
+
+If your boot loader needs to be run to pick up the new kernel location,
+you can insert the loader command in this field.  The command or script
+must be executable.  LILO users might find this to be useful,
+  KBUILD_SRCTREE_000/scripts/lilo_new_kernel
+It adds CONFIG_INSTALL_PREFIX_NAME/CONFIG_INSTALL_KERNEL_NAME to
+/etc/lilo.conf with a label of KERNELRELEASE (truncated to 15
+characters) then runs lilo.
+
+Any words in the path that start with an upper case letter and consist
+only of upper case letters, '_' and digits are replaced by the value of
+the corresponding variable.  This includes KERNELRELEASE, VERSION,
+PATCHLEVEL, SUBLEVEL, EXTRAVERSION, USERVERSION, KBUILD_SRCTREE_nnn.
+.
+
+menus addon "Add on features (may be empty)"
+      installation "Installation"
+# Additional symbols for kbuild 2.5, merge with the main list later.
+
+symbols
+VMLINUX_help 'vmlinux' text
+This is the raw format that is produced by the kernel build.  It is
+required to use any of the various source debugging tools on the kernel
+itself and is the only bootable format on some architectures.  It is
+generally too large to be used otherwise.
+
+Note that the `vmlinux' format is produced by ALL compilations, either
+as the target step, or as an intermediate step in the production of one
+of the other formats.
+.
+VMLINUZ_help 'vmlinuz' text
+vmlinux after being stripped to remove debugging information then
+compressed using gzip.  This is still the same basic format as vmlinux,
+just smaller.
+.
+ZIMAGE_help 'zImage' text
+This is the result of running the vmlinux format kernel through `gzip
+-9` to produce a much compressed version of the same, then adding a old
+style ix86 boot routine.
+
+This format can only boot if the resultant image is less than 508k in
+size. As a result, it is of little use with recent kernels.  Only use
+zImage if your hardware will not boot with bzImage, and only after a
+kernel hacker says to use zImage.  This format may be removed.
+.
+BZIMAGE_help 'bzImage' text
+This is the result of running the vmlinux format kernel through `gzip
+-9` but it has a newer ix86 boot routine that can handle kernels whose
+compressed size exceeds 508k. In theory, the boot routine can handle
+kernel image files up to 15M in size, but this limit has not yet been
+tested.
+
+Note that bzImage format does NOT use the `bzip' or `bzip2' compression
+programs, as some have suggested.
+.
+VMLINUX_SREC_help 'vmlinux.srec' text
+This is the vmlinux file converted to Motorola S-Record format, often
+required for transferring the kernel to boot loaders on embedded
+systems.
+.
+VMLINUX_BIN_help 'vmlinux.bin' text
+This is the raw kernel image in binary format -- an exact copy of which
+is loaded into memory before booting.  This is used for primitive
+bootloaders on embedded systems, which cannot understand ELF or SREC
+images, or when the kernel is to reside in flash and be executed
+directly.
+.
+
+INSTALL_PREFIX 'Use a prefix on install paths' text
+If you want to copy the installed kernel and modules to another machine
+or you are installing on another disk on this machine, you can set a
+prefix on the install paths.  To install in the standard locations on
+the current machine, do not set an install prefix.  Most users will
+want N.
+.
+INSTALL_PREFIX_NAME 'Prefix for install paths' text
+This string is prefixed to all the paths when installing the kernel and
+modules.  If you want to copy the installed kernel and modules to
+another machine or another disk, use the install prefix to point to
+another directory, say "/var/tmp".  The target directories will be
+created under this prefix, if necessary.
+
+Modules are always installed in
+CONFIG_INSTALL_PREFIX_NAME/lib/modules/KERNELRELEASE.
+
+Any words in the path that start with an upper case letter and consist
+only of upper case letters, '_' and digits are replaced by the value of
+the corresponding variable.  This includes KERNELRELEASE, VERSION,
+PATCHLEVEL, SUBLEVEL, EXTRAVERSION, USERVERSION, KBUILD_SRCTREE_nnn.
+.
+INSTALL_KERNEL_NAME 'Where to install the kernel' text
+Specifies which file name the kernel will be installed under.  If your
+boot loader requires the kernel to be in a specific directory or in a
+specific area of the disk then follow the loader instructions.
+Otherwise follow the standard for your distribution, or your own
+preference.  The path will be prefixed by CONFIG_INSTALL_PREFIX.
+
+Any words in the path that start with an upper case letter and consist
+only of upper case letters, '_' and digits are replaced by the value of
+the corresponding variable.  This includes KERNELRELEASE, VERSION,
+PATCHLEVEL, SUBLEVEL, EXTRAVERSION, USERVERSION, KBUILD_SRCTREE_nnn.
+KERNELFULLNAME and KERNELBASENAME are set to the full name (relative
+to the object directory) and the base name of the kernel respectively.
+
+Examples:  /boot/efi/KERNELBASENAME-KERNELRELEASE - IA64 requires
+             /boot/efi
+	   /boot/KERNELBASENAME-KERNELRELEASE - old "standard"
+           /lib/modules/KERNELRELEASE/KERNELBASENAME - preferred,
+             unless the boot loader or lack of space requires another
+             location.
+.
+INSTALL_SYSTEM_MAP 'Install System.map' text
+The System.map is not required for booting, but it is used by a lot of
+kernel utilities, including ps and ksymoops.  Unless you have a good
+reason not to install the System.map, say Y.
+.
+INSTALL_SYSTEM_MAP_NAME 'Where to install System.map' text
+Specifies which file name the System.map will be installed under.
+Because System.map is not required for booting, it should not be
+installed in a special boot directory.  Unless you have a good reason
+to install System.map somewhere else, use the default value of
+/lib/modules/KERNELRELEASE/System.map.  The path will be prefixed by
+CONFIG_INSTALL_PREFIX.
+
+Any words in the path that start with an upper case letter and consist
+only of upper case letters, '_' and digits are replaced by the value of
+the corresponding variable.  This includes KERNELRELEASE, VERSION,
+PATCHLEVEL, SUBLEVEL, EXTRAVERSION, USERVERSION, KBUILD_SRCTREE_nnn.
+.
+INSTALL_CONFIG 'Install .config' text
+It is a good idea to save the .config used to build the kernel and
+modules, it is useful for bug reporting and for building a new version
+of the kernel.  Unless you have a good reason not to install the
+.config, say Y.
+.
+INSTALL_CONFIG_NAME 'Where to install .config' text
+Specifies which file name the .config will be installed under.  Because
+.config is not required for booting, it should not be installed in a
+special boot directory.  Unless you have a good reason to install
+.config somewhere else, use the default value of
+/lib/modules/KERNELRELEASE/.config.  The path will be prefixed by
+CONFIG_INSTALL_PREFIX.
+
+Any words in the path that start with an upper case letter and consist
+only of upper case letters, '_' and digits are replaced by the value of
+the corresponding variable.  This includes KERNELRELEASE, VERSION,
+PATCHLEVEL, SUBLEVEL, EXTRAVERSION, USERVERSION, KBUILD_SRCTREE_nnn.
+.
+INSTALL_VMLINUX 'Install vmlinux for debugging' text
+If you are debugging a kernel, you usually need vmlinux as well as the
+bootable kernel.  Unless you plan to debug the kernel, reply N.
+.
+INSTALL_VMLINUX_NAME 'Where to install vmlinux' text
+If you are debugging a kernel, you usually need vmlinux as well as the
+bootable kernel.  For debugging, the recommended value is
+/lib/modules/KERNELRELEASE/vmlinux.  The path will be prefixed by
+CONFIG_INSTALL_PREFIX.
+
+Any words in the path that start with an upper case letter and consist
+only of upper case letters, '_' and digits are replaced by the value of
+the corresponding variable.  This includes KERNELRELEASE, VERSION,
+PATCHLEVEL, SUBLEVEL, EXTRAVERSION, USERVERSION, KBUILD_SRCTREE_nnn.
+.
+INSTALL_SCRIPT 'Run a post-install script or command' text
+If you perform some extra work after installing the kernel and modules,
+specify Y here.  This includes automatically updating your boot loader
+with the new kernel.
+.
+INSTALL_SCRIPT_NAME 'Post-install script or command name' text
+If you perform some extra work after installing the kernel and modules,
+specify the name of your script or command here.  It will be invoked
+after copying the kernel and modules to the target locations.  The
+CONFIG_INSTALL_* variables will be in the environment of your script,
+as well as all variables exported by the top level Makefile, including
+KERNELRELEASE, VERSION, PATCHLEVEL, SUBLEVEL, EXTRAVERSION,
+USERVERSION, KBUILD_OBJTREE, KBUILD_SRCTREE_nnn.
+
+If your boot loader needs to be run to pick up the new kernel location,
+you can insert the loader command in this field.  The command or script
+must be executable.  LILO users might find this to be useful,
+  KBUILD_SRCTREE_000/scripts/lilo_new_kernel
+It adds CONFIG_INSTALL_PREFIX_NAME/CONFIG_INSTALL_KERNEL_NAME to
+/etc/lilo.conf with a label of KERNELRELEASE (truncated to 15
+characters) then runs lilo.
+
+Any words in the path that start with an upper case letter and consist
+only of upper case letters, '_' and digits are replaced by the value of
+the corresponding variable.  This includes KERNELRELEASE, VERSION,
+PATCHLEVEL, SUBLEVEL, EXTRAVERSION, USERVERSION, KBUILD_SRCTREE_nnn.
+.
+
+menus addon "Add on features (may be empty)"
+      installation "Installation"

