Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932481AbWCWQnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932481AbWCWQnF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 11:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbWCWQnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 11:43:04 -0500
Received: from aun.it.uu.se ([130.238.12.36]:22003 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S932481AbWCWQnB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 11:43:01 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17442.53257.711022.424119@alkaid.it.uu.se>
Date: Thu, 23 Mar 2006 17:42:49 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: William D Waddington <william.waddington@beezmo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFCLUE2] 64 bit driver 32 bit app ioctl
In-Reply-To: <4422B95D.9070900@beezmo.com>
References: <4422B95D.9070900@beezmo.com>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William D Waddington writes:
 > Apologies for dashing this off without the proper homework.  My
 > customer is out of country doing an installation, and didn't test
 > this configuration first :(
 > 
 > Customer is running RHEL3 on a 64 bit PC.  Running the 64 bit kernel
 > and my 64 bit driver.  They are calling the driver from their 32 bit
 > app.  The driver supports a whole mess of ioctls.
 > 
 > It seems that the kernel is trapping the 32-bit ioctl call and returning
 > an error to the app w/out calling the driver.  It looks like
 > register_ioctl32_conversion() can convice the kernel that the driver can
 > handle 32-bit calls, but it has to be called for each ioctl cmd (??)

In these old pre-compat_ioctl kernels you have to register each
ioctl command individually. Yes that sucks. Live with it.

 > Putting aside (please) discussion of whether the kernel should presume
 > to hijack private ioctls, and whether I should be using the ioctl
 > interface at all (compatibility with app interface going back to 2.0
 > and SunOS) is there some way to make _one_ register call to indicate
 > that all my cmds are safe, or maybe an alternate ioctl entry point
 > that the  kernel won't trap?

Not as long as you're stuck with old 2.4 kernels. 2.6 kernels since
2.6.11-rc2 allow you to set up a single ->compat_ioctl() method,
but not even RHEL4 has that yet.
