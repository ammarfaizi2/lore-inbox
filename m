Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751110AbWAYKsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbWAYKsg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 05:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbWAYKsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 05:48:36 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:23499 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751110AbWAYKsg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 05:48:36 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: [PATCH -mm] swsusp: userland interface (rev 2)
Date: Wed, 25 Jan 2006 11:50:00 +0100
User-Agent: KMail/1.9
Cc: Andrew Morton <akpm@osdl.org>, pavel@suse.cz, linux-kernel@vger.kernel.org
References: <200601240929.37676.rjw@sisk.pl> <200601250035.39383.rjw@sisk.pl> <20060125024607.GA10409@kvack.org>
In-Reply-To: <20060125024607.GA10409@kvack.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601251150.01545.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 25 January 2006 03:46, Benjamin LaHaise wrote:
> On Wed, Jan 25, 2006 at 12:35:38AM +0100, Rafael J. Wysocki wrote:
> > > > +		if (!access_ok(VERIFY_WRITE, (unsigned long __user *)arg, _IOC_SIZE(cmd))) {
> > > > +			error = -EINVAL;
> > > > +			break;
> > > > +		}
> > > 
> > > Why do we need an access_ok() here?
> > 
> > Because we use __put_user() down the road?
> > 
> > The problem is if the address is wrong we should not try to call
> > alloc_swap_page() at all.  If we did, we wouldn't be able to return the result
> > and we would leak a swap page.
> 
> Then access_ok() is not the droid you are looking for... since it won't 
> catch several cases (out of memory being the most obvious).

Thanks, I haven't thought about it.

> Doing an early put_user() wouldn't hurt and reduces the chance of later failure 
> even further.  __put_user() should never be used outside of a select few 
> performance critical code paths.

Do you mean to use a fake put_user() instead of access_ok()?  And then
put_user() once again or is it reasonable to call __put_user() with the same
arg?

Rafael
