Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263729AbTJCMa5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 08:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263732AbTJCMa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 08:30:57 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:1530 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S263729AbTJCMaz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 08:30:55 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16253.27644.578089.345998@gargle.gargle.HOWL>
Date: Fri, 3 Oct 2003 14:30:52 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: 2.6.0-test6 module autoloading and reference counting broken?
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI,

I'm seeing incorrect reference counting behaviour and module
loading semi-failures in 2.6.0-test6.

I have a misc char driver module which announces an alias
via a MODULE_ALIAS("char-major-10-<nnn>") declaration.

The first attempt by user-space to open the device node fails
with ENODEV. However, afterwards the module _is_ loaded and its
use count is 1 even though the user-space open() failed.

Subsequent open()s succeed, but since the reference count is
one too high, I can't unload the module.

If I instead manually insmod or modprobe the module before the
first device node open(), the module's use count is correct and
I can unload it after the last open()ed file goes away.

CONFIG_KMOD is set, module-init-tools is 0.9.14.

I'll keep digging...

/Mikael
