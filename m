Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262955AbTGKPDO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 11:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262984AbTGKPDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 11:03:13 -0400
Received: from netrider.rowland.org ([192.131.102.5]:32775 "HELO
	netrider.rowland.org") by vger.kernel.org with SMTP id S262955AbTGKPBV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 11:01:21 -0400
Date: Fri, 11 Jul 2003 11:16:02 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Eli Carter <eli.carter@inet.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Style question: Should one check for NULL pointers?
In-Reply-To: <3F0EC9C9.4090307@inet.com>
Message-ID: <Pine.LNX.4.44L0.0307111108500.21359-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jul 2003, Eli Carter wrote:

> > Not really needed, since a segfault will produce almost as much 
> > information as a BUG_ON().  Certainly it will produce enough to let a 
> > developer know that the pointer was NULL.
> 
> Your first message said, "I see no reason for pure paranoia, 
> particularly if it's not commented as such."  A BUG_ON() call makes it 
> clear that the condition should never happen.  Dereferencing a NULL 
> leaves the question of whether NULL is an unhandled case or invalid 
> input.  BUG_ON() is an explicit paranoia check, and with a bit of 
> preprocessing magic, you could compile out all of those checks.
> 
> So it documents invalid input conditions, allows you to eliminate the 
> checks in the name of speed or your personal preference, or use them to 
> help with debugging/testing.

Okay, that makes sense.  Particularly the debugging and testing part.  And 
for an excellent example of _documented_ paranoia, see the source to 
schedule_timeout().

But if you look very far through the kernel sources you will see many 
occurrences of code similar to this:

	static void release(struct xxx *ptr)
	{
		if (!ptr)
			return;
	...

I can't see any reason for keeping something like that.

Alan Stern

