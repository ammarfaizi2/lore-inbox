Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262683AbTKIRBn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 12:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262686AbTKIRBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 12:01:43 -0500
Received: from netrider.rowland.org ([192.131.102.5]:49169 "HELO
	netrider.rowland.org") by vger.kernel.org with SMTP id S262683AbTKIRBm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 12:01:42 -0500
Date: Sun, 9 Nov 2003 12:01:41 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Greg KH <greg@kroah.com>
cc: Patrick Mochel <mochel@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Bug (?) in subsystem kset refcounts
In-Reply-To: <20031109042936.GA8583@kroah.com>
Message-ID: <Pine.LNX.4.44L0.0311091151480.20291-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Nov 2003, Greg KH wrote:

> See the patch that went into Linus's tree yesterday to fix where this
> would happen.

Ah yes.  Glad to see the problem has been fixed.

> But yes, usages of these macros is touchy, and we need to get it
> correct.  Your proposed patch will never allow the reference counts to
> go back to zero.
> 
> Also, notice that when the kobject is initialized, the kset set by these
> macros is then incremented.

Right, I didn't notice that.

It's unfortunate that initialization of various parts of a kobject or
driver-model object is so order-sensitive.  Worse yet is the fact that
these dependencies are not mentioned in Documentation/kobject.txt,
Documentation/driver-model, include/linux/kobject.h, or
include/linux/device.h.  Wouldn't it be a good idea to add, for example to
Documentation/kobject.txt, a description of which members of struct
kobject must be initialized before calling kobject_init() and which must
be initialized before calling kobject_add()?  And of course to do the same
for all the other important structures as well.

Alan Stern

