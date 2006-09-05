Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965067AbWIERjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965067AbWIERjo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 13:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965127AbWIERjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 13:39:44 -0400
Received: from cantor2.suse.de ([195.135.220.15]:27841 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965067AbWIERjm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 13:39:42 -0400
Date: Tue, 5 Sep 2006 19:39:40 +0200
From: Olaf Kirch <okir@suse.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: NeilBrown <neilb@suse.de>, Andrew Morton <akpm@osdl.org>,
       nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [NFS] [PATCH 016 of 19] knfsd: match GRANTED_RES replies using	cookies
Message-ID: <20060905173940.GA12578@suse.de>
References: <20060901141639.27206.patches@notabene> <1060901043932.27641@suse.de> <1157126618.5632.52.camel@localhost> <20060904090939.GC28400@suse.de> <1157472751.8238.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157472751.8238.4.camel@localhost>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2006 at 12:12:30PM -0400, Trond Myklebust wrote:
> Right. The question is how many clients out there do still rely on the
> current behaviour?

Right. I know that old SunOS releases did, as did HPUX-6.5 or whatever
it was. But that was ages ago.

Suse has had this code change for a while now in SL10.1 (6 months) as
well as SLES10, and I haven't heard of any interoperability problems,
neither from partners or users, nor from our own QA.

> Looking at Brent's 'NFS Illustrated', I see that he notes that for
> NLM_GRANTED, the cookie is "An opaque value that is normally the same as
> the client sent in the LOCK request, though the client cannot depend on
> it". Which sounds like weasel words for "some clients still do depend on
> it".

The spec says the same (except it doesn't mention that the cookie is
"normally the same", it just explicitly states that the client must not
rely on the cookie in the GRANT call being the same as the one in the
LOCK call).

My guess is that this was an implementation "shortcut" in the original
Sun code that metastased into all the derived implementations, and when
they discovered it was a bad bug that could lead to lock mix-up, this
sloppiness had spread all over the Unix landscape and they needed to
put stern words into the standard...

In summary, I think more than 10 years after the publication of the
X/Open NLM spec it is acceptable to remove that kludge.

Olaf
-- 
Olaf Kirch   |  --- o --- Nous sommes du soleil we love when we play
okir@suse.de |    / | \   sol.dhoop.naytheet.ah kin.ir.samse.qurax
