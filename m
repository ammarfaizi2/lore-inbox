Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262963AbUFBOVI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262963AbUFBOVI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 10:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262972AbUFBOSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 10:18:53 -0400
Received: from may.priocom.com ([213.156.65.50]:194 "EHLO may.priocom.com")
	by vger.kernel.org with ESMTP id S262963AbUFBORl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 10:17:41 -0400
Subject: Re: [PATCH] 2.6.6 buffer.c: bio_alloc() check
From: Yury Umanets <torque@ukrpost.net>
To: Jens Axboe <axboe@suse.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20040602133606.GW28915@suse.de>
References: <1086182887.2898.89.camel@firefly.localdomain>
	 <20040602133606.GW28915@suse.de>
Content-Type: text/plain
Message-Id: <1086185843.2898.91.camel@firefly.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 02 Jun 2004 17:17:24 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-06-02 at 16:36, Jens Axboe wrote:
> On Wed, Jun 02 2004, Yury Umanets wrote:
> > [PATCH] 2.6.6 buffer.c: adds bio_alloc() check and error handling in
> > fs/buffer.c.
> > 
> > Signed-off-by: Yury Umanets <torque@ukrpost.net>
> > 
> >  buffer.c |   25 +++++++++++++++++++++++++
> >  1 files changed, 25 insertions(+)
> > 
> > diff -rupN ./linux-2.6.6/fs/buffer.c ./linux-2.6.6-modified/fs/buffer.c
> > --- ./linux-2.6.6/fs/buffer.c	Mon May 10 05:32:38 2004
> > +++ ./linux-2.6.6-modified/fs/buffer.c	Wed Jun  2 15:21:47 2004
> > @@ -2712,6 +2712,31 @@ void submit_bh(int rw, struct buffer_hea
> >  	 * submit_bio -> generic_make_request may further map this bio around
> >  	 */
> >  	bio = bio_alloc(GFP_NOIO, 1);
> > +	if (bio == NULL) {
> 
> This is wrong, bio_alloc() never fails if it's called with __GFP_WAIT in
> the gfp mask.
Ok, I see. Thanks.

-- 
umka

