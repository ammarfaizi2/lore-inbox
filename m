Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751952AbWJWNmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751952AbWJWNmM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 09:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751955AbWJWNmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 09:42:12 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:7868 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751952AbWJWNmL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 09:42:11 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [PATCH] Thaw userspace and kernel space separately.
Date: Mon, 23 Oct 2006 15:41:20 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
References: <1161560896.7438.67.camel@nigel.suspend2.net> <200610231226.03718.rjw@sisk.pl> <1161604811.3315.12.camel@nigel.suspend2.net>
In-Reply-To: <1161604811.3315.12.camel@nigel.suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610231541.21541.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 23 October 2006 14:00, Nigel Cunningham wrote:
> Hi.
> 
> On Mon, 2006-10-23 at 12:26 +0200, Rafael J. Wysocki wrote:
> > On Monday, 23 October 2006 01:48, Nigel Cunningham wrote:
> > > Modify process thawing so that we can thaw kernel space without thawing
> > > userspace, and thaw kernelspace first. This will be useful in later
> > > patches, where I intend to get swsusp thawing kernel threads only before
> > > seeking to free memory.
> > 
> > Please explain why you think it will be necessary/useful.
> > 
> > I remember a discussion about it some time ago that didn't indicate
> > we would need/want to do this.
> 
> This is needed to make suspending faster and more reliable when the
> system is in a low memory situation. Imagine that you have a number of
> processes trying to allocate memory at the time you're trying to
> suspend. They want so much memory that when you come to prepare the
> image, you find that you need to free pages. But your swapfile is on
> ext3, and you've just frozen all processes, so any attempt to free
> memory could result in a deadlock while the vm tries to swap out pages
> using the frozen kjournald.

This is not true, sorry.

Swapfiles are handled at the block device level.  The filesystem is only
needed when you run swapon, to create swap extents that are used later
to handle the swap file.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
