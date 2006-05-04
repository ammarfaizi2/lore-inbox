Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbWEDMfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbWEDMfN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 08:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbWEDMfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 08:35:13 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:5548 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932282AbWEDMfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 08:35:11 -0400
Subject: Re: [RFC] kernel facilities for cache prefetching
From: Arjan van de Ven <arjan@infradead.org>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
Cc: "Ph. Marek" <philipp.marek@bmlv.gv.at>, Linus Torvalds <torvalds@osdl.org>,
       Linda Walsh <lkml@tlinx.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>
In-Reply-To: <20060504121454.GB6008@mail.ustc.edu.cn>
References: <346556235.24875@ustc.edu.cn> <44594AA9.8020906@tlinx.org>
	 <Pine.LNX.4.64.0605031829300.4086@g5.osdl.org>
	 <200605040908.10727.philipp.marek@bmlv.gv.at>
	 <1146728004.3101.17.camel@laptopd505.fenrus.org>
	 <20060504121454.GB6008@mail.ustc.edu.cn>
Content-Type: text/plain
Date: Thu, 04 May 2006 14:34:55 +0200
Message-Id: <1146746095.3101.35.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-05-04 at 20:14 +0800, Wu Fengguang wrote:
> On Thu, May 04, 2006 at 09:33:24AM +0200, Arjan van de Ven wrote:
> > 
> > 
> > > Ascending block numbers on disk can be read very fast, as the disk needs no or 
> > > less seeking. That's even true for stripes and mirrors. (I grant you that 
> > > there are complicated setups out there, but these could be handled similar.)
> > > 
> > 
> > 
> > btw this all really spells out that you may want to do this as a device
> > mapper thing; eg have a device mapper module that can do "lookaside" to
> > a different order/mirror block whatever. The filesystem just doesn't
> > want to know; do it at the DM level ;) That also solves the entire
> > caching layering problem etc ;)
> 
> I guess some big corps might want to install such a layer into their
> storage products ;)

maybe, could be.
Doing it at this level also has the advantage that fs metadata becomes
seek free as well; since that is mostly fixed-location inside the fs,
reordering that on an fs-level is really hard.. on a dm level.. easy.


