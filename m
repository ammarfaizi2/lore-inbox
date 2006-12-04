Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759896AbWLDJYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759896AbWLDJYy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 04:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759903AbWLDJYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 04:24:54 -0500
Received: from liaag2ag.mx.compuserve.com ([149.174.40.158]:28062 "EHLO
	liaag2ag.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1759896AbWLDJYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 04:24:53 -0500
Date: Mon, 4 Dec 2006 04:20:37 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: makei: shell script for building .i files
To: Willy Tarreau <w@1wt.eu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Message-ID: <200612040423_MC3-1-D3DD-B749@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2006 22:23:06 +0100, Willy Tarreau wrote:

> BTW, has anyone a good idea on how to make gcc dump the preprocessed files
> for everything it builds ? I mean, just by changing some variables in the
> Makefile.

I came up with this.  Separate output directory option is untested.
It's not quite what you wanted but this is as close as I could get.

#!/bin/bash
#
#	scripts/makei
#
# Make .i files in Linux kernel tree.  You must first build a
# working kernel so this script knows which files to make.
#
# usage:
#	scripts/makei [subdir]
#
#	Use the optional subdir parameter to build .i files
#	for just part of the source tree.
#
# Set the shell variables MAKE and OBJDIR if necessary.
#
#   Examples
#	If:
#		Your output dir is ~/build,
#		you are building the UML arch
#		and you only want to build .i files in drivers/base/
#	Then use:
#		OBJDIR=~/build MAKE='make O=~/build ARCH=um' scripts/makei drivers/base

OBJDIR=${OBJDIR:=.}
MAKE=${MAKE:=make}

OBJDIR=${OBJDIR%/}/

find $OBJDIR$1 -type f -name \*.o |
while read fullname
do
	fullname=${fullname#$OBJDIR}
	name=${fullname%.o}
	[ -f $name.c -o -f $name.S ] && $MAKE $name.i
done
-- 
Chuck
"Even supernovas have their duller moments."
