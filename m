Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbUA0G4l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 01:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262683AbUA0G4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 01:56:41 -0500
Received: from dp.samba.org ([66.70.73.150]:28572 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262652AbUA0G4j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 01:56:39 -0500
Date: Tue, 27 Jan 2004 17:51:04 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: torvalds@osdl.org, stern@rowland.harvard.edu, greg@kroah.com,
       linux-kernel@vger.kernel.org, mochel@digitalimplant.org
Subject: Re: PATCH: (as177)  Add class_device_unregister_wait() and
 platform_device_unregister_wait() to the driver model core
Message-Id: <20040127175104.48bd8664.rusty@rustcorp.com.au>
In-Reply-To: <20040125202136.GR21151@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44L0.0401251224530.947-100000@ida.rowland.org>
	<Pine.LNX.4.58.0401251054340.18932@home.osdl.org>
	<20040125202136.GR21151@parcelfarce.linux.theplanet.co.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jan 2004 20:21:37 +0000
viro@parcelfarce.linux.theplanet.co.uk wrote:

> Basically, "protect the module" is wrong - it should be "protect specific
> object" and we need that anyway.

Agreed.  You're oversimplifying a little, though.

In this model, the object here is the function text.  So if you hand out
a pointer to the function text, you need to hold a refcount.

BUT since the module itself is the only one which can hand these out,
and it unregisters everything it has registered, and all those references
fall to zero, it's trivial to prove that there are no more references to
the module functions.

This (as Al points out by referring to lifetime) is the same problem if you
want to kfree() the thing you've registered: either deregistration is
synchronous or it supplies a callback which does the actual kfree.  And most
registration interfaces in the kernel are headed towards this model, and
it can be pressed into service for module removal as well.

Hope that clarifies,
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
