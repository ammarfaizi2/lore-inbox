Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269208AbTCBQYE>; Sun, 2 Mar 2003 11:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269235AbTCBQYE>; Sun, 2 Mar 2003 11:24:04 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27146 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S269208AbTCBQYD>;
	Sun, 2 Mar 2003 11:24:03 -0500
Date: Sun, 2 Mar 2003 16:34:27 +0000
From: Matthew Wilcox <willy@debian.org>
To: Amit Shah <shahamit@gmx.net>
Cc: Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] taskqueue to workqueue update for riscom8 driver
Message-ID: <20030302163427.C7301@parcelfarce.linux.theplanet.co.uk>
References: <20030302043804.A17185@parcelfarce.linux.theplanet.co.uk> <200303021751.01224.shahamit@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200303021751.01224.shahamit@gmx.net>; from shahamit@gmx.net on Sun, Mar 02, 2003 at 05:51:01PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 02, 2003 at 05:51:01PM +0530, Amit Shah wrote:
> On Sunday 02 March 2003 10:08, Matthew Wilcox wrote:
> > No, this driver needs to be converted to the new serial core.  It's still
> > using cli(), for example.
> 
> That's a different issue, isn't it? This patch was just meant to get the 
> drivers in a compilable state... I'll look into the cli() issue, but I don't 
> have any hardware to test...

So it only compiles on UP.  Not terribly interesting.

BTW, I wouldn't necessarily expect it to work.  Work queues run in
process context; the code you replaced ran in bottom half context.
If you're going to do this kind of lame hack, it should be converted
to a tasklet, not a work queue.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
