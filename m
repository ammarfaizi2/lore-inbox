Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751246AbVKTOlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbVKTOlr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 09:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbVKTOlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 09:41:47 -0500
Received: from host94-205.pool8022.interbusiness.it ([80.22.205.94]:24234 "EHLO
	waobagger.intranet.nucleus.it") by vger.kernel.org with ESMTP
	id S1751246AbVKTOlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 09:41:46 -0500
From: Massimiliano Hofer <max@bbs.cc.uniud.it>
Organization: Nucleus snc
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.14.2 - Hard link count is wrong
Date: Sun, 20 Nov 2005 15:41:28 +0100
User-Agent: KMail/1.9
References: <437E2494.6010005@anagramm.de> <437E8904.40001@gentoo.org>
In-Reply-To: <437E8904.40001@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511201541.28600.max@bbs.cc.uniud.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 19 November 2005 3:08 am, you wrote:

> > find: WARNING: Hard link count is wrong for .: this may be a bug in your
> > filesystem driver.  Automatically turning on find's -noleaf option.
> > Earlier results may have failed to include directories that should have
> > been searched.
> >
> > According to google, this might be a kernel bug due to some problems in
> > /proc, see:
> > https://www.redhat.com/archives/fedora-list/2005-September/msg02474.html
> > Well, how to debug that problem?
>
> That find check is somewhat incorrect (hard link count can be legally
> modified after the search was started and before it finished), but I did
> fix up the /proc problems that existed a while back.
>
> This patch will give you a more useful error from findutils.

I just had the same problem (first time ever) with 2.6.14.2.
The patched find says:

find: WARNING: Hard link count (5) is wrong for /proc/bus: this may be a bug 
in your filesystem driver.  Automatically turning on find's -noleaf option.  
Earlier results may have failed to include directories that should have been 
searched.


My /proc/bus/ contains this:

# ls -al /proc/bus/
total 0
dr-xr-xr-x    5 root root 0 Nov 18 01:45 ./
dr-xr-xr-x  199 root root 0 Nov 18 02:45 ../
dr-xr-xr-x    2 root root 0 Nov 20 15:16 input/
dr-xr-xr-x    2 root root 0 Nov 20 15:16 pccard/
dr-xr-xr-x    5 root root 0 Nov 20 10:45 pci/
drwxr-xr-x    6 root root 0 Nov 18 01:45 usb/


I checked on a few machines I have with the same kernel version, but this 
happens only on my notebook. Is there any other test I can do to help 
pinpoint the problem?

-- 
Bye,
   Massimiliano Hofer
