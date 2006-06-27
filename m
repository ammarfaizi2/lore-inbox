Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030271AbWF0AB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030271AbWF0AB7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 20:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030246AbWF0AB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 20:01:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:60843 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030271AbWF0AB5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 20:01:57 -0400
Date: Mon, 26 Jun 2006 20:01:44 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Edgar Hucek <hostmaster@ed-soft.at>, Antonino Daplas <adaplas@pol.net>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] imacfb: Add Intel-based Macintosh Framebuffer Support
Message-ID: <20060627000144.GC15047@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Edgar Hucek <hostmaster@ed-soft.at>,
	Antonino Daplas <adaplas@pol.net>, Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>
References: <200606261803.k5QI32W8003539@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606261803.k5QI32W8003539@hera.kernel.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2006 at 06:03:02PM +0000, Linux Kernel wrote:
 > commit 90b4f9aca4d124d114e02bbb3d1d4f3d1d47138f
 > tree e367b2fd3ad08b706bd7825c6251a95284f3bb76
 > parent 1a8c9795290361cef232fd54f425a57d143108a8
 > author Edgar Hucek <hostmaster@ed-soft.at> Mon, 26 Jun 2006 14:26:59 -0700
 > committer Linus Torvalds <torvalds@g5.osdl.org> Mon, 26 Jun 2006 23:58:32 -0700
 > 
 > [PATCH] imacfb: Add Intel-based Macintosh Framebuffer Support
 > 
 > This patch adds a new framebuffer driver for the Intel Based macs.  This
 > framebuffer is needed when booting from EFI to get something out the box.
 > 
 > [akpm: note: doesn't support modular building]

This scares me from a distro kernel point of view too, because
it does no probing that it's actually running on a mac, (be that
through DMI strings or PCI idents).  Instead if it hasn't been 
passed a boot option, it sets model to 'M_NEW'....

 > +	case M_NEW:
 > +	case M_I20:
 > +		screen_info.lfb_width = 1680;
 > +		screen_info.lfb_height = 1050;
 > +		screen_info.lfb_linelength = 1728 * 4;
 > +		screen_info.lfb_base = 0x80010000;
 > +		break;

And then assumes it can scribble at 0x80010000.

Whilst in most cases the request_region that follows is going to fail,
the possibility exists that something entirely different could be
mapped there, guaranteeing fun times should Apple ever do something
silly like, mapping the NVRAM there..

		Dave

-- 
http://www.codemonkey.org.uk
