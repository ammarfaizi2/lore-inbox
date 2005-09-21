Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751156AbVIURVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbVIURVl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 13:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbVIURVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 13:21:41 -0400
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:35190 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751156AbVIURVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 13:21:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=UEayBSUypfJDE1OzRii4VjQpFBEah5nA0QEugWPMC5F7Iq5wqXS7QMqGV9Lm/51KordE7B+9BYxn541iJ7Thc7hQXQn1NMFYt1KTxS3te/nQpJuN4Ii71gp1HRV5O5w8cfsMwFbsPG5PKbhtbE9emukKyvcNokPqZh+QVaSA2GA=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: Remap_file_pages, RSS limits, security implications (was: Re: [uml-devel] Re: [RFC] [patch 0/18] remap_file_pages protection support (for UML), try 3)
Date: Wed, 21 Sep 2005 19:02:25 +0200
User-Agent: KMail/1.8.2
Cc: Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
References: <200508262023.29170.blaisorblade@yahoo.it> <200509211816.37512.blaisorblade@yahoo.it> <Pine.LNX.4.61.0509211729020.8121@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0509211729020.8121@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509211902.25989.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 21 September 2005 18:50, Hugh Dickins wrote:
> On Wed, 21 Sep 2005, Blaisorblade wrote:
> > Other pages in the VMA may be unmapped, yes, but not freed. In fact,
> > they're kept in by the pagecache reference; try_to_unmap() (or better its
> > caller, shrink_list) will only actually free the page it asked for.

> Not freed in that pass, yes; but brought closer to being freed soon.

Will a page with mapcount == 0 be put in the inactive list explicitly? At next 
scan PageActive will be clear, sure, and it won't be reactivated while it's 
unmapped.

But references will only cause more hardware faults.
> > The only real "problem" is that we do ptep_clear_flush_young without
> > activating the page. And yes, *this* may penalize who holds a nonlinear
> > VMA. But this is probably fair, given that we're going to have trouble in
> > freeing those pages.

> Good point, I don't remember ever considering that.
> But agree it should work out fairly.

> > > mm/trash.c?  I got quite excited,

> > What would that have meant?

> Trash is rubbish or garbage.  Or if I trash my hotel room (not me!),
> I'd rip the washbasin off the wall, smash the mirror, throw the
> chair through the window, ... hmm, better stop this public fantasy.

Nice... hope this can get to LWN "quotes of the week" page.

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
