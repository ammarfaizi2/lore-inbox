Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265349AbUF2Bzl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265349AbUF2Bzl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 21:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265351AbUF2Bzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 21:55:41 -0400
Received: from mail.inter-page.com ([12.5.23.93]:62224 "EHLO
	mail.inter-page.com") by vger.kernel.org with ESMTP id S265349AbUF2Bz0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 21:55:26 -0400
From: "Robert White" <rwhite@casabyte.com>
To: "'David S. Miller'" <davem@redhat.com>,
       "'Oliver Neukum'" <oliver@neukum.org>
Cc: <scott@timesys.com>, <zaitcev@redhat.com>, <greg@kroah.com>,
       <arjanv@redhat.com>, <jgarzik@redhat.com>, <tburke@redhat.com>,
       <linux-kernel@vger.kernel.org>, <stern@rowland.harvard.edu>,
       <mdharm-usb@one-eyed-alien.net>, <david-b@pacbell.net>
Subject: RE: drivers/block/ub.c
Date: Mon, 28 Jun 2004 18:54:46 -0700
Organization: Casabyte, Inc.
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAdh8B1uF8jku6cyB2zk3ojwEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <20040628140343.572a0944.davem@redhat.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The below makes no sense to me...  Nothing in the definition of struct bar{} (which
is not packed) infers (top me) in the slightest that foo should be unnaturally
aligned within it.

Just because foo is internally un-aligned, it doesn't become a god-like dirty finger
to with which to corrupt external entities.  If you want bar.b packed up against
bar.a then bar should be __packed__ also.

Given the alignment rules for _empty_ structures as members of structures, why would
a non-empty structure that is packed be less stringently aligned than an empty one
that isn’t?

Perhaps I am naïve.


-----Original Message-----
From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vger.kernel.org]
On Behalf Of David S. Miller
Sent: Monday, June 28, 2004 2:04 PM
To: Oliver Neukum
Cc: scott@timesys.com; zaitcev@redhat.com; greg@kroah.com; arjanv@redhat.com;
jgarzik@redhat.com; tburke@redhat.com; linux-kernel@vger.kernel.org;
stern@rowland.harvard.edu; mdharm-usb@one-eyed-alien.net; david-b@pacbell.net
Subject: Re: drivers/block/ub.c

On Mon, 28 Jun 2004 22:57:11 +0200
Oliver Neukum <oliver@neukum.org> wrote:

> Am Montag, 28. Juni 2004 22:25 schrieb David S. Miller:
> > That's true.  But if one were to propose such a feature to the gcc
> > guys, I know the first question they would ask.  "If no padding of
> > the structure is needed, why are you specifying this new
> > __nopadding__ attribute?"
> 
> It would replace some uses of __packed__, where the first element
> is aligned.

You have not considered what is supposed to happen when this
structure is embedded within another one.  What kind of alignment
rules apply in that case?  For example:

struct foo {
	u32	x;
	u8	y;
	u16	z;
} __attribute__((__packed__));

struct bar {
	u8		a;
	struct foo 	b;
};

That is why __packed__ can't assume the alignment of any structure
instance whatsoever.  Your __nopadding__ attribute proposal would
lay out struct bar differently in order to meet the alignment guarentees
you say it will be able to meet.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



