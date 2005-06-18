Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261215AbVFRAIU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbVFRAIU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 20:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261224AbVFRAIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 20:08:19 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:12990 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261215AbVFRAIR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 20:08:17 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Robert Love <rml@novell.com>
Subject: Re: [patch] inotify.
Date: Sat, 18 Jun 2005 02:05:06 +0200
User-Agent: KMail/1.7.2
Cc: Andrew Morton <akpm@osdl.org>, John McCutchan <ttb@tentacle.dhs.org>,
       Christoph Hellwig <hch@lst.de>, zab@zabbo.net,
       linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
References: <1118855899.3949.21.camel@betsy> <20050617143334.41a31707.akpm@osdl.org> <1119044430.7280.22.camel@phantasy>
In-Reply-To: <1119044430.7280.22.camel@phantasy>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200506180205.08366.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Freedag 17 Juni 2005 23:40, Robert Love wrote:
> On Fri, 2005-06-17 at 14:33 -0700, Andrew Morton wrote:
> 
> > So.  It's not too late.  Please spend an hour and write up the Inofity
> > Implementation FAQ?  You probably remember and fully understand what all of
> > our objections are and I know that you have explanations and rebuttals at
> > hand.
> 
> I wrote this up the first time you asked:
> 
>         Documentation/filesystems/inotify.txt
> 
> It sounds like its never been addressed because some people don't take
> different views as an acceptable solution.

Yes, this is the file that I quoted in my mail. However, "because adding
three or four new system calls that mirrored open, close, and ioctl seemed
silly" doesn't really explain the choice.
An explanation along the lines of "neither ioctl on cdev nor a syscall
based approach is made everyone happy, so we decided to stick with the
one that is already used" might give a little more insight.

However, this still does not explain why the choice here is different
from epoll, as I clearly remember the decision to move from /dev/epoll
to the final sys_epoll* interface [1]. If it's just a matter of different
views like "ioctl is ugly" vs "syscall is silly", I would have gone for a
sys_inotify_create()/sys_inotify_ctl() based interface simply for the
reason of consistency with existing interfaces like epoll or mq_open().

Of course, at this point, compatibility with the existing user base
might already be a much stronger argument.

	Arnd <><

[1] http://lwn.net/Articles/13264/
