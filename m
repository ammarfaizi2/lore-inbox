Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932429AbWCUUVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbWCUUVn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 15:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbWCUUVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 15:21:43 -0500
Received: from mxout.hispeed.ch ([62.2.95.247]:17357 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S932429AbWCUUVm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 15:21:42 -0500
From: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
To: "Lanslott Gish" <lanslott.gish@gmail.com>
Subject: Re: [RFC][PATCH] USB touch screen driver, all-in-one
Date: Tue, 21 Mar 2006 21:21:50 +0100
User-Agent: KMail/1.7.2
Cc: "Greg KH" <greg@kroah.com>, "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb <linux-usb-devel@lists.sourceforge.net>, tejohnson@yahoo.com,
       hc@mivu.no, vojtech@suse.cz
References: <38c09b90603100124l1aa8cbc6qaf71718e203f3768@mail.gmail.com> <38c09b90603161846n47b5d47fnc6b4d4b9ff2d078b@mail.gmail.com> <38c09b90603202239l66e1d4bds33c2023f85587299@mail.gmail.com>
In-Reply-To: <38c09b90603202239l66e1d4bds33c2023f85587299@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603212121.52699.daniel.ritz-ml@swissonline.ch>
X-DCC-spamcheck-02.tornado.cablecom.ch-Metrics: smtp-05.tornado.cablecom.ch 32701;
	Body=8 Fuz1=8 Fuz2=8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 March 2006 07.39, Lanslott Gish wrote:
> On 3/17/06, Lanslott Gish <lanslott.gish@gmail.com> wrote:
> > On 3/16/06, Daniel Ritz <daniel.ritz-ml@swissonline.ch> wrote:
> > that just can't be right. you probably mean
> > +       *y = pkt[3] | ((pkt[4] & 0x0F) << 8);
> >
> > otherwise you mask out bits 4-7. but you want to limit it to 12 bits...
> > (btw. no need for the & 0xFF mask since *pkt is char)
> >
> >
> > you are right, sorry for my fault. the truely way is
> >
> > +       *x = (pkt[1] & 0xFF) | ((pkt[2] & 0x0F) << 8);
> > +       *y = (pkt[3] & 0xFF) | ((pkt[4] & 0x0F) << 8);
> >
> > still need 12 bits( 0x0FFF) and the masks to avoid get negative.
> >

ok, ok, there is a bug. but the mask is still not needed. the
real bug is that pkt is of type char instead of unsigned char.
so a simple cast would be enough:
	 +       *x = (unsigned char) pkt[1] | ((pkt[2] & 0x0F) << 8);

but i changed the whole thing to unsigned char all over the place.
it's better anyway.

rgds
-daniel
