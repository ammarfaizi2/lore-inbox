Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751061AbVKTPOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbVKTPOL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 10:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbVKTPOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 10:14:11 -0500
Received: from host94-205.pool8022.interbusiness.it ([80.22.205.94]:61847 "EHLO
	waobagger.intranet.nucleus.it") by vger.kernel.org with ESMTP
	id S1751061AbVKTPOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 10:14:09 -0500
From: Massimiliano Hofer <max@bbs.cc.uniud.it>
Organization: Nucleus snc
To: Daniel Drake <dsd@gentoo.org>
Subject: Re: Kernel 2.6.14.2 - Hard link count is wrong
Date: Sun, 20 Nov 2005 16:14:09 +0100
User-Agent: KMail/1.9
References: <437E2494.6010005@anagramm.de> <200511201522.35660.max@bbs.cc.uniud.it> <4380914C.1010903@gentoo.org>
In-Reply-To: <4380914C.1010903@gentoo.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511201614.09858.max@bbs.cc.uniud.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 20 November 2005 4:07 pm, you wrote:

> It's not obvious why that is the case. Could you try building usb and
> pcmcia as non-autoloaded modules, and booting up without those loaded to
> see if its correct at with just pci and input? (hard link count should be 4
> at that point).
>
> You could then try loading usb/pccard while keeping an eye on the hard link
> count, see if you can get a clearer idea of where the problem is.
>
> Thanks,
> Daniel

Your suspects about pccard are right:

# find /proc/ >/dev/null
/tmp/findutils-4.2.23-5/findutils-4.2.23/find/find: WARNING: Hard link count 
(5) is wrong for /proc/bus: this may be a bug in your filesystem driver.  
Automatically turning on find's -noleaf option.  Earlier results may have 
failed to include directories that should have been searched.
# rmmod pcmcia
# find /proc/ >/dev/null
# modprobe pcmcia
# find /proc/ >/dev/null
/tmp/findutils-4.2.23-5/findutils-4.2.23/find/find: WARNING: Hard link count 
(5) is wrong for /proc/bus: this may be a bug in your filesystem driver.  
Automatically turning on find's -noleaf option.  Earlier results may have 
failed to include directories that should have been searched.

I'll write back as soon as possible with more tests.

-- 
Bye,
   Massimiliano Hofer
