Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262444AbUBXUZW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 15:25:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262443AbUBXUZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 15:25:22 -0500
Received: from waste.org ([209.173.204.2]:49342 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262444AbUBXUZI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 15:25:08 -0500
Date: Tue, 24 Feb 2004 14:24:43 -0600
From: Matt Mackall <mpm@selenic.com>
To: James Morris <jmorris@redhat.com>
Cc: Christophe Saout <christophe@saout.de>,
       Jean-Luc Cooke <jlcooke@certainkey.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, James Morris <jmorris@intercode.com.au>
Subject: Re: [PATCH/proposal] dm-crypt: add digest-based iv generation mode
Message-ID: <20040224202443.GU3883@waste.org>
References: <20040224191142.GT3883@waste.org> <Xine.LNX.4.44.0402241457330.25785-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Xine.LNX.4.44.0402241457330.25785-100000@thoron.boston.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 24, 2004 at 03:01:03PM -0500, James Morris wrote:
> On Tue, 24 Feb 2004, Matt Mackall wrote:
> 
> > Something like:
> > 
> >  /* calculate the size of a tfm so that users can manage their own
> >  copies */
> > 
> >  int crypto_alg_size(const char *name);
> > 
> >  /* copy a TFM to a user-managed buffer, possibly on stack, with proper
> >  internal reference counting and any other necessary magic, size checks
> >  against boneheaded buffer sizing */
> > 
> >  crypto_copy_tfm(char *dst, const struct crypto_tfm *src, int size);
> 
> Does it need to be copied from an existing tfm?  I think it would be 
> cleaner to provide just a way to initialize a tfm.

Not sure about Christopher's case, but I think it actually might be
easier generally. First, copying rather than initializing ensures
we've already got the algorithm loaded and locked and don't have to
worry particularly whether we're in a difficult context. 

Second, if there are cases (and this may be one, I forget the details
of HMAC) where there's significant per-use setup costs, having a
copying interface saves work. If you've got a copy interface, you
don't really need the second kind of user-managed initialize interface
I proposed earlier.

> >  /* do all the necessary bookkeeping to release a user-managed TFM, use
> >  char pointer to avoid alloc/free mismatch */
> > 
> >  crypto_copy_cleanup_tfm(char *usertfm);
> > 
> 
> This is doable.

Ok, I probably spin something like this in the next couple days.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
