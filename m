Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbTLWQns (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 11:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbTLWQns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 11:43:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:10700 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261563AbTLWQlU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 11:41:20 -0500
Date: Tue, 23 Dec 2003 08:39:29 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Ben Srour <srour@cs.wisc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: compiling modules after 2.4.* --> 2.6.0 upgrade
Message-Id: <20031223083929.49dc6f89.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0312230211500.28609-100000@data.upl.cs.wisc.edu>
References: <200312230757.40960.andrew@walrond.org>
	<Pine.LNX.4.44.0312230211500.28609-100000@data.upl.cs.wisc.edu>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Dec 2003 02:20:06 -0600 (CST) Ben Srour <srour@cs.wisc.edu> wrote:

| Hello,
| 
| I'm attempting to port a module I wrote for the 2.4 series to 2.6 but I
| get the following error when I try and insmod:
| 
| 	root@dimension# /usr/sbin/insmod gpstest.o
| 	insmod: error inserting 'gpstest.o': -1 Invalid module format
| 	root@dimension#

In 2.6.x, modules are named *.ko, and you 'insmod|modprobe *.ko'.

To have *.ko built correctly, read and use
./Documentation/kbuild/{modules.txt,makefiles.txt}.

Here is a working trivial makefile for out-of-tree simple modules:

# makefile for oops_test/dump*.c
# Randy Dunlap, 2003-03-12
# usage:
# cd /path/to/kernel/source && make SUBDIRS=/path/to/source/oops_test/ modules

obj-m := dump_test.o

# end;


| (/sbin/insmod returns:
| 	insmod: QM_MODULES: Function not implemented
| but isnt that a remnant of the 2.4 series module-init-tools?)

Yes.

| /usr/sbin/insmod -v
| module-init-tools version 3.0-pre1
| 
| /sbin/insmod -V
| insmod version 2.4.18
| ....
| 
| 
| I'm guessing this is happening because the module it seems to be compiling
| for is 2.4:
| 	root@dimension# strings gpstest.o
| 	kernel_version=2.4.9-31
| 	....
| 	root@dimension#
| 
| I'm using module-init-tools-3.0-pre1, gcc3.0.4, kernel2.6.0

Make sure that the module-init-tools binaries are in $PATH
for user=root (and before the older ones if both are there).

--
~Randy
MOTD:  Always include version info.
