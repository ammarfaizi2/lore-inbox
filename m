Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750968AbWAYCuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbWAYCuW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 21:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750969AbWAYCuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 21:50:22 -0500
Received: from kanga.kvack.org ([66.96.29.28]:18364 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1750963AbWAYCuW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 21:50:22 -0500
Date: Tue, 24 Jan 2006 21:46:07 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, pavel@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] swsusp: userland interface (rev 2)
Message-ID: <20060125024607.GA10409@kvack.org>
References: <200601240929.37676.rjw@sisk.pl> <20060124131312.0545262d.akpm@osdl.org> <200601250035.39383.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601250035.39383.rjw@sisk.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2006 at 12:35:38AM +0100, Rafael J. Wysocki wrote:
> > > +		if (!access_ok(VERIFY_WRITE, (unsigned long __user *)arg, _IOC_SIZE(cmd))) {
> > > +			error = -EINVAL;
> > > +			break;
> > > +		}
> > 
> > Why do we need an access_ok() here?
> 
> Because we use __put_user() down the road?
> 
> The problem is if the address is wrong we should not try to call
> alloc_swap_page() at all.  If we did, we wouldn't be able to return the result
> and we would leak a swap page.

Then access_ok() is not the droid you are looking for... since it won't 
catch several cases (out of memory being the most obvious).  Doing an 
early put_user() wouldn't hurt and reduces the chance of later failure 
even further.  __put_user() should never be used outside of a select few 
performance critical code paths.

		-ben
-- 
"Ladies and gentlemen, I'm sorry to interrupt, but the police are here 
and they've asked us to stop the party."  Don't Email: <dont@kvack.org>.
