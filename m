Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262088AbUKDGfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262088AbUKDGfr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 01:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262091AbUKDGfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 01:35:47 -0500
Received: from [211.58.254.17] ([211.58.254.17]:21917 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262088AbUKDGfg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 01:35:36 -0500
Date: Thu, 4 Nov 2004 15:35:32 +0900
From: Tejun Heo <tj@home-tj.org>
To: rusty@rustcorp.com.au, mochel@osdl.org, greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.10-rc1 0/15] driver-model: per-device parameter, round 3
Message-ID: <20041104063532.GA24566@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, guys.

 This is the third round of devparam patches.  I think it's mostly
ready now.  Changes from the last round include

 1. vector is gone.  BTW, I found out that implementing simple
vector-like thing inside devparam looked quite okay.  I actually like
this way better now.  :-)

 2. KPARAM_NO_RANGE added.  Unfortunately, macros still need to use
explicit 1, 0 as KPARAM_NO_RANGE is recognized as one argument rather
than two for macros.  However, all those macros are right under the
definition of its ranged counterpart, so I don't think it will cause
any confusion.

 3. DEFINE_DEVICE_PARAMSET_NS() added.  This macros accepts one
additional argument - @Namespace.  All parameters defined inside this
macro are assumed to have dot-appened @Namespace as their prefix.
Please read Documentation/devparam.txt for more details.

 4. parameters subdirectory handling fixed and improved.  Also,
parameters subdirectory isn't created when no devparam is used.


 Regarding the last posting, Rusty, parameters subdirectory rename is
not really a user-visible breakage.  It hasn't seen the light of day,
yet.  I was talking about parameters subdirectory under the device's
sysfs node.

 I'm also posting another set of patches for device manual attach.
This was what I was aiming for from the start.  This basically dumps
device-driver association management to user-space and allows
user-space to specify the driver to attach to and what arguments to
use when attaching.  I'll write more about it when I post the patches.

 Whether manualattach is accepted or not, manualattach at least will
show that devparam implements per-device parameter which can be
specified dynamically while maintaining backward compatibility (No
user-visible breakage!).

 All patches are against a freshly updated Linus bk tree and as
before, the updated document and dptest module source codes are at

http://home-tj.org/devparam/devparam.txt
http://home-tj.org/devparam/dptest.tar.gz

 Also, all patches are available at the following URL.

http://home-tj.org/devparam/20041104/

 I believe inssues are mostly resolved and devparam is ready to be
tested now.  Please consider accepting it or tell me what you guys
dislike.  I'll fix'em ASAP.  :-)

 Thanks.

-- 
tejun

