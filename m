Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937854AbWLGAqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937854AbWLGAqJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 19:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937859AbWLGAqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 19:46:08 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:58352
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S937854AbWLGAqF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 19:46:05 -0500
Date: Wed, 06 Dec 2006 16:46:16 -0800 (PST)
Message-Id: <20061206.164616.74731030.davem@davemloft.net>
To: mattjreimer@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: D-cache aliasing issue in cow_user_page
From: David Miller <davem@davemloft.net>
In-Reply-To: <f383264b0612061319k16809e35tb04d04fa16f976b1@mail.gmail.com>
References: <f383264b0612051657r2b62c7acnf10b2800934ab8b3@mail.gmail.com>
	<20061205.165948.98864221.davem@davemloft.net>
	<f383264b0612061319k16809e35tb04d04fa16f976b1@mail.gmail.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matt Reimer" <mattjreimer@gmail.com>
Date: Wed, 6 Dec 2006 13:19:41 -0800

> On 12/5/06, David Miller <davem@davemloft.net> wrote:
> > From: "Matt Reimer" <mattjreimer@gmail.com>
> > Date: Tue, 5 Dec 2006 16:57:12 -0800
> >
> > > Right, but isn't he declaring that each architecture needs to take
> > > care of this? So, say, on ARM we'd need to make kunmap() not a NOP and
> > > call flush_dcache_page() ?
> >
> > No.  He is only solving a problem that occurs on HIGHMEM
> > configurations on systems which can have D-cache aliasing
> > issues.
> 
> Are you sure? James specifically mentions "non-highmem architectures,"
> and "all architectures with coherence issues," which would seem to
> include ARM (which is my concern).
> 
> For your convenience I quote the whole commit message below.

Ok, I see.

He's providing it an alternative way to solve the coherency
issues.

You can still solve it the traditional way via cache flushing
in flush_dcache_page() and {copy,clear}_user_page().
