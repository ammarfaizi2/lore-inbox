Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261880AbVCALpI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbVCALpI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 06:45:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbVCALpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 06:45:08 -0500
Received: from styx.suse.cz ([82.119.242.94]:19670 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261880AbVCALpC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 06:45:02 -0500
Date: Tue, 1 Mar 2005 12:47:18 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org, akpm@osdl.org, vojtech@suse.de
Subject: Re: Breakage from patch: Only root should be able to set the N_MOUSE line discipline.
Message-ID: <20050301114718.GA5375@ucw.cz>
References: <200502030209.j1329xTG013818@hera.kernel.org> <1109416402.2584.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109416402.2584.5.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 26, 2005 at 11:20:44AM +0000, Alan Cox wrote:

> On Gwe, 2005-01-28 at 16:12, Linux Kernel Mailing List wrote:
> > ChangeSet 1.1977.1.2, 2005/01/28 17:12:20+01:00, vojtech@suse.cz
> > 
> > 	input: Only root should be able to set the N_MOUSE line discipline.
> > 	
> 
> I finally had a chance to trace down why my mouse code for a little gui
> library started working differently and causing problems. This broken
> change breaks apps that use framebuffer in unpriviledged process form
> and want to use the mouse support in kernel and forces them to become
> setuid root or to revert to 2.4 style user space mouse drivers. If this
> functonality is root only kernel space it might as well be entirely
> deleted IMHO.
> 
> I can see no reason for this change - the ldisc is supposed to be
> configurable by non root users. It is reset on close/hangup in Linux so
> a user cannot jam a port up.
> 
> Can someone please justify this change. If not can it be reverted
 
A nonprivileged user could inject mouse movement and/or keystrokes
(using the sunkbd driver) into the input subsystem, taking over the
console/X, where another user is logged in.

Simply using a slightly modified inputattach on a PTY will do the trick.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
