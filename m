Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751680AbVIZQz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680AbVIZQz2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 12:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751681AbVIZQz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 12:55:28 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:35846 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751679AbVIZQz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 12:55:27 -0400
Date: Mon, 26 Sep 2005 18:51:43 +0200
From: Willy Tarreau <willy@w.ods.org>
To: linux-kernel@vger.kernel.org
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, grant_lkml@dodo.com.au
Subject: Re: Linux-2.4.31-hf6
Message-ID: <20050926165143.GA4147@alpha.home.local>
References: <20050925191308.GA737@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050925191308.GA737@alpha.home.local>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- resent because it was empty the first time. strange... -

Hi all,

this is the sixth hotfix for kernel 2.4.31. Patches for 2.4.29 and 2.4.30
are also provided. This time, there were several security issues, one
possible panic fixed on ia64, and several possible DoS in 32 bits emulation
on 64 bits machines. The complete changelog is appended to this message.

To make it simple: ia64, x86_64, sparc64 and ppc64 users should upgrade.

This patch will bring your kernel to the same fix level as 2.4.32-rc1. I was
a bit late on this one. This is because I have completely reworked the patch
build system. Now when you'll download the split patches for 2.4.31-hf6,
you'll in fact be able to rebuild 2.4.29-hf16, 2.4.30-hf9 and 2.4.31-hf6.
Split patches are only provided as the last version from which all others
can be rebuilt. This will allow me to release really faster with fewer
risks of errors, while still providing you with all the required files
to rebuild any version. Maybe I should reference the root version in the
files names for older versions ? I have no opinion on this yet, time will
tell.

A "LATEST" symlink will automatically be inserted in the kernel directories
which will be available on the web site, although hidden. This way, you can
automate scripts to always download "2.4-hf/LATEST/LATEST/*". I've also
been requested to add an RSS feed so that some of you can be informed about
new releases. One of my coworkers, Julien Perrot, wrote a script for this
which updates a file every 30 min (see link below).

Grant, I hope nothing will break in your automatic build process. If you
get into trouble, please tell me.

As usual, everything is available for download there :

    hotfixes home : http://linux.exosec.net/kernel/2.4-hf/
     last version : http://linux.exosec.net/kernel/2.4-hf/LATEST/LATEST/
         RSS feed : http://linux.exosec.net/kernel/hf.xml
    build results : http://bugsplatter.mine.nu/test/linux-2.4/ (Grant's site)

I've built 2.4.31-hf6 with all modules, but not run it.

Regards,
Willy


Changelog from 2.4.31-hf5 to 2.4.31-hf6
---------------------------------------
'+' = added ; '-' = removed

+ 2.4.31-fix-can-2005-0204-1                         (Suresh Siddha / Horms)

  [CAN-2005-0204]: AMD64, allows local users to write to privileged
  IO ports via OUTS instruction. Added definition of IO_BITMAP_BYTES.

+ 2.4.31-routing_ioctl-lost-sockfd_put-1                   (Kirill Korotaev)

  This patch adds lost sockfd_put() in 32bit compat rounting_ioctl() on
  64bit platforms. I believe this is a security issues, since user can
  fget() file as many times as he wants to. The oops can be done under
  files_lock and others, so this can be an exploitable DoS on SMP.
  Didn't checked it on practice actually.

+ 2.4.31-x86_64-lost-fput-32bit-ioctl-1                    (Kirill Korotaev)

  This patch adds lost fput in 32bit tiocgdev ioctl on x86-64. I believe
  this is a security issues, since user can fget() file as many times as
  he wants to. The oops can be done under files_lock and others, so this
  is really exploitable DoS on SMP. Didn't checked it on practice actually.

+ 2.4.31-ia64-page_no_present-fault-1                         (Kiyoshi Ueda)

  [PATCH] IA64: page_not_present fault in region 5 is normal
  Without this patch, exception handler can be unexpectedly invoked
  for page-not-present fault in region 5 and cause panic etc.

+ 2.4.31-nfs-client-long-symlinks-1                       (Assar Westerlund)

  [PATCH] nfs client: handle long symlinks properly.
  In 2.4.31, the v2/3 nfs readlink accepts too long symlinks.
  I have tested this by having a server return long symlinks.

-- END --

