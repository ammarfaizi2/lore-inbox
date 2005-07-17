Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261312AbVGQQHb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbVGQQHb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 12:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261319AbVGQQHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 12:07:30 -0400
Received: from aglu.demon.nl ([83.160.174.170]:25019 "EHLO aglu.demon.nl")
	by vger.kernel.org with ESMTP id S261312AbVGQQH3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 12:07:29 -0400
Date: Sun, 17 Jul 2005 18:07:20 +0200
From: Thomas Hood <jdthood@aglu.demon.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: Patch to make mount follow a symlink at /etc/mtab
Message-ID: <20050717160720.GA7170@aglu.demon.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
> I attach a patch that modifies the mount program in the util-linux
> package so that if /etc/mtab is a symbolic link (to a location outside
> of /proc) then mount accesses mtab at the target of the symbolic link.

I have discovered a problem with the patch I posted here.  With the
patch applied, umount aborts if it is called without "-n" and the mtab
file is not writable.  This is different from the current behavior of
the umount program and, I have discovered, there are scripts out there
that run umount without "-n" when the root filesystem is mounted
read-only.  So I have changed the patch to make umount not abort if
mtab is not writable and "-n" is not specified.

Get the updated patch at:

   http://panopticon.csustan.edu/thood/readonly-root.html

-- 
Thomas Hood
