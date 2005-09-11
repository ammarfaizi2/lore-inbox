Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751032AbVIKXiB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbVIKXiB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 19:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbVIKXiB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 19:38:01 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:51390 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751032AbVIKXiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 19:38:01 -0400
Subject: Re: Elimination of klists
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>
Cc: stern@rowland.harvard.edu, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050911152517.7a57ba8d.akpm@osdl.org>
References: <Pine.LNX.4.44L0.0509111531470.25522-100000@netrider.rowland.org>
	 <1126475059.4831.44.camel@mulgrave> <20050911152517.7a57ba8d.akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 11 Sep 2005 18:37:50 -0500
Message-Id: <1126481870.4831.52.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-09-11 at 15:25 -0700, Andrew Morton wrote:
> James Bottomley <James.Bottomley@SteelEye.com> wrote:
> >
> > Actually, the concept of a klist is quite nice, and the beauty is that
> >  all the locking is internal to them, so users can't actually get it
> >  wrong (I like interfaces like this).
> 
> You're a bit screwed if you want to use them from interrupts..

Yes, but then they're for refcounted lists.  Quite a few of our
refcounted structures aren't safe for final put from interrupt either.
I take the implied point about wanting to leave the lock selection up to
the list head provider... I just can't see an elegant way of
implementing it given how tightly klist iterators have to bind to the
locking and refcounting.  We could always add another pair of
list_head_lock() list_head_unlock() functions which it's up to the
list_head provider also to supply ... I'm just surprised I didn't get
hammered for using that nasty OO concept of delegates with the get/put
functions ... I'm sure someone will notice if I do it a second time.

James


James


