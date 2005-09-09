Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030262AbVIILmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030262AbVIILmT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 07:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030260AbVIILmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 07:42:19 -0400
Received: from cantor2.suse.de ([195.135.220.15]:47064 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030261AbVIILmR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 07:42:17 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] [PATCH] allow CONFIG_FRAME_POINTER for x86-64
Date: Fri, 9 Sep 2005 13:42:12 +0200
User-Agent: KMail/1.8
Cc: Hugh Dickins <hugh@veritas.com>, Jan Beulich <JBeulich@novell.com>,
       linux-kernel@vger.kernel.org
References: <43207D28020000780002451E@emea1-mh.id2.novell.com> <20050909112108.GK19913@wotan.suse.de> <Pine.LNX.4.61.0509091222310.6443@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0509091222310.6443@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509091342.12517.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 September 2005 13:31, Hugh Dickins wrote:
> On Fri, 9 Sep 2005, Andi Kleen wrote:
> > On Fri, Sep 09, 2005 at 12:14:38PM +0100, Hugh Dickins wrote:
> > > Ah, right.  I'm using kdb with it.  (And my recollection of when
> > > show_stack did have a framepointer version, is that it was hopelessly
> > > broken on interrupt frames, and we're much better off without it.)
> >
> > Not sure if the x86-64 kdb had code to follow them either.
> > The i386 one has.
>
> x86_64 kdb does have the code to follow them, it's pretty much the same.

It will not work very well because the interrupt/exception etc. code makes
no attempt to preserve the frame. So it's a bad hack at best.

> > But kdb should be using a dwarf2 unwinder instead. kgdb certainly
> > supports that, as does NLKD.
>
> In an ideal and bloat-neutral world.  I've always imagined it to be
> quite a lot of work, bringing in its own set of problems: but great
> that that work has now been done, and yes, it might one day get
> ported to kdb.  But removing "&& !X86_64" is much easier.

Hmm ok. I will do that change.

-Andi
