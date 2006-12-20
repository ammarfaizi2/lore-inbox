Return-Path: <linux-kernel-owner+w=401wt.eu-S1161123AbWLUBJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161123AbWLUBJJ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 20:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161118AbWLUBIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 20:08:41 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:55069 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161110AbWLUBIS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 20:08:18 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH -mm 0/4] PM: Change ordering of suspend and resume code
Date: Wed, 20 Dec 2006 22:37:06 +0100
User-Agent: KMail/1.9.1
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200612202237.07295.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As indicated in a recent thread on Linux-PM, it's necessary to call
pm_ops->finish() before devce_resume(), but enable_nonboot_cpus() has to be
called before pm_ops->finish()
(cf. http://lists.osdl.org/pipermail/linux-pm/2006-November/004164.html).
For consistency, it seems reasonable to call disable_nonboot_cpus() after
device_suspend().

This way the suspend code will remain symmetrical with respect to the resume
code and it may allow us to speed up things in the future by suspending and
resuming devices and/or saving the suspend image in many threads.

The following series of patches reorders the suspend and resume code so that
nonboot CPUs are disabled after devices have been suspended and enabled before
the devices are resumed.  It also causes pm_ops->finish() to be called after
enable_nonboot_cpus() wherever necessary.

Greetings,
Rafael


-- 
If you don't have the time to read,
you don't have the time or the tools to write.
		- Stephen King

