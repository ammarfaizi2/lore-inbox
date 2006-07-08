Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932467AbWGHApl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932467AbWGHApl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 20:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932466AbWGHApl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 20:45:41 -0400
Received: from mx2.rowland.org ([192.131.102.7]:9235 "HELO mx2.rowland.org")
	by vger.kernel.org with SMTP id S932464AbWGHApk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 20:45:40 -0400
Date: Fri, 7 Jul 2006 20:45:37 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Pavel Machek <pavel@ucw.cz>
cc: "Brown, Len" <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>,
       <johnstul@us.ibm.com>, <linux-pm@lists.osdl.org>,
       <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [linux-pm] [BUG] sleeping function called from invalid context
 during resume
In-Reply-To: <20060708003003.GE1700@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44L0.0607072043150.16856-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jul 2006, Pavel Machek wrote:

> > I didn't propose that kmalloc callers peek at system_state.
> > I proposed that system_state be set properly on resume
> > exactly like it is set on boot -- SYSTEM_RUNNING means
> > we are up with interrupts enabled.
> > 
> > Note that this issue is not specific to ACPI, any other code
> > that calls kmalloc during resume will hit __might_sleep().
> > This is taken care of by system_state in the case of boot
> > and the callers don't know anything about it -- resume
> > is the same case and should work the same way.
> 
> I'd agree with Andrew here -- lets not mess with system_state. It is
> broken by design, anyway.
> 
> Part of code would prefer SYSTEM_BOOTING during resume (because we are
> initializing the devices), but I'm pretty sure some other piece of
> code will get confused by that.

Whichever way you guys decide this should go, let me know.  I'm sitting on 
a patch for ACPI (a couple of routines that make blocking calls with 
interrupts disabled) and I'd like to know what to do with it.  Should I 
just send it to Len and linux-acpi as is?

Alan Stern

