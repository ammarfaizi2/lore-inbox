Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135535AbREBOrA>; Wed, 2 May 2001 10:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135540AbREBOqu>; Wed, 2 May 2001 10:46:50 -0400
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:43959 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S135535AbREBOqm>; Wed, 2 May 2001 10:46:42 -0400
Date: Wed, 2 May 2001 14:43:23 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "J . A . Magallon" <jamagallon@able.es>,
        Wakko Warner <wakko@animx.eu.org>,
        Xavier Bestel <xavier.bestel@free.fr>,
        Goswin Brederlow <goswin.brederlow@student.uni-tuebingen.de>,
        William T Wilson <fluffy@snurgle.org>, Matt_Domsch@Dell.com,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4 and 2GB swap partition limit
Message-ID: <20010502144323.I26638@redhat.com>
In-Reply-To: <20010502120403.G26638@redhat.com> <Pine.LNX.4.21.0105021343490.1776-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.21.0105021343490.1776-100000@localhost.localdomain>; from hugh@veritas.com on Wed, May 02, 2001 at 01:49:16PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 02, 2001 at 01:49:16PM +0100, Hugh Dickins wrote:
> On Wed, 2 May 2001, Stephen C. Tweedie wrote:
> > 
> > So the aim is more complex.  Basically, once we are short on VM, we
> > want to eliminate redundant copies of swap data.  That implies two
> > possible actions, not one --- we can either remove the swap page for
> > data which is already in memory, or we can remove the in-memory copy
> > of data which is already on swap.  Which one is appropriate will
> > depend on whether the ptes in the system point to the swap entry or
> > the memory entry.  If we have ptes pointing to both, then we cannot
> > free either.
> 
> Sorry for stating the obvious, but that last sentence gives up too easily.
> If we have ptes pointing to both, then we cannot free either until we have
> replaced all the references to one by references to the other.

Sure, but it's far from obvious that we need to worry about this.  2.2
has exactly this same behaviour for shared pages, and so if people are
complaining about a 2.4 regression, this particular aspect of the
behaviour is clearly not the underlying problem.

--Stephen
