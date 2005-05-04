Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261324AbVEDS0B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbVEDS0B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 14:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbVEDSYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 14:24:54 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:20883 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261324AbVEDSWF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 14:22:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MQ9RbIvL52SquiX6E4iskSAKGRVIrc/Wluua0eE++j3dNxux3BOkfILWFgjb8N30W3bLRTgJwSxUYB+ktATP8+xKfvuzlJgzqBA5a7pJpdrDcFHVDCo0xtOFTF6P5rSydApDCa9trrRDFQQcM0p/cw5tN95nKpF2ghpOozAKtSY=
Message-ID: <78d18e2050504112240e43a08@mail.gmail.com>
Date: Wed, 4 May 2005 14:22:00 -0400
From: William Jordan <bjordan.ics@gmail.com>
Reply-To: William Jordan <bjordan.ics@gmail.com>
To: Andy Isaacson <adi@hexapodia.org>
Subject: Re: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
Cc: Caitlin Bestler <caitlin.bestler@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       hch@infradead.org, Timur Tabi <timur.tabi@ammasso.com>
In-Reply-To: <20050503184325.GA19351@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <469958e00504291731eb8287c@mail.gmail.com>
	 <20050503184325.GA19351@hexapodia.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/05, Andy Isaacson <adi@hexapodia.org> wrote:
> Rather than replacing the fully-registered pages with pages of zeros,
> you could simply unmap them.

I don't like this option. It is nearly free to map all of the pages to
the zero-page. You never have to allocate a page if the user never
writes to it.

Buf if you unmap the page, there could be issues. The memory region
could be on the stack, or malloc'ed. In these cases, the child should
be able to return from the function, or free the memory without
setting a timebomb.

-- 
Bill Jordan
InfiniCon Systems
