Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264815AbUGSIaz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264815AbUGSIaz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 04:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264826AbUGSIaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 04:30:55 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:4106 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S264815AbUGSIax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 04:30:53 -0400
Date: Mon, 19 Jul 2004 16:43:14 +0800 (WST)
From: Ian Kent <raven@themaw.net>
X-X-Sender: raven@wombat.indigo.net.au
To: John McCutchan <ttb@tentacle.dhs.org>
cc: Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       nautilus-list@gnome.org
Subject: Re: [PATCH] inotify 0.5
In-Reply-To: <1090201363.3767.5.camel@vertex>
Message-ID: <Pine.LNX.4.58.0407191642080.8909@wombat.indigo.net.au>
References: <1090180167.5079.21.camel@vertex> 
 <Pine.LNX.4.58.0407181636240.8279@bigblue.dev.mdolabs.com>
 <1090201363.3767.5.camel@vertex>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.5, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, QUOTED_EMAIL_TEXT, REFERENCES,
	REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Jul 2004, John McCutchan wrote:

> On Sun, 2004-07-18 at 19:37, Davide Libenzi wrote:
> > On Sun, 18 Jul 2004, John McCutchan wrote:
> > 
> > > Inotify is a replacement for dnotify. 
> > > 
> > > The main difference between this and my earlier inotify design, is that
> > > device numbers and inode numbers are no longer used. The interface
> > > between user and kernel space uses a watcher descriptor.
> > > 
> > > inotify is a char device with two ioctls
> > > 
> > > WATCH
> > > 	which takes 
> > > 
> > > 	struct inotify_watch_request {
> > > 	        char *dirname; // directory name
> > >         	unsigned long mask; // event mask
> > > 	};
> > > 
> > > 	and returns a watcher descriptor (int)
> > 
> > Does such descriptor supports poll(2) (... f_op->poll())?
> > 
> 
> You don't use the watcher descriptor to read the events. You use the fd
> from opening up the inotify device (/dev/inotify). The inotify character
> device does support the poll op.
> 
> The watcher descriptor is used for communication between the app and the
> device driver. 
> 
> For example,
> you perform the watch ioctl on "/tmp/" the ioctl returns '2'. Then when
> reading from the char device, any event with wd == 2 is referring to the
> the "/tmp/" directory.
>

So the number of watches is restricted to the max number of file 
handles/process?
 
Ian

