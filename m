Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136621AbREAPBh>; Tue, 1 May 2001 11:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136622AbREAPB1>; Tue, 1 May 2001 11:01:27 -0400
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:58736 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S136621AbREAPBQ>; Tue, 1 May 2001 11:01:16 -0400
Date: Tue, 1 May 2001 14:00:03 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "J . A . Magallon" <jamagallon@able.es>,
        Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        Wakko Warner <wakko@animx.eu.org>,
        Xavier Bestel <xavier.bestel@free.fr>,
        Goswin Brederlow <goswin.brederlow@student.uni-tuebingen.de>,
        William T Wilson <fluffy@snurgle.org>, Matt_Domsch@Dell.com,
        linux-kernel@vger.kernel.org, Stephen Tweedie <sct@redhat.com>
Subject: Re: 2.4 and 2GB swap partition limit
Message-ID: <20010501140003.A28747@redhat.com>
In-Reply-To: <20010428162803.C1062@werewolf.able.es> <E14uI9f-0008Kt-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <E14uI9f-0008Kt-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Apr 30, 2001 at 07:12:12PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Apr 30, 2001 at 07:12:12PM +0100, Alan Cox wrote:
> > paging in just released 2.4.4, but in previuos kernel, a page that was
> > paged-out, reserves its place in swap even if it is paged-in again, so
> > once you have paged-out all your ram at least once, you can't get any
> > more memory, even if swap is 'empty'.
> 
> This is a bug in the 2.4 VM, nothing more or less. It and the horrible bounce
> buffer bugs are forcing large machines to remain on 2.2. So it has to get 
> fixed

Umm, 2.2 can behave in the same way.  The only difference in the 2.4
behaviour is that 2.4 can maintain the swap cache effect for dirty
pages as well as clean ones.  An application which creates a large
in-core data set and then does not modify it will show exactly the
same behaviour on 2.2.

To call it a "bug" is to imply that "fixing it" is the right thing to
do.  It might be in some cases, but discarding the swap entry has a
cost --- you fragment swap, and if the page in memory is clean, you
end up increasing the amount of swap IO.  

The right fix is to reclaim such pages only when we need to.  To
disable swap caching when we still have enough swap free would hurt
users who have the spare swap to cope with it.

--Stephen
