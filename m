Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263804AbUCXTrE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 14:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263161AbUCXTrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 14:47:04 -0500
Received: from vlan400-082-019.maconline.McMaster.CA ([130.113.82.19]:20145
	"EHLO tentacle.dhs.org") by vger.kernel.org with ESMTP
	id S263107AbUCXTrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 14:47:02 -0500
Subject: Re: [RFC,PATCH] dnotify: enhance or replace?
From: John McCutchan <ttb@tentacle.dhs.org>
To: rudi@lambda-computing.de, linux-kernel@vger.kernel.org,
       jamie@shareable.org, tridge@samba.org,
       viro@parcelfarce.linux.theplanet.co.uk, torvalds@osdl.org,
       alexl@redhat.com, rml@ximian.com
In-Reply-To: <4061BD2E.2060900@gamemakers.de>
References: <4061986E.6020208@gamemakers.de>
	 <1080142815.8108.90.camel@localhost.localdomain>
	 <1080146269.23224.5.camel@vertex>  <4061BD2E.2060900@gamemakers.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1080158032.30769.13.camel@vertex>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 24 Mar 2004 14:53:52 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One of the big requirements for a dnotify replacement is this

* Some way to not have an open file descriptor for each directory you
are monitoring. This causes so many problems when unmounting, and this
is really the most noticable problem for the user.

I wanted to get some possible ideas from kernel hackers about how this
could be done. Inode numbers are not unique, but is there any way to get
a unique identifier on a file without using an open file? I have come
up with a few ideas.. I don't think they are very good, but here is
goes,

- When user passes fd to kernel to watch, the kernel takes over this
  fd, making it invalid in user space ( I know this is a terrible hack)
  then when a volume is unmounted, the kernel can walk the list of 
  open fd's using for notifacation and close them, before attempting to
  unmount.

- The user passes a path to the kernel, the kernel does some work so
  that it can track anything to do with that path, and again when
  an unmount is called the kernel cleans up anything used for
  notification. 

Both of these ideas are similar, does anyone have a better idea?

John
