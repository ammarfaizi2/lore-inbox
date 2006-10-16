Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161113AbWJPVpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161113AbWJPVpH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 17:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161118AbWJPVpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 17:45:07 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:59396 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1161113AbWJPVpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 17:45:05 -0400
Date: Mon, 16 Oct 2006 17:45:04 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Duncan Sands <duncan.sands@math.u-psud.fr>
cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Greg K-H <greg@kroah.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 3/3] Driver core: Per-subsystem multithreaded probing.
In-Reply-To: <200610162105.28035.duncan.sands@math.u-psud.fr>
Message-ID: <Pine.LNX.4.44L0.0610161740140.5813-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2006, Duncan Sands wrote:

> > That's not quite true.  You could acquire dev->parent->sem always, just to
> > be certain.  However USB shouldn't use this form of multithreaded probing
> > in any case; it should instead use multiple threads for khubd.
> 
> Is anyone working on this (multiple threads for khubd)?

Not as far as I know.  It should be trivial, though.  Just start several 
threads instead of only one during initialization, and stop them all 
during cleanup.  And have the threads use a wait queue instead of calling
wait_event_interruptible().

Alan Stern

