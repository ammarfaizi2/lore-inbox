Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286336AbSBOC3s>; Thu, 14 Feb 2002 21:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286343AbSBOC3k>; Thu, 14 Feb 2002 21:29:40 -0500
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:56295 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S286336AbSBOC33>; Thu, 14 Feb 2002 21:29:29 -0500
Message-ID: <3C6C718C.8050402@drugphish.ch>
Date: Fri, 15 Feb 2002 03:25:16 +0100
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020126
X-Accept-Language: en-us
MIME-Version: 1.0
To: David Ford <david+cert@blue-labs.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ver_linux script updates
In-Reply-To: <3C6ADCAA.6080600@blue-labs.org> <3C6B0DF8.10209@drugphish.ch> <3C6B144C.4020904@blue-labs.org> <3C6B20FD.1070601@drugphish.ch> <3C6B6C01.8000403@blue-labs.org>
Content-Type: multipart/mixed;
 boundary="------------090109050102030504090708"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090109050102030504090708
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi,

> declare removed, printf can be a sh-util file as well as a bash built i=
n=20
> so I'm not concerned with that.

Well, you added it again in version 1.4 of your script. I removed it.=20
But I reckon you should write it in bash, can safe you some lines :)

> What is the full output of your loadkeys program with --junkoption?  I =

> avoided using combinations of programs and chose to concentrate on=20
> implementing a one program only solution which was common through the=20
> script.

Et voil=E0, feel free to vomit:

ratz@laphish:~ > grep declare ver_linux.*
ver_linux.txt:      declare -i count
ratz@laphish:~ > loadkeys --junkoption
loadkeys: unrecognized option `--junkoption'
loadkeys version 1.04

Usage: loadkeys [option...] [mapfile...]

valid options are:

	-c --clearcompose clear kernel compose table
	-d --default	  load "defkeymap.map"
	-h --help	  display this help text
	-m --mktable      output a "defkeymap.c" to stdout
	-s --clearstrings clear kernel string table
	-u --unicode      implicit conversion to Unicode
	-v --verbose      report the changes
ratz@laphish:~ >
> loadkeys is part of the kbd/console-tools mess.  It can report a=20
> version, not report a version, use --version or -V depending on what=20
> package or date in history your package comes from.

This is an information which you exactly don't have.

>> This is so gross you could as well do a strings on all those broken=20
>> binaries and maintain a table of offsets where to find the version=20
>> string.=20
> =20
> Unfortunately this would evolve into a big pile of versions and offsets=
=20
> that nobody would want to touch with a 10' pole.

I was more making a joke on this one ...

> One doesn't, it's a generic list that makes some assumptions.  To this =

> end, I've decided to add some /proc checking before searching for=20
> certain tool versions.

Ok, hope /proc-fs doesn't change semantics.

> One of the most visible points in history is pppd, for a long while it =

> seemed like the most frequently recurring bug post was why pppd didn't =

> work. The version the bug reporter had was less than required.

I haven't seen one in a year or so but I assume you know how Linux=20
kernel development history goes, so it's you call. I saw that you made=20
some /proc check for ppp. This is very acceptable then.

> I've just added checking to a few of the version searches that takes=20
> note from /proc files as to whether or not said support is loaded and=20
> running.  In other words it doesn't make to much sense to check for ppp=
d=20
> if the user doesn't use pppd.  Note that this can certainly be=20
> misconstrued and I should put a --verbose, or perhaps trying to be smar=
t=20
> here will just make matters worse.

Yes, agreed.

>> o Why is this script still in the kernel tree? It is not mentioned
>>   anywhere and it doesn't work reliably.=20
> =20
> It is mentioned in the top level REPORTING-BUGS file.

Oups, my bad, sorry.

>> The whole concept looks pretty broken to me, but then again I'm just a=
=20
>> little fart that doesn't see the big picture.=20
>=20
>=20
> It helps to clean up  some ambiguities when a bug report comes in.

Ok.

> I've updated it a few times since you've last retrieved it.

I saw. I attached a diff of your 1.4 to 1.5. Changelog:

o bumped version
o made echo ' ' -> echo. No need to pass strings
o safe/restore IFS. This is important in case you want to output lkm
   with spaces instead of newlines
o function truth() should check $1=3D=3D0 and not $@ because if one calls=

   truth() with more arguments, it fails.
o added yesno() function for tained mode
o added space to isdnlegitimate to read isdn legitimate
o rewrote modules output: I think it is cleaner now.
o removed remaining declare, printf is still there
o fixed ECN test already reported by another guy
o added tainted lkm checking

> Personally I dislike perl ['s bubblegum fixes everything approach], I=20
> don't think it's worth it to make such a heavy requirement of a user.=20
> The hang has been removed by adding the --junkoption, and as far as I=20
> know none of the given version checks should hang now.

You're right so far.

> Actually, on four of my seven systems I don't have 'fdformat' so=20
> 'util-linux' would have failed, but I -do- have 'mount' which is part o=
f=20
> the same package.

Then use mount which is obviously more often deployed than fdformat.

> The only problem with patching tools like this, is that it often doesn'=
t=20
> get back to the author or doesn't get implemented by the author, much=20
> less it doesn't fix earlier versions of the same software.

I've a some dozens of patches lying around exactly because one of your=20
above mentioned reasons. This, however, will never change. You tool=20
needs to be intelligent enough to handle broken user space apps.

> Ugg, don't get me started.  "pppd --version"  means I want the version.=
=20
> I don't give a flying fsck whether the kernel supports it or not, and I=
=20
> don't give a flying fsck if I have a messed up options file.  I want th=
e=20
> version, nothing more, nothing less. What's worse, there isn't a textua=
l=20
> string for the version in the binary that I can grab.

You seemed to have solved it in a way. One little invariant to fix=20
remains though. Think what happens with your script, when one doesn't=20
have proc-fs support ;)

Best regards,
Roberto Nibali, ratz

--------------090109050102030504090708
Content-Type: text/plain;
 name="ver_linux-1.5.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ver_linux-1.5.diff"

--- ver_linux.txt	Fri Feb 15 02:33:08 2002
+++ ver_linux.new	Fri Feb 15 03:20:54 2002
@@ -6,7 +6,7 @@
 #
 PATH=/sbin:/usr/sbin:/bin:/usr/bin:$PATH
 cat <<EOF
-Version: 1.4 (14 Feb 2002)
+Version: 1.5 (15 Feb 2002)
 If version fields appear unusual you may have an old version. Compare to the
 current minimal requirements in linux/Documentation/Changes. Please double
 check lines that say "error getting version, try manually" for validity.
@@ -19,9 +19,10 @@
 (grep ^Kernel /var/log/*dmesg* || (echo -n "Kernel command line: " ;\
       cat /proc/cmdline)) 2>/dev/null
 
-echo ' '
+echo
 
 function pv {
+      oldIFS=$IFS
       IFS=''
       title="$1"
       ver="$2"
@@ -30,27 +31,38 @@
       if [ "x$ver" == "x" -a "x$ev" != "x" ]; then
             eexists="$($ev --junkoption >/dev/null 2>&1 || echo $?)"
             if [ $eexists -eq 127 ]; then
+                  IFS=$oldIFS
                   return
             else
                   ver="error getting version, try manually"
             fi
       else
             if [ "x$ver" == "x" ]; then
+                  IFS=$oldIFS
                   return
             fi
       fi
 
       printf "%-34s%s\n" $title $ver
+      IFS=$oldIFS
 }
 
 function truth {
-      if [ "$@" == "0" ]; then
+      if [ "$1" == "0" ]; then
             echo "disabled";
       else
             echo "enabled"
       fi
 }
 
+function yesno {
+      if [ "$1" == "0" ]; then
+            echo "no";
+      else
+            echo "yes"
+      fi
+}
+
 pv "Gnu C compiler" "$(gcc --version 2>/dev/null)" gcc
 pv "Kgcc compiler" "$(kgcc --version 2>/dev/null)" kgcc
 
@@ -79,7 +91,7 @@
       awk '/^tune2fs/ {print $2}'|sed 's/,//')" tune2fs
 
 if [ $(grep -c reiserfs /proc/filesystems 2>/dev/null) -ne 0 ]; then
-pv "reiserfsprogs" \
+      pv "reiserfsprogs" \
       "$(reiserfsck 2>&1 |
       awk '/^reiserfsprogs/ {print $NF}')" reiserfsck
 fi
@@ -91,12 +103,12 @@
 fi
 
 if [ $(grep -c ppp /proc/devices 2>/dev/null) -ne 0 ]; then
-pv "pppd" \
+      pv "pppd" \
       "$(pppd --version 2>&1 |
       awk '/^pppd version/ {print $3}')" pppd
 fi
 
-echo "help me please, is this check for isdnlegitimate?"
+echo "help me please, is this check for isdn legitimate?"
 if [ $(grep -c isdn /proc/devices 2>/dev/null) -ne 0 ]; then
 pv "isdn4k-utils" \
       "$(isdnctrl 2>&1 |
@@ -144,17 +156,22 @@
       awk '/sh-utils/ {print $4}')"
 
 if [ -e /proc/modules ]; then
-      declare -i count
-      count=$(grep -c "^" /proc/modules)
-      if [ $count -gt 0 ]; then
-				modules="$(sed -e 's/ .*$//;s/\(.*\)/[\1]/' /proc/modules)"
-            pv "loaded modules" "$modules"
-      fi
+      while read a rest; do
+            modules="$modules [$a]"
+      done < /proc/modules
+      pv "loaded modules" "$(echo $modules)"
 fi
 
 echo
 # kernel tuning options
-if [ -e /proc/sys/net/ipv4/tcp_ecn ]; then
-	v=$(cat /proc/sys/net/ipv4/tcp_ecn)
-	pv "TCP option: ECN" "$(truth v)"
+TCP_ECN="/proc/sys/net/ipv4/tcp_ecn"
+if [ -e ${TCP_ECN} ]; then
+	v=$(< ${TCP_ECN})
+	pv "TCP option: ECN" "$(truth $v)"
+fi
+# kernel module taint information
+LKM_TAINT="/proc/sys/kernel/tainted"
+if [ -e ${LKM_TAINT} ]; then
+	v=$(< ${LKM_TAINT})
+	pv "modules tainted:" "$(yesno $v)"
 fi

--------------090109050102030504090708--

