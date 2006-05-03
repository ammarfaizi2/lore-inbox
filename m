Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965094AbWECO2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965094AbWECO2F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 10:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965199AbWECO2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 10:28:05 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:17570 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965094AbWECO2E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 10:28:04 -0400
Date: Wed, 3 May 2006 15:28:02 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 11/14] Reworked patch for labels on user space messages
Message-ID: <20060503142802.GD27946@ftp.linux.org.uk>
References: <E1FaVfH-000531-LX@ZenIV.linux.org.uk> <9e4733910605030711p2acab747g8f2ea7fdbb95f3c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910605030711p2acab747g8f2ea7fdbb95f3c4@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03, 2006 at 10:11:52AM -0400, Jon Smirl wrote:
> Something seems to be wrong in selinux_get_task_sid. I am getting
> thousands of these and can't boot the kernel.

It's actually in security/selinux/hooks.c::selinux_disable() and gets
triggered if you have selinux enabled and explicitly disable afterwards.
Stephen Smalley had done a fix yesterday, basically adding
	selinux_enabled = 0;
after
        selinux_disabled = 1;
in there.  selinux_get_task_sid() happens to step on that in visible way
and nobody had caught that while this stuff was sitting in -mm ;-/

The only question I have about that patch: what would happen if we do not
have CONFIG_SECURITY_SELINUX_BOOTPARAM?  In that case selinux_enabled is
defined to 1, so...
