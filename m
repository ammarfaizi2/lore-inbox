Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964846AbVL1Plo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964846AbVL1Plo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 10:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964847AbVL1Plo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 10:41:44 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:19397 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S964846AbVL1Plo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 10:41:44 -0500
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: Srikanth Srinivasan <ssrikanth1@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Error patching linux-2.6.9 with kdb-v4.4-2.6.9-i386-1 
In-reply-to: Your message of "Wed, 28 Dec 2005 11:55:12 +0530."
             <ddce9dad0512272225l5fccba3boe2c0fb7d05f626c8@mail.gmail.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 29 Dec 2005 02:41:33 +1100
Message-ID: <17955.1135784493@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srikanth Srinivasan (on Wed, 28 Dec 2005 11:55:12 +0530) wrote:
>Am relatively new to the linux kernel. I have a problem patching the
>linux kernel with the kdb kernel debugger.... Here are the steps i
>followed. Am not sure if i have missed anything... Kindly help me
>out...
>
>1) Untarred the linux-2.6.9 to my home directory
>[srikanth@zeus linux]$ pwd
>/home/srikanth/work/src/linux
>
>2) Copied kdb-v4.4-2.6.9-i386-1 to /home/srikanth/work/src/linux
>
>3) [srikanth@zeus linux]$ patch -p1 < kdb-v4.4-2.6.9-i386-1
>
>4) Ran menuconfig and chose  Built-in Kernel Debugger support from
>Kernel hacking.
>I alos chose KDB modules to be built.in
>
>5) Then when i ran make bzImage i got the error as linux/kdb.h not found

You did not read the README file in ftp://oss.sgi.com/projects/kdb/download/v4.4,
so you forgot to apply the common kdb patch as well.  The KDB README says -

Starting with kdb v2.0 there is a common patch against each kernel which
contains all the architecture independent code plus separate architecture
dependent patches.  Apply the common patch for your kernel plus at least
one architecture dependent patch, the architecture patches activate kdb.

The naming convention for kdb patches is :-

 vx.y    The version of kdb.  x.y is updated as new features are added to kdb.
 -v.p.s  The kernel version that the patch applies to.  's' may include -pre,
         -rc or whatever numbering system the kernel keepers have thought up this
         week.
 -common The common kdb code.  Everybody needs this.
 -i386   Architecture dependent code for i386.
 -ia64   Architecture dependent code for ia64, etc.
 -n      If there are multiple kdb patches against the same kernel version then
         the last number is incremented.

To build kdb for your kernel, apply the common kdb patch which is less
than or equal to the kernel v.p.s, taking the highest value of '-n'
if there is more than one.  Apply the relevant arch dependent patch
with the same value of 'vx.y-v.p.s-', taking the highest value of '-n'
if there is more than one.

For example, to use kdb for i386 on kernel 2.6.6, apply
  kdb-v4.4-2.6.6-common-<n>            (use highest value of <n>)
  kdb-v4.4-2.6.6-i386-<n>              (use highest value of <n>)
in that order.  To use kdb for ia64 with patch 040521 on kernel 2.6.6, apply
  kdb-v4.4-2.6.6-common-<n>            (use highest value of <n>)
  kdb-v4.4-2.6.6-ia64-040521-<n>       (use highest value of <n>)
in that order.

Use patch -p1 for all patches.


