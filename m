Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261870AbVCALJD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261870AbVCALJD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 06:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261871AbVCALIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 06:08:54 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:3968 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261870AbVCALIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 06:08:50 -0500
Subject: Breakage from patch: Only root should be able to set the N_MOUSE
	line discipline.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: torvalds@osdl.org, akpm@osdl.org, vojtech@suse.de
In-Reply-To: <200502030209.j1329xTG013818@hera.kernel.org>
References: <200502030209.j1329xTG013818@hera.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1109416402.2584.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 26 Feb 2005 11:20:44 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-01-28 at 16:12, Linux Kernel Mailing List wrote:
> ChangeSet 1.1977.1.2, 2005/01/28 17:12:20+01:00, vojtech@suse.cz
> 
> 	input: Only root should be able to set the N_MOUSE line discipline.
> 	

I finally had a chance to trace down why my mouse code for a little gui
library started working differently and causing problems. This broken
change breaks apps that use framebuffer in unpriviledged process form
and want to use the mouse support in kernel and forces them to become
setuid root or to revert to 2.4 style user space mouse drivers. If this
functonality is root only kernel space it might as well be entirely
deleted IMHO.

I can see no reason for this change - the ldisc is supposed to be
configurable by non root users. It is reset on close/hangup in Linux so
a user cannot jam a port up.

Can someone please justify this change. If not can it be reverted

Alan

