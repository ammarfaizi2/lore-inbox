Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751780AbWEKNof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751780AbWEKNof (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 09:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751777AbWEKNof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 09:44:35 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:11174 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751773AbWEKNof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 09:44:35 -0400
Date: Thu, 11 May 2006 14:43:18 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: Ram Pai <linuxram@us.ibm.com>, agruen@suse.de, akpm@osdl.org,
       arjan@infradead.org, bunk@stusta.de, greg@kroah.com, hch@infradead.org,
       jbeulich@novell.com, linux-kernel@vger.kernel.org, mathur@us.ibm.com
Subject: Re: [PATCH 4/4] KBUILD: export-symbol usage report generator
Message-ID: <20060511134318.GA7667@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andi Kleen <ak@suse.de>, Ram Pai <linuxram@us.ibm.com>,
	agruen@suse.de, akpm@osdl.org, arjan@infradead.org, bunk@stusta.de,
	greg@kroah.com, jbeulich@novell.com, linux-kernel@vger.kernel.org,
	mathur@us.ibm.com
References: <20060510235546.8A006470034@localhost> <p73r7307pnk.fsf@bragg.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73r7307pnk.fsf@bragg.suse.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2006 at 01:43:27PM +0200, Andi Kleen wrote:
> linuxram@us.ibm.com (Ram Pai) writes:
> 
> > From: Ram Pai <linuxram@us.ibm.com>
> > 
> > The following patch provides the ability to generate a report of
> >      (1) All the exported symbols and their in-kernel-module usage count
> >      (2) For each module, lists the modules and their exported symbols, on
> >                 which it depends.
> 
> Very nice.
> 
> One thing I always wanted to see was a more focussed EXPORT_SYMBOL.
> 
> A lot of symbols are only exported for a single other module (e.g. most
> of the networking exports are for IPv6) but are actually internal 
> and shouldn't be messed with by other modules. It would be nice
> if name spaces could be defined that say "this export is only for 
> modules in this name space" and then e.g. have IPv6 be in the TCPINTERNALS
> name space and nobody else.
> 
> I think adding something like this could clean up the bewildering
> jungle of exports greatly.
> 
> _GPL is kind of like that already, but it is not fine grained enough.

I'd go even further and say every symbol should have a category.  These
catgories than could get labels such as mostly stable, public but volatile
or internal (the latter is what's oddly named _GPL) now.  That way a small
look at a driver can say if it's doing something wrong, e.g. if a network
driver imports symbols from anything but BASE, PCI and NETDEV something
is most likely wrong.
