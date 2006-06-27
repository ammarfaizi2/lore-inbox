Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932294AbWF0NGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbWF0NGY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 09:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbWF0NGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 09:06:24 -0400
Received: from khc.piap.pl ([195.187.100.11]:53134 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S932294AbWF0NGX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 09:06:23 -0400
To: <linux-kernel@vger.kernel.org>
Cc: sam@ravnborg.org
Subject: KBUILD tries to make initramfs contents :-)
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Tue, 27 Jun 2006 15:06:20 +0200
Message-ID: <m3wtb27noz.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm a bit surprised :-)

I'm using a file list for initramfs generation. It's something like:

file /sbin/udev /usr/local/i386/build/udev/udev 0555 0 0
file /sbin/udevd /usr/local/i386/build/udev/udevd 0555 0 0
...

/usr/local/i386/build/udev directory contains full udev sources, not
just the executables.

Now "make linux" wants to rebuild udev executables, using kernel
build rules :-)

All details are of course available on request if needed.

This is 2.6.17, I haven't checked it but I think the change to
usr/Makefile which causes this is:

commit d39a206bc35d46a3b2eb98cd4f34e340d5e56a50
Author: Sam Ravnborg <sam@mars.ravnborg.org>
Date:   Tue Apr 11 13:24:32 2006 +0200

    kbuild: rebuild initramfs if content of initramfs changes
    
    initramfs.cpio.gz being build in usr/ and included in the
    kernel was not rebuild when the included files changed.
    
    To fix this the following was done:
    - let gen_initramfs.sh generate a list of files and directories included
      in the initramfs
    - gen_initramfs generate the gzipped cpio archive so we could simplify
      the kbuild file (Makefile)
    - utilising the kbuild infrastructure so when uid/gid root mapping changes
      the initramfs will be rebuild
    
    With this change we have a much more robust initramfs generation.


Should it stay this way or is it a bug?
-- 
Krzysztof Halasa
