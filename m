Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261450AbULXVP1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbULXVP1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 16:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbULXVP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 16:15:26 -0500
Received: from smtp.knology.net ([24.214.63.101]:13799 "HELO smtp.knology.net")
	by vger.kernel.org with SMTP id S261450AbULXVPS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 16:15:18 -0500
Subject: Re: [Ipsec] Issue on input process of Linux native IPsec
From: David Dillow <dave@thedillows.org>
To: Park Lee <parklee_sel@yahoo.com>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
In-Reply-To: <20041224192311.67180.qmail@web51506.mail.yahoo.com>
References: <20041224192311.67180.qmail@web51506.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 24 Dec 2004 16:15:14 -0500
Message-Id: <1103922914.3016.13.camel@ori.thedillows.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Trimmed cc list to non-moderated lists.]

On Fri, 2004-12-24 at 11:23 -0800, Park Lee wrote:
> > I think either you're basing your idea of the 
> > packet flow on printk()'s,or I'm just too tired and 
> > missing where xfrm_lookup() gets called on the
> > rx path... 
> 
> Yes, I'm testing with ping and basing my idea of the
> packet flow on printk().

In the work I've been doing, I've found it very helpful to open a text
editor, and make a call graph for the task I'm interested in -- in your
case, a graph of every function that gets called upon receive, starting
with your network driver's receive function.

Doing a similar one for Tx would be useful for you as well, though I'd
start with the UDP output path, as it was pretty simple.

> > (yes, sk can be NULL there, but I was wrong about 
> > it being called for Rx'd packets, I think).
> 
> Does this mean that when the reply (response) packet
> is sending out through xfrm_lookup(), the sk parameter
> of xfrm_lookup() will not be NULL? and When the
> incoming packet itself goes through xfrm_lookup(), the
> sk parameter will be NULL?

xfrm_lookup() is only called for outgoing packets, not for received
packets.  I don't think ping replies (ICMP echo replies) will ever have
a non-NULL sk, as they are not associated with a socket.
-- 
David Dillow <dave@thedillows.org>
