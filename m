Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264627AbUGSBgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264627AbUGSBgX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 21:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264635AbUGSBgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 21:36:23 -0400
Received: from CPE0000c02944d6-CM00003965a061.cpe.net.cable.rogers.com ([69.193.74.215]:53398
	"EHLO tentacle.dhs.org") by vger.kernel.org with ESMTP
	id S264627AbUGSBgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 21:36:21 -0400
Subject: Re: [PATCH] inotify 0.5
From: John McCutchan <ttb@tentacle.dhs.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       nautilus-list@gnome.org
In-Reply-To: <Pine.LNX.4.58.0407181636240.8279@bigblue.dev.mdolabs.com>
References: <1090180167.5079.21.camel@vertex>
	 <Pine.LNX.4.58.0407181636240.8279@bigblue.dev.mdolabs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1090201363.3767.5.camel@vertex>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 18 Jul 2004 21:42:43 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-07-18 at 19:37, Davide Libenzi wrote:
> On Sun, 18 Jul 2004, John McCutchan wrote:
> 
> > Inotify is a replacement for dnotify. 
> > 
> > The main difference between this and my earlier inotify design, is that
> > device numbers and inode numbers are no longer used. The interface
> > between user and kernel space uses a watcher descriptor.
> > 
> > inotify is a char device with two ioctls
> > 
> > WATCH
> > 	which takes 
> > 
> > 	struct inotify_watch_request {
> > 	        char *dirname; // directory name
> >         	unsigned long mask; // event mask
> > 	};
> > 
> > 	and returns a watcher descriptor (int)
> 
> Does such descriptor supports poll(2) (... f_op->poll())?
> 

You don't use the watcher descriptor to read the events. You use the fd
from opening up the inotify device (/dev/inotify). The inotify character
device does support the poll op.

The watcher descriptor is used for communication between the app and the
device driver. 

For example,
you perform the watch ioctl on "/tmp/" the ioctl returns '2'. Then when
reading from the char device, any event with wd == 2 is referring to the
the "/tmp/" directory.

the character device produces inotify events

struct inotify_event {
	int wd;
	int mask;
}

John
