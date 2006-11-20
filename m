Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966610AbWKTUGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966610AbWKTUGP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 15:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966611AbWKTUGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 15:06:15 -0500
Received: from smtp.osdl.org ([65.172.181.25]:2747 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S966610AbWKTUGO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 15:06:14 -0500
Date: Mon, 20 Nov 2006 12:05:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: James Simmons <jsimmons@infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, Tero Roponen <teanropo@jyu.fi>,
       linux-kernel@vger.kernel.org
Subject: Re: [Linux-fbdev-devel] fb: modedb uses wrong default_mode
Message-Id: <20061120120521.68724342.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0611201643460.17639@pentafluge.infradead.org>
References: <Pine.LNX.4.64.0611151933070.12799@jalava.cc.jyu.fi>
	<20061115152952.0e92c50d.akpm@osdl.org>
	<20061115234456.GB3674@cosmic.amd.com>
	<Pine.LNX.4.64.0611171919090.9851@pentafluge.infradead.org>
	<20061117124013.b6e4183d.akpm@osdl.org>
	<Pine.LNX.4.64.0611201643460.17639@pentafluge.infradead.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2006 16:48:05 +0000 (GMT)
James Simmons <jsimmons@infradead.org> wrote:

> > > 	    db = modedb;
> > > 	dbsize = ARRAY_SIZE(modedb);
> > > 
> > > 	if (!default_mode)
> > > 	    default_mode = &db[DEFAULT_MODEDB_INDEX];
> > > 	if (!default_bpp)
> > > 	    default_bpp = 8;
> > > 
> > > db will always be set.
> > 
> > I think we do need dbsize, and that the code which I have now:
> 
> I really don't trust dbsize. The driver writer can pass in the wrong 
> number.

That would be a bug.

> Whereas ARRAY_SIZE will always be correct. Lets take the position 
> that we use dbsize then we need to test if dbsize is greater than the 
> really size of the modedb. The dbsize parameter was for the days before we
> had ARRAY_SIZE.
> 
> > int fb_find_mode(struct fb_var_screeninfo *var,
> > 		 struct fb_info *info, const char *mode_option,
> > 		 const struct fb_videomode *db, unsigned int dbsize,
> > 		 const struct fb_videomode *default_mode,
> > 		 unsigned int default_bpp)
> > {
> >     int i;
> > 
> >     /* Set up defaults */
> >     if (!db) {
> > 	db = modedb;
> > 	dbsize = ARRAY_SIZE(modedb);
> >     }
> 
>       if (dbsize > ARRAY_SIZE(db))
> 	dbsize = ARRAY_SIZE(db);

We can't do ARRAY_SIZE on a random pointer like this: the compiler needs to
see the full definition of the array itself, and that is back in the
caller's compilation unit.


