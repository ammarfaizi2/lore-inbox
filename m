Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261649AbTCZOnC>; Wed, 26 Mar 2003 09:43:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261708AbTCZOnC>; Wed, 26 Mar 2003 09:43:02 -0500
Received: from home.wiggy.net ([213.84.101.140]:9620 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id <S261649AbTCZOnB>;
	Wed, 26 Mar 2003 09:43:01 -0500
Date: Wed, 26 Mar 2003 15:54:12 +0100
From: Wichert Akkerman <wichert@wiggy.net>
To: linux-kernel@vger.kernel.org
Cc: bert hubert <ahu@ds9a.nl>, James Simmons <jsimmons@infradead.org>
Subject: Re: [FIX] Re: 2.5.66 new fbcon oops while loading X
Message-ID: <20030326145412.GI2078@wiggy.net>
Mail-Followup-To: linux-kernel@vger.kernel.org, bert hubert <ahu@ds9a.nl>,
	James Simmons <jsimmons@infradead.org>
References: <20030325123126.GA10808@outpost.ds9a.nl> <Pine.LNX.4.44.0303251722321.3789-100000@phoenix.infradead.org> <20030326105840.GA10201@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030326105840.GA10201@outpost.ds9a.nl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously bert hubert wrote:
> On Debian, ls /dev/fb[67] results in:
> crw--w--w-    1 root     tty       29, 192 Nov 30  2000 /dev/fb6
> crw--w--w-    1 root     tty       29, 224 Nov 30  2000 /dev/fb7

Documentation/devices.txt (at least in 2.5.64) states that those
devices should be fully supported:

                For backwards compatibility {2.6} the following
                progression is also handled by current kernels:
                  0 = /dev/fb0
                 32 = /dev/fb1
                    ...
                224 = /dev/fb7

So perhaps the patch should look something like:

if (fbidx >= FB_MAX) {
	/* Support older device minor numbering */
	if (fbidx%32!=0)
		return -ENODEV;
	else
		fbidx/=32;

	/* Check if it is still too large */
	if (fbidx >= FB_MAX)
		return -ENODEV;
}

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>           http://www.wiggy.net/
A random hacker
