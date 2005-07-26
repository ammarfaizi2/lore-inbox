Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262343AbVGZX7B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262343AbVGZX7B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 19:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262347AbVGZX5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 19:57:30 -0400
Received: from pop.gmx.de ([213.165.64.20]:51866 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262343AbVGZXzy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 19:55:54 -0400
X-Authenticated: #1725425
Date: Wed, 27 Jul 2005 01:55:19 +0200
From: Marc Ballarin <Ballarin.Marc@gmx.de>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/23] Don't export machine_restart, machine_halt, or
 machine_power_off.
Message-Id: <20050727015519.614dbf2f.Ballarin.Marc@gmx.de>
In-Reply-To: <m1wtndcvwe.fsf_-_@ebiederm.dsl.xmission.com>
References: <m1mzo9eb8q.fsf@ebiederm.dsl.xmission.com>
	<m1iryxeb4t.fsf@ebiederm.dsl.xmission.com>
	<m1ek9leb0h.fsf_-_@ebiederm.dsl.xmission.com>
	<m1ack9eaux.fsf_-_@ebiederm.dsl.xmission.com>
	<m164uxear0.fsf_-_@ebiederm.dsl.xmission.com>
	<m11x5leaml.fsf_-_@ebiederm.dsl.xmission.com>
	<m1wtndcvwe.fsf_-_@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 2.0.0rc (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jul 2005 11:36:01 -0600
ebiederm@xmission.com (Eric W. Biederman) wrote:

> 
> machine_restart, machine_halt and machine_power_off are machine
> specific hooks deep into the reboot logic, that modules
> have no business messing with. Usually code should be calling
> kernel_restart, kernel_halt, kernel_power_off, or
> emergency_restart. So don't export machine_restart,
> machine_halt, and machine_power_off so we can catch buggy users.

The first is reiser4 in fs/reiser4/vfs_ops.c, line 1338.
(Are filesystems supposed to restart the machine at all?!)

Patch not tested properly, since this seems to be in error handling code,
but compiles und runs fine.

--- linux-2.6.13-rc3-mm1/fs/reiser4/vfs_ops.c.orig	2005-07-27 01:41:41.326382750 +0200
+++ linux-2.6.13-rc3-mm1/fs/reiser4/vfs_ops.c	2005-07-27 01:42:56.783098500 +0200
@@ -1335,7 +1335,7 @@ reiser4_internal void reiser4_handle_err
 		sb->s_flags |= MS_RDONLY;
 		break;
 	case 2:
-		machine_restart(NULL);
+		kernel_restart(NULL);
 	}
 }
