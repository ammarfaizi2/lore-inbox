Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbWJDVYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbWJDVYc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 17:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbWJDVYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 17:24:32 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:17040 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751141AbWJDVYb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 17:24:31 -0400
Date: Wed, 4 Oct 2006 23:24:26 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Scott E. Preece" <preece@motorola.com>
Cc: shd@zakalwe.fi, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org,
       ext-Tuukka.Tikkanen@nokia.com
Subject: Re: [linux-pm] [RFC] OMAP1 PM Core, PM Core  Implementation 2/2
Message-ID: <20061004212426.GC8437@elf.ucw.cz>
References: <200610021858.k92IwXJg011184@olwen.urbana.css.mot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610021858.k92IwXJg011184@olwen.urbana.css.mot.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> | Some nitpicking about the patch follows..
> | 
> | On Sat, Sep 30, 2006 at 02:24:35AM +0400, Eugeny S. Mints wrote:
> | > +static long 
> | > +get_vtg(const char *vdomain)
> | > +{
> | > +	long ret = 0;
> | 
> | Unnecessary initialisation.
> 
> Many of us work in environments where initialization is in the coding
> standard. 

Well, l-k is not _this_ kind of environment.

> | > +static int cpu_vltg_show(void *md_opt, int *value)
> | > +{
> | > +	int rc = 0;
> | > +	if (md_opt == NULL) {
> | > +		if ((*value = get_vtg("v1")) <= 0)
> | > +			return -EIO;
> | > +	}
> | > +	else {
> | > +		struct pm_core_point *opt = (struct pm_core_point *)md_opt;
> | > +		*value = opt->cpu_vltg;
> | > +	}
> | > +
> | > +	return rc;
> | > +}
> | 
> | int rc is unnecessary because the function always returns 0. This 
> | happens in many places.
> ---
> 
> Wonder if he wrote it for a coding standard that requires single return
> (so that the "return -EIO" would have been "rc=-EIO") and converted
> it...

We sometimes do that in l-k, too. But having rc=-EIO; return rc; with
single return is little extreme. Just fix it, it is easier than
debating codingstyle.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
