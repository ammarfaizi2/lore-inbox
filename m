Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265332AbTLRV36 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 16:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265333AbTLRV36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 16:29:58 -0500
Received: from mx1.redhat.com ([66.187.233.31]:49330 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265332AbTLRV3z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 16:29:55 -0500
Subject: Re: filesystem bug?
From: "Stephen C. Tweedie" <sct@redhat.com>
To: tsuchiya@labs.fujitsu.com
Cc: Bryan Whitehead <driver@jpl.nasa.gov>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <3FE0E5C6.5040008@labs.fujitsu.com>
References: <3FDD7DFD.7020306@labs.fujitsu.com>
	 <1071582242.5462.1.camel@sisko.scot.redhat.com> <3FDF7BE0.205@jpl.nasa.gov>
	 <3FDF95EB.2080903@labs.fujitsu.com>  <3FE0E5C6.5040008@labs.fujitsu.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1071782986.3666.323.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 18 Dec 2003 21:29:46 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2003-12-17 at 23:24, Tsuchiya Yoshihiro wrote:
> Tsuchiya Yoshihiro wrote:
> 
> > Especially with Ext2 reproducing is easy, it happens in a few hours 
> > with my script.
> > With Ext3, in a day if you are lucky.

I've seen plenty of problems which seem more easily reproduced with one
fs over another but which turned out to be due to either bad hardware or
a kernel bug somewhere completely different in the system.  But the
basic knowledge that it happens on multiple filesystems is really
helpful to eliminate possibilities.

> > Following is the failed combination:
> > Redhat9 with 2.4.20-8 ext2 and ext3
> > Redhat9 with 2.4.20-19.9 ext2 and ext3
> > Redhat9 with 2.4.20-24.9 ext2
> 
> I forgot to mention that I had been testing 2.4.20 from kernel.org 
> also.... And it failed now!

This looks more and more like either bad hardware, or a specific device
driver problem.  What storage is being used here?

It could possibly be a core VFS bug, but the VFS is in general pretty
reliable under load.  We've had problems under specific edge conditions
such as races between sync and unmount, but the basic VFS behaviour
under load generally gets _lots_ of testing, so I'd definitely start by
looking elsewhere.  

I'd also like to see how your 2.4.23 and 2.6.0-test11 testing is going. 
That might give some clues, too.  There's a race between clear_inode()
and read_inode() fixed in those kernels, but that doesn't look relevant
here; there may be something else changed that's significant, though.

Cheers,
 Stephen
