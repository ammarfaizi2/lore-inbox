Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbWJRKBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbWJRKBR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 06:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbWJRKBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 06:01:16 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:60764 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751461AbWJRKBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 06:01:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=Y8n6RtkOo4C6k6X6ELVe+dTg6Cmbf9Vka2MmYI3LPKIhV2gtp7NEd+zp4DtbKrjpSa1IrmbAettEYpObK9RpQQ59hevzbTwn0e7r1d7nE1BBjUKAT463iz48I7IGtjBfv/jWlLCiaMC+riIYL2ynNBcXfSU/lShZV5KtFxZqx5s=
Date: Wed, 18 Oct 2006 14:00:57 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: dealing with excessive includes
Message-ID: <20061018100057.GB5343@martell.zuzino.mipt.ru>
References: <20061017005025.GF29920@ftp.linux.org.uk> <Pine.LNX.4.64.0610161847210.3962@g5.osdl.org> <20061017043726.GG29920@ftp.linux.org.uk> <Pine.LNX.4.64.0610170821580.3962@g5.osdl.org> <20061018044054.GH29920@ftp.linux.org.uk> <20061018091944.GA5343@martell.zuzino.mipt.ru> <20061018093126.GM29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061018093126.GM29920@ftp.linux.org.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2006 at 10:31:26AM +0100, Al Viro wrote:
> On Wed, Oct 18, 2006 at 01:19:44PM +0400, Alexey Dobriyan wrote:
> > > module.h is trickier.  First of all, we want extern for wake_up_process().
> >
> > When I came up with this to l-k, Nick and Christoph told me that duplicate
> > proto sucks. So module.h/sched.h is
> > a) uninline module_put()
> > b) remove #include <linux/sched.h>
>
> 	Works for me...  OTOH, wake_up_process() is not likely to change
> prototype, so I'm not sure how strong that argument actually is.

Actually, it's pretty good argument. module_put() is not on hot paths
and duplicate prototypes tend to diverge.

> 	Anyway, that patch is obviously preliminary - at the very least
> it needs be checked on more configs (and more targets - e.g. mips and
> parisc hadn't been checked at all).

configs. Is ftp://ftp.linux.org.uk/pub/people/viro/config/ still
relevant? Or can you just post	ls $CONFIGDIR	?

