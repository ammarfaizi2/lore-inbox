Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265978AbUGEKBa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265978AbUGEKBa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 06:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265983AbUGEKB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 06:01:29 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:57523 "EHLO scrub.home")
	by vger.kernel.org with ESMTP id S265978AbUGEKB2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 06:01:28 -0400
Date: Mon, 5 Jul 2004 12:01:09 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: "David S. Miller" <davem@redhat.com>
cc: Oliver Neukum <oliver@neukum.org>, scott@timesys.com, zaitcev@redhat.com,
       greg@kroah.com, arjanv@redhat.com, jgarzik@redhat.com,
       tburke@redhat.com, linux-kernel@vger.kernel.org,
       stern@rowland.harvard.edu, mdharm-usb@one-eyed-alien.net,
       david-b@pacbell.net
Subject: Re: drivers/block/ub.c
In-Reply-To: <20040628140343.572a0944.davem@redhat.com>
Message-ID: <Pine.LNX.4.58.0407051153380.5033@scrub.home>
References: <20040626130645.55be13ce@lembas.zaitcev.lan> <20040628141517.GA4311@yoda.timesys>
 <20040628132531.036281b0.davem@redhat.com> <200406282257.11026.oliver@neukum.org>
 <20040628140343.572a0944.davem@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 28 Jun 2004, David S. Miller wrote:

> You have not considered what is supposed to happen when this
> structure is embedded within another one.  What kind of alignment
> rules apply in that case?  For example:
> 
> struct foo {
> 	u32	x;
> 	u8	y;
> 	u16	z;
> } __attribute__((__packed__));
> 
> struct bar {
> 	u8		a;
> 	struct foo 	b;
> };

Could it be possible to combine it with an aligned attribute?
For example HFS has a few structures that need the packed attribute, on 
the other hand all structures are at least on a 16 bit boundary, 
generating byte access is currently overkill there, but splitting 32bit 
accesses into two 16bit accesses would be acceptable.

bye, Roman
