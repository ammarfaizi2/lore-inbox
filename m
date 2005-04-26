Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbVDZBel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbVDZBel (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 21:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbVDZBel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 21:34:41 -0400
Received: from smtp.istop.com ([66.11.167.126]:9648 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S261231AbVDZBej (ORCPT
	<rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Mon, 25 Apr 2005 21:34:39 -0400
From: Daniel Phillips <phillips@istop.com>
To: Nikita Danilov <nikita@clusterfs.com>
Subject: Re: [PATCH 1b/7] dlm: core locking
Date: Mon, 25 Apr 2005 21:34:48 -0400
User-Agent: KMail/1.7
Cc: David Teigland <teigland@redhat.com>, akpm@osdl.org,
       Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
References: <20050425165826.GB11938@redhat.com> <200504251644.21566.phillips@istop.com> <17005.28381.102652.36606@gargle.gargle.HOWL>
In-Reply-To: <17005.28381.102652.36606@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504252134.49168.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 25 April 2005 18:27, Nikita Danilov wrote:
>  > >  > +
>  > >  > +static int is_remote(struct dlm_rsb *r)
>  > >  > +{
>  > >  > + DLM_ASSERT(r->res_nodeid >= 0, dlm_print_rsb(r););
>  > >  > + return r->res_nodeid ? TRUE : FALSE;
>  > >  > +}
>  > >
>  > > This can be simply
>  > >
>  > >       return r->res_nodeid;
>  >
>  > Not quite the same.  Perhaps you meant:
>  >
>  >         return !!r->res_nodeid;
>
> Strictly speaking yes (assuming TRUE is defined as 1), but name
> is_remote() implies usages like
>
>          if (is_remote(r)) {
>                  do_something();
>          }
>
> in such contexts !! is not necessary.

Any objection to making it inline and let the compiler delete the redundant 
code?  The princple is: it's better to spell out "!!" when that's intended, 
rather than build in a nasty surprise for later.  The inline code will be 
smaller than a function call anyway.

Regards,

Daniel
