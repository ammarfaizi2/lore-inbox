Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265239AbTLRRCH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 12:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265244AbTLRRCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 12:02:07 -0500
Received: from ida.rowland.org ([192.131.102.52]:3844 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S265239AbTLRRCE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 12:02:04 -0500
Date: Thu, 18 Dec 2003 12:02:03 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Greg KH <greg@kroah.com>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: Driver model: releasing parents before children
Message-ID: <Pine.LNX.4.44L0.0312181153350.1011-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg:

You recently modified kobject.c to fix a bug wherein a kobject's parent
could get freed before the kobject itself, because kobject_put() on the
parent was done in the wrong place, during kobject_del() rather than
kobject_cleanup().

I just noticed two things about this.  First, you neglected to remove the 
comment from kobject.c:unlink() about decrementing the parent's refcount.

Second, the same bug appears to need fixing in the driver model core.  A 
device's parent's refcount is decremented in device_del(), not in 
device_release().  There may be other instances as well; I haven't looked.

Alan Stern


