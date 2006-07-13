Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932160AbWGMEAh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbWGMEAh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 00:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbWGMEAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 00:00:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16863 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932160AbWGMEAg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 00:00:36 -0400
Date: Wed, 12 Jul 2006 21:00:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hans Reiser <reiser@namesys.com>
Cc: jeffm@suse.com, reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reiserfs: fix handling of device names with /'s in them
Message-Id: <20060712210027.8d7a2ddc.akpm@osdl.org>
In-Reply-To: <44B5C353.9060007@namesys.com>
References: <44B52674.8060802@suse.com>
	<20060712175542.108e6e37.akpm@osdl.org>
	<44B5C353.9060007@namesys.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2006 20:51:47 -0700
Hans Reiser <reiser@namesys.com> wrote:

> Andrew Morton wrote:
> 
> >On Wed, 12 Jul 2006 12:42:28 -0400
> >Jeff Mahoney <jeffm@suse.com> wrote:
> >
> >  
> >
> >> On systems with block devices containing slashes (virtual dasd, cciss,
> >> etc), reiserfs will fail to initialize /proc/fs/reiserfs/<dev> due to
> >> it being interpreted as a subdirectory. The generic block device code
> >> changes the / to ! for use in the sysfs tree. This patch uses that
> >> convention.
> >>    
> >>
> >
> >Isn't it a bit dumb of us to be putting slashes in the device names anyway?
> > It would be better, if poss, to alter dasd/cciss/etc and stop all these
> >s@/@!@everywhere games.
> >
> >
> >  
> >
> Isn't better to ask why there is a problem with the /'s?  It would be
> bad for Linux as a design to prevent passing arbitrary tail ends of
> filenames off to arbitrary plugins of some kind.  In general, in
> namespace design, you want to allow delegating the job of
> resolving/interpreting the tail end of a file that the front end has
> identified as something that can interpret it.
> 
> Forgive me, I probably understand something wongly about procfs and this
> issue....
> 

It's a question of being *practical*.  Your observations are in the realm
of the theoretical.

Software sucks, and we get along better by not provoking it.  So don't put
spaces, let alone slashes into strings which we offer to userspace.
