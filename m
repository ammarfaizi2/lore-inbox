Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932644AbWFVVJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932644AbWFVVJp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 17:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932642AbWFVVJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 17:09:45 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:25357 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932644AbWFVVJo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 17:09:44 -0400
Date: Thu, 22 Jun 2006 17:09:43 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Jiri Slaby <jirislaby@gmail.com>
cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <pavel@suse.cz>, <linux-pm@osdl.org>
Subject: Re: [linux-pm] swsusp regression [Was: 2.6.17-mm1]
In-Reply-To: <449AFFAD.2030601@gmail.com>
Message-ID: <Pine.LNX.4.44L0.0606221706450.5772-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006, Jiri Slaby wrote:

> > ages.  The "bogus requests" are attempts by the user to suspend a USB
> > device (by writing to /sys/devices/.../power/state) without first
> > suspending all its children and interfaces.
> > 
> > (This can't happen when doing a global suspend because the PM core 
> > iterates through the entire device tree.  It matters only for "runtime" or 
> > "selective" suspend.)
> 
> But everything I did is:
> echo reboot > /sys/power/disk
> echo disk > /sys/power/state
> 
> No writing anywhere else.

You misunderstood.  I meant that attempts to suspend a USB device without 
first suspending all its children and interfaces can't happen when doing a 
global suspend.  That's still true.

Your problem occurred because even though the PM core did _attempt_ to 
suspend the new children added by Greg's patch, it didn't _succeed_ 
because the patch did not provide suspend or resume methods.

Alan Stern

