Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964803AbVHOPNg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbVHOPNg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 11:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964804AbVHOPNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 11:13:36 -0400
Received: from mail.suse.de ([195.135.220.2]:39353 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964803AbVHOPNf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 11:13:35 -0400
Date: Mon, 15 Aug 2005 17:13:34 +0200
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, linux@horizon.com,
       lkml.hyoshiok@gmail.com
Subject: Re: [RFC] [PATCH] cache pollution aware __copy_from_user_ll()
Message-ID: <20050815151334.GA20749@wotan.suse.de>
References: <20050815121555.29159.qmail@science.horizon.com.suse.lists.linux.kernel> <1124108702.3228.33.camel@laptopd505.fenrus.org.suse.lists.linux.kernel> <p73u0hr1bwc.fsf@verdi.suse.de> <1124118553.3228.44.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124118553.3228.44.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2005 at 05:09:12PM +0200, Arjan van de Ven wrote:
> On Mon, 2005-08-15 at 17:02 +0200, Andi Kleen wrote:
> > Arjan van de Ven <arjan@infradead.org> writes:
> > 
> > > On Mon, 2005-08-15 at 08:15 -0400, linux@horizon.com wrote:
> > > > Actually, is there any place *other* than write() to the page cache that
> > > > warrants a non-temporal store?  Network sockets with scatter/gather and
> > > > hardware checksum, maybe?
> > > 
> > > afaik those use zero copy already, eg straight pagecache copy.
> > 
> > Only if you use sendfile(). And the normal write path uses csum_copy_* 
> 
> but do those use s/g ? 

sendfile yes. sendmsg also when the MTU of the device is larger than a page.

> and hw csum?

sendmsg normally not.

-Andi
