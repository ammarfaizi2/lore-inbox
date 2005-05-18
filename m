Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262290AbVERQCj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262290AbVERQCj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 12:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262307AbVERQCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 12:02:31 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:1512 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262286AbVERPxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 11:53:19 -0400
Date: Wed, 18 May 2005 16:53:15 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Carsten Otte <cotte@freenet.de>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, schwidefsky@de.ibm.com, akpm@osdl.org
Subject: Re: [RFC/PATCH 2/5] mm/fs: execute in place (V2)
Message-ID: <20050518155315.GA25771@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Carsten Otte <cotte@freenet.de>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, schwidefsky@de.ibm.com,
	akpm@osdl.org
References: <1116422644.2202.1.camel@cotte.boeblingen.de.ibm.com> <1116424413.2202.17.camel@cotte.boeblingen.de.ibm.com> <20050518142707.GA23162@infradead.org> <428B57AA.2030006@freenet.de> <20050518150053.GA24389@infradead.org> <428B5FC1.3090704@freenet.de> <20050518153650.GA25322@infradead.org> <428B6463.3000604@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <428B6463.3000604@freenet.de>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2005 at 05:50:59PM +0200, Carsten Otte wrote:
> I agree that sync/async is not too much of a difference when you do a memcpy
> behind, so you can just have wrappers.

They already are wrappers in filemap.c  In fact one of my planned projects
is to kill all that silly duplication and have aio_readv/aio_writev entry
points for filesystems and read/write for drivers and nothing else.  That
would cleanup the mess extremly.

> I am still not convinced that it
> will stay
> reasonably small with all that duplicated stuff, but since it's easy to
> do I just
> gonna give it a try to see how it'll look alike. Bet the patch size will
> double.

I think that's okay.  XIP is a total minority feature, and while we should
avoid duolication where possible not making filemap.c even more messy is
by far preferable.
