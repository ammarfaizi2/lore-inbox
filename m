Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932483AbVHNKpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932483AbVHNKpf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 06:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932484AbVHNKpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 06:45:35 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:43215 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932483AbVHNKpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 06:45:34 -0400
Date: Sun, 14 Aug 2005 11:45:33 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: hyoshiok@miraclelinux.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] cache pollution aware __copy_from_user_ll()
Message-ID: <20050814104533.GA16936@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Arjan van de Ven <arjan@infradead.org>, hyoshiok@miraclelinux.com,
	linux-kernel@vger.kernel.org
References: <98df96d305081402164ce52f8@mail.gmail.com> <1124012489.3222.13.camel@laptopd505.fenrus.org> <98df96d305081403222e75b232@mail.gmail.com> <1124015743.3222.17.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124015743.3222.17.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the problem is that the pay elsewhere is far more spread out, but not
> less. At least generally....
> 
> I can see the point of a copy_from_user_nocache() or something, for
> those cases where we *know* we are not going to use the copied data in
> the cpu (but say, only do DMA).
> But that should be explicit, not implicit, since the general case will
> be that the kernel WILL use the data.

Most of the callers probably want the normal one, but most of the copied
data (buffered filesystem I/O) will want the non cache poluting one.

So yes, doing this explicit makes a lot of sense.

