Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbTIPTYw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 15:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbTIPTYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 15:24:52 -0400
Received: from vena.lwn.net ([206.168.112.25]:3014 "HELO lwn.net")
	by vger.kernel.org with SMTP id S262033AbTIPTYv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 15:24:51 -0400
Message-ID: <20030916192449.8450.qmail@lwn.net>
To: linux-kernel@vger.kernel.org
Subject: Dynamic allocation of char majors in the new world order
cc: viro@parcelfarce.linux.theplanet.co.uk
From: Jonathan Corbet <corbet@lwn.net>
Date: Tue, 16 Sep 2003 13:24:49 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Once again, I'm trying to figure out how char drivers are really going to
work once the dust has settled around the dev_t changes.  The new
register_chrdev_region() and cdev_* functions are reasonably easy to get a
grasp of, for the most part.  But I'm curious about one thing: what do you
do if you want to use the new functions with dynamic major number
allocation? 

Passing zero for the major number into register_chrdev_region() does almost
what one would want - it allocates a number for the caller.  The one thing
it does *not* do, however, is communicate that number back to the caller in
any way.  If you want to know what number you got, you have to call
__register_chrdev_region(), but that's static and uses a private structure
type - clearly not meant to be used that way.

Now, it wouldn't be that hard to hack register_chrdev_region() to save out
the actual major number and return it to the caller.  But I get the sense
that things ultimately are not meant to work that way.  I'm not a
particularly sensitive guy, but even I can notice little things like
comments reading "/* temporary */".  So...is there some grand design out
there on how dynamic majors are really supposed to work in 2.6?  Is it
rational to be trying to write something about char device registration at
this point?

Thanks,

jon

Jonathan Corbet
Executive editor, LWN.net
corbet@lwn.net

