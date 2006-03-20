Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965085AbWCTQPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965085AbWCTQPP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 11:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965087AbWCTQPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 11:15:14 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:21229 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965085AbWCTQPK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 11:15:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fR9XF4PlKXj5Z+h2fjmKj7tqxZFwaMPdQHrbGCNzYR+yUnaOOEKOiGxHeCRLfi5IzcJkkoCZIQ9GL5O6B3g3vzGwtaXgfMmP4vN8gJ6Xhvcw+UjMvIlcslCZeKINOcq1cuTeXw/dprsvEjCk67WA/lLvqrrh7ji8rRyexkyiWPE=
Message-ID: <84144f020603200815o66cb689cv239cbe190f9e6f30@mail.gmail.com>
Date: Mon, 20 Mar 2006 18:15:08 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Benjamin LaHaise" <bcrl@kvack.org>
Subject: Re: [PATCH]micro optimization of kcalloc
Cc: "Oliver Neukum" <neukum@fachschaft.cup.uni-muenchen.de>,
       linux-kernel@vger.kernel.org, "Adrian Bunk" <bunk@stusta.de>
In-Reply-To: <20060320151433.GE16108@kvack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.58.0603201542250.17461@fachschaft.cup.uni-muenchen.de>
	 <20060320151433.GE16108@kvack.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Mar 20, 2006 at 03:45:23PM +0100, Oliver Neukum wrote:
> >  static inline void *kcalloc(size_t n, size_t size, gfp_t flags)
> >  {
> > -     if (n != 0 && size > INT_MAX / n)
> > +     if (unlikely(size != 0 && n > INT_MAX / size ))
> >               return NULL;
> >       return kzalloc(n * size, flags);
> >  }

On 3/20/06, Benjamin LaHaise <bcrl@kvack.org> wrote:
> This function shouldn't be inlined.  We have no need to optimize the
> unlikely case like this.

IIRC, I made it static inline in the first place because that actually
reduced kernel text size. (And I think it was Adrian who made me do it
:-).

                                Pekka
