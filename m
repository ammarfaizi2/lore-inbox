Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261673AbVAGWR6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbVAGWR6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 17:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbVAGWOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 17:14:47 -0500
Received: from [213.146.154.40] ([213.146.154.40]:28102 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261660AbVAGWLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 17:11:12 -0500
Date: Fri, 7 Jan 2005 22:10:59 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Lee Revell <rlrevell@joe-job.com>, paul@linuxaudiosystems.com,
       arjanv@redhat.com, hch@infradead.org, mingo@elte.hu, chrisw@osdl.org,
       alan@lxorguk.ukuu.org.uk, joq@io.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050107221059.GA17392@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
	paul@linuxaudiosystems.com, arjanv@redhat.com, mingo@elte.hu,
	chrisw@osdl.org, alan@lxorguk.ukuu.org.uk, joq@io.com,
	linux-kernel@vger.kernel.org
References: <200501071620.j07GKrIa018718@localhost.localdomain> <1105132348.20278.88.camel@krustophenia.net> <20050107134941.11cecbfc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050107134941.11cecbfc.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2005 at 01:49:41PM -0800, Andrew Morton wrote:
> Chris Wright <chrisw@osdl.org> wrote:
> >
> > ...
> > Last I checked they could be controlled separately in that module.  It
> > has been suggested (by me and others) that one possible solution would
> > be to expand it to be generic for all caps.
> 
> Maybe this is the way?

It's at least not as bad as the current hack (when properly done in
the capabilities modules instead of adding one ontop).

I must say I'm not exactly happy with that idea still.  It ties the
privilegues we have been separating from a special uid (0) to filesystem
permissions again.  It's not nessecarily a bad idea per, but it doesn't
really fit into the model we've been working to.  I'd expect quite a few
unpleasant devices when a user detects that the distibution had been
binding various capabilities to uids/gids behinds his back.

So to make forward progress I'd like the audio people to confirm whether
the mlock bits in 2.6.9+ do help that half of their requirement first
(and if not find a way to fix it) and then tackle the scheduling part.
For that one I really wonder whether the combination of the now actually
working nicelevels (see Mingo's post) and a simple wrapper for the really
high requirements cases doesn't work.
