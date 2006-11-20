Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966654AbWKTUhQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966654AbWKTUhQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 15:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966656AbWKTUhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 15:37:16 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:1187 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966654AbWKTUhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 15:37:14 -0500
Date: Mon, 20 Nov 2006 20:37:08 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Andrew Morton <akpm@osdl.org>
cc: linux-fbdev-devel@lists.sourceforge.net, Tero Roponen <teanropo@jyu.fi>,
       linux-kernel@vger.kernel.org
Subject: Re: [Linux-fbdev-devel] fb: modedb uses wrong default_mode
In-Reply-To: <20061120120521.68724342.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0611202033460.26386@pentafluge.infradead.org>
References: <Pine.LNX.4.64.0611151933070.12799@jalava.cc.jyu.fi>
 <20061115152952.0e92c50d.akpm@osdl.org> <20061115234456.GB3674@cosmic.amd.com>
 <Pine.LNX.4.64.0611171919090.9851@pentafluge.infradead.org>
 <20061117124013.b6e4183d.akpm@osdl.org> <Pine.LNX.4.64.0611201643460.17639@pentafluge.infradead.org>
 <20061120120521.68724342.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I really don't trust dbsize. The driver writer can pass in the wrong 
> > number.
> 
> That would be a bug.

Excuse my paranoia about what driver writers will do :-/

> > Whereas ARRAY_SIZE will always be correct. Lets take the position 
> > that we use dbsize then we need to test if dbsize is greater than the 
> > really size of the modedb. The dbsize parameter was for the days before we
> > had ARRAY_SIZE.
> > 
> > > int fb_find_mode(struct fb_var_screeninfo *var,
> > > 		 struct fb_info *info, const char *mode_option,
> > > 		 const struct fb_videomode *db, unsigned int dbsize,
> > > 		 const struct fb_videomode *default_mode,
> > > 		 unsigned int default_bpp)
> > > {
> > >     int i;
> > > 
> > >     /* Set up defaults */
> > >     if (!db) {
> > > 	db = modedb;
> > > 	dbsize = ARRAY_SIZE(modedb);
> > >     }
> > 
> >       if (dbsize > ARRAY_SIZE(db))
> > 	dbsize = ARRAY_SIZE(db);
> 
> We can't do ARRAY_SIZE on a random pointer like this: the compiler needs to
> see the full definition of the array itself, and that is back in the
> caller's compilation unit.

Good point about the pointer being valid. In that case we have to deal 
with dbsize. Still nervous about going out of bounds of the array.

