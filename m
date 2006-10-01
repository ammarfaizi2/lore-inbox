Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751306AbWJARKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbWJARKk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 13:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbWJARKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 13:10:40 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:8679 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751306AbWJARKj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 13:10:39 -0400
Date: Sun, 1 Oct 2006 19:10:32 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Heikki Orsila <shd@zakalwe.fi>
Cc: "Eugeny S. Mints" <eugeny.mints@gmail.com>, linux-pm@lists.osdl.org,
       linux-kernel@vger.kernel.org, ext-Tuukka.Tikkanen@nokia.com
Subject: Re: [linux-pm] [RFC] OMAP1 PM Core, PM Core  Implementation 2/2
Message-ID: <20061001171032.GE2254@elf.ucw.cz>
References: <20060930022435.b2344b5f.eugeny.mints@gmail.com> <20061001152228.GA24539@zakalwe.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061001152228.GA24539@zakalwe.fi>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2006-10-01 18:22:28, Heikki Orsila wrote:
> Some nitpicking about the patch follows..
> 
> On Sat, Sep 30, 2006 at 02:24:35AM +0400, Eugeny S. Mints wrote:
> > +static long 
> > +get_vtg(const char *vdomain)
> > +{
> > +	long ret = 0;
> 
> Unnecessary initialisation.

No, sorry.

> > +static long 
> > +set_vtg(const char *vdomain, int val)
> > +{
> > +	long ret = 0;
> 
> here too. This and 'int i = 0;' happens in many functions.

Wrong again. automatic variables are not zero initialized.

> > +	err = omap_pm_core_verify_opt(opt);
> > +	if (err != 0)
> > +		goto out;
> > +
> > +	return (void *)opt;
> > +out:
> > +	kfree(opt);
> > +	return NULL;
> > +}
> 
> Maybe use if (err != 0) { kfree(opt); return NULL; } because goto out is 
> only used once?

This is actually common kernel idiom, so it is okay to leave like
this. Your other points are ok.

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
