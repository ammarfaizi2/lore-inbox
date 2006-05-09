Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750905AbWEIW4g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbWEIW4g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 18:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbWEIW4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 18:56:36 -0400
Received: from hera.cwi.nl ([192.16.191.8]:764 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S1750905AbWEIW4f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 18:56:35 -0400
Date: Wed, 10 May 2006 00:48:49 +0200
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: "Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       Andries.Brouwer@cwi.nl
Subject: Re: [PATCH] make kernel ignore bogus partitions
Message-ID: <20060509224848.GA29754@apps.cwi.nl>
References: <20060503210055.GB31048@beardog.cca.cpqcorp.net> <20060509124138.43e4bac0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060509124138.43e4bac0.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 12:41:38PM -0700, Andrew Morton wrote:

> > +		if (from+size-1 > get_capacity(disk)) {
> > +			printk(" %s: p%d exceeds device capacity, ignoring.\n", 
> > +				disk->disk_name, p);
> > +			continue;
> > +		}
> >  		add_partition(disk, p, from, size);

> Shouldn't that be
> 
> 	if (from+size > get_capacity(disk)) {
> 
> ?

Ha, you are awake. Yes, it should.
And no "ignoring". And no "continue". E.g.:

	printk(" %s: warning: p%d exceeds device capacity.\n", ...);

Andries

