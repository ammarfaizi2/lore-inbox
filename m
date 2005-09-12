Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932158AbVILTTW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbVILTTW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 15:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932161AbVILTTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 15:19:22 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:9196 "EHLO
	ogre.sisk.pl") by vger.kernel.org with ESMTP id S932158AbVILTTV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 15:19:21 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-mm2
Date: Mon, 12 Sep 2005 21:19:15 +0200
User-Agent: KMail/1.8.2
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Daniel Ritz <daniel.ritz@gmx.ch>
References: <20050908053042.6e05882f.akpm@osdl.org> <20050911123627.2551a057.akpm@osdl.org> <Pine.LNX.4.61.0509112055530.3611@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0509112055530.3611@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509122119.15848.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 11 of September 2005 22:03, Hugh Dickins wrote:
> On Sun, 11 Sep 2005, Andrew Morton wrote:
> > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > > 
> > >  Could you please reintroduce the yenta-free_irq-on-suspend.patch (attached)
> > >  into -mm?  My box does not resume from disk without it.
> > 
> > No probs.
> > 
> > Daniel, do you remember why we decided to drop it?  What should we do about
> > this?  Thanks.
> 
> I remember well.  My laptop does not APM resume from RAM with it.
> I've just rechecked and that's still the case.  I did try various patches
> from Rafael to help him work it out, but it remained a puzzle.

Still the observations are sort of interesting (just for the record):
1) The problem is due to interrupt sharing.  The IRQ is shared between
yenta and 3c59x.
2) Without the yenta driver the box resumes.
3) Without the 3c59x driver the box resumes.
4) If yenta is woken up _before_ 3c59x, the box resumes.
5) If yenta is woken up _after_ 3c59x, the box hangs.  Unfortunately,
this is the default, because of the PCI device numbers.

> And I admit, it is his turn to resume this month.

Thanks. ;-)

Greetings,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
