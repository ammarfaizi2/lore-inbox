Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129636AbRBOQYQ>; Thu, 15 Feb 2001 11:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129691AbRBOQYG>; Thu, 15 Feb 2001 11:24:06 -0500
Received: from sparrow.ists.dartmouth.edu ([129.170.249.49]:31884 "EHLO
	sparrow.websense.net") by vger.kernel.org with ESMTP
	id <S129636AbRBOQX5>; Thu, 15 Feb 2001 11:23:57 -0500
Date: Thu, 15 Feb 2001 11:20:53 -0500 (EST)
From: William Stearns <wstearns@pobox.com>
Reply-To: William Stearns <wstearns@pobox.com>
To: Giacomo Catenazzi <cate@debian.org>
cc: ML-linux-kernel <linux-kernel@vger.kernel.org>,
        William Stearns <wstearns@pobox.com>
Subject: Re: [ANNONCE] Kernel Autoconfiguration utility v.0.9.1.2
In-Reply-To: <3A8BB28B.B2A51C57@debian.org>
Message-ID: <Pine.LNX.4.30.0102151115170.31520-100000@sparrow.websense.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good day, Giacomo,

On Thu, 15 Feb 2001, Giacomo Catenazzi wrote:

> How to use: (now, testing phase)
>   unpack the files (better: in a new directory)
>   > bash autoconfigure.sh | less
>   check the output.
>   no super user privileges required!

	Nice work - that's a neat way to do it.
	One detail; you appear to assume that bash2 is being used.  If
bash1 is /bin/bash, one gets syntax errors.  The following patch allows
the script to run under bash1 and bash2, with no noticeable problems.

--- autoconfigure.sh-0.9.1.2.orig	Wed Feb 14 15:37:30 2001
+++ autoconfigure.sh	Thu Feb 15 10:59:45 2001
@@ -109,7 +109,7 @@
 }
 function found () {
     local conf=CONFIG_$1
-    if [ "${!conf}" !=  "y" ]; then
+    if [ "${conf}" !=  "y" ]; then
 	define $1 y
     else
 	debug "$1=y"
@@ -117,7 +117,7 @@
 }
 function found_y () {
     local conf=CONFIG_$1
-    if [ "${!conf}" != "y" ]; then
+    if [ "${conf}" != "y" ]; then
 	define $1 y
     else
 	debug "$1=y"
@@ -125,7 +125,7 @@
 }
 function found_m () {
     local conf=CONFIG_$1
-    if [ "${!conf}" != "y"  -a  "${!1}" != "m" ]; then
+    if [ "${conf}" != "y"  -a  "${1}" != "m" ]; then
 	define $1 m
     else
 	debug "$1=m"
@@ -133,7 +133,7 @@
 }
 function found_n () {
     local conf=CONFIG_$1
-    if [ -z "${!conf}" ]; then
+    if [ -z "${conf}" ]; then
 	define $1 n
     else
 	debug "$1=n"
@@ -142,7 +142,7 @@
 }
 function provide () {
     local prov=PROVIDE_$1
-    if [ "${!prov}" !=  "y" ]; then
+    if [ "${prov}" !=  "y" ]; then
         eval "PROVIDE_$1=y"
 	debug "PROVIDE_$1"
     fi
@@ -188,7 +188,7 @@
     set `od -An -tx1 -v $f`
     x0=$1; shift   # make variables zero-based
     echo -n "${1}${x0},${3}${2}"
-    if [ "${14}" == "00" ]; then
+    if [ "${14}" = "00" ]; then
 	echo -n ",${45}${44},${47}${46}"
     fi
     echo ",${8};Class:${11}${10},${9}"


	I'm sure I'm missing the real reasons why the "${!" and "=="
syntaxes were used (I don't know what they do, as I stick to bash1 for
portability), so my apologies in advance.
	Cheers,
	- Bill

---------------------------------------------------------------------------
	"Mouse movement detected.  Please reboot for changes to take
effect."
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, named2hosts,
and ipfwadm2ipchains are at:                http://www.pobox.com/~wstearns
LinuxMonth; articles for Linux Enthusiasts! http://www.linuxmonth.com
--------------------------------------------------------------------------

