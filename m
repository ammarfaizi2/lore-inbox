Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261620AbTCZKra>; Wed, 26 Mar 2003 05:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261627AbTCZKra>; Wed, 26 Mar 2003 05:47:30 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:57492 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S261620AbTCZKr2>;
	Wed, 26 Mar 2003 05:47:28 -0500
Date: Wed, 26 Mar 2003 11:58:40 +0100
From: bert hubert <ahu@ds9a.nl>
To: James Simmons <jsimmons@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: [FIX] Re: 2.5.66 new fbcon oops while loading X
Message-ID: <20030326105840.GA10201@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	James Simmons <jsimmons@infradead.org>, linux-kernel@vger.kernel.org
References: <20030325123126.GA10808@outpost.ds9a.nl> <Pine.LNX.4.44.0303251722321.3789-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303251722321.3789-100000@phoenix.infradead.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 25, 2003 at 05:23:07PM +0000, James Simmons wrote:
> > While loading X, I get this oops. The weird thing is that I don't use
> > framebuffer. I compiled with gcc 3.2.2 but the code generated looks weird.
> > Virgin gcc 3.2.2 on a pentium III.
> 
> You don't use framebuffer? Can you send me your config. 

Ok, I've found the bug, it is in fb_open() in drivers/video/fbmem.c, it
needs this addition:

        if(fbidx >= FB_MAX)
                return -ENODEV;

Without it, large minor numbers result in access beyond the end of
registered_fb.

On Debian, ls /dev/fb[67] results in:
crw--w--w-    1 root     tty       29, 192 Nov 30  2000 /dev/fb6
crw--w--w-    1 root     tty       29, 224 Nov 30  2000 /dev/fb7

On Red Hat this is: 
crw-------    1 root     root      29,   7 Apr 11  2002 /dev/fb7
crw-------    1 root     root      29,   8 Apr 11  2002 /dev/fb8

Which explains why many don't see this bug.

Regards,

bert

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
http://netherlabs.nl                         Consulting
