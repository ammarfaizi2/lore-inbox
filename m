Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267215AbTAQDti>; Thu, 16 Jan 2003 22:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267224AbTAQDti>; Thu, 16 Jan 2003 22:49:38 -0500
Received: from relais.videotron.ca ([24.201.245.36]:3880 "EHLO
	VL-MS-MR002.sc1.videotron.ca") by vger.kernel.org with ESMTP
	id <S267215AbTAQDth>; Thu, 16 Jan 2003 22:49:37 -0500
Date: Thu, 16 Jan 2003 22:54:22 -0500
From: Jeroen van Disseldorp <jdizzl@xs4all.nl>
Subject: Re: Detecting changes in a directory tree
In-reply-to: <20030117005941.GT2333@fs.tum.de>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
Message-id: <200301162254.22870.jdizzl@xs4all.nl>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.5
References: <200301161358.36497.jdizzl@xs4all.nl>
 <20030117005941.GT2333@fs.tum.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 January 2003 19:59, Adrian Bunk wrote:
> with a kernel >= 2.4.19 dnotify [1] might do what you want.

Close, but is doesn't do it quite for me. I understand the problem of 
traversing inodes back up the tree, once they have changed, to see 
whether someone wants to receive an event. However I am not convinced 
that this is necessary. The idea I had was the following:

I would like to have a passthrough kind of filesystem (lets call is myfs 
for now) that can mount other parts of the filesystem and just maps 
everything to the original tree. For instance, I would mount /var on 
/mnt/var, using myfs. Everything from /mnt/var is directly mapped to 
/var.

The clue of this is that myfs *knows* about the notification, because it 
has to send notification to userspace for *every* inode. So if anything 
is written in /mnt/var, it can notify userspace. BTW for my app it 
would be acceptable that direct changes in /var don't lead to any 
events.

I haven't thought out the interface to userspace yet, but I think that 
can be worked out. Let me know if I'm making any sense here.

Regards,
  Jeroen                           mailto:jdizzl@xs4all.nl
-- 
Be the change that you want to see in the world    -- Gandhi
