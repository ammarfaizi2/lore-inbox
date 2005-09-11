Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750934AbVIKVod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbVIKVod (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 17:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbVIKVod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 17:44:33 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:1982 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1750933AbVIKVod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 17:44:33 -0400
Subject: Re: Elimination of klists
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0509111531470.25522-100000@netrider.rowland.org>
References: <Pine.LNX.4.44L0.0509111531470.25522-100000@netrider.rowland.org>
Content-Type: text/plain
Date: Sun, 11 Sep 2005 16:44:19 -0500
Message-Id: <1126475059.4831.44.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-09-11 at 15:35 -0400, Alan Stern wrote:
> I noticed that you recently posted some updates to the klist code, 
> although I haven't looked to see how you are using the klists.

Yes, that was mainly to tie their reference counting model back to the
objects they actually embed.  It was just fixing a thinko in the
implementation rather than changing anything fundamental about them.

> What do you think about eliminating klists entirely, and instead using 
> regular lists protected by either a mutex or an rwsem?  It would remove a 
> good deal of overhead, and I think it wouldn't be hard to convert the 
> driver core.  Would this be feasible for the things you're doing?

Actually, the concept of a klist is quite nice, and the beauty is that
all the locking is internal to them, so users can't actually get it
wrong (I like interfaces like this).

Originally the driver model did precisely use an ordinary list and a
mutex.  The problem was that we entangled the mutex in the actions taken
by things like device_for_each_child() which caused deadlocks ... most
noticeably in the transport classes; klists got us out of this.

James


