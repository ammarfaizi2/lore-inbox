Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030222AbVLVRRx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030222AbVLVRRx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 12:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030221AbVLVRRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 12:17:53 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:8071 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030222AbVLVRRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 12:17:52 -0500
Date: Thu, 22 Dec 2005 17:17:47 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>, mingo@elte.hu,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, arjanv@infradead.org,
       nico@cam.org, jes@trained-monkey.org, zwane@arm.linux.org.uk,
       oleg@tv-sign.ru, dhowells@redhat.com, alan@lxorguk.ukuu.org.uk,
       bcrl@kvack.org, rostedt@goodmis.org, hch@infradead.org, ak@suse.de,
       rmk+lkml@arm.linux.org.uk
Subject: Re: [patch 0/9] mutex subsystem, -V4
Message-ID: <20051222171747.GA6038@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>,
	Arjan van de Ven <arjan@infradead.org>, mingo@elte.hu,
	linux-kernel@vger.kernel.org, torvalds@osdl.org,
	arjanv@infradead.org, nico@cam.org, jes@trained-monkey.org,
	zwane@arm.linux.org.uk, oleg@tv-sign.ru, dhowells@redhat.com,
	alan@lxorguk.ukuu.org.uk, bcrl@kvack.org, rostedt@goodmis.org,
	ak@suse.de, rmk+lkml@arm.linux.org.uk
References: <20051222114147.GA18878@elte.hu> <20051222035443.19a4b24e.akpm@osdl.org> <20051222122011.GA20789@elte.hu> <20051222050701.41b308f9.akpm@osdl.org> <1135257829.2940.19.camel@laptopd505.fenrus.org> <20051222054413.c1789c43.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051222054413.c1789c43.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2005 at 05:44:13AM -0800, Andrew Morton wrote:
> > You keep saying 10 times "so please enhance semaphores to do this".
> 
> Well I think diligence requires that we be able to demonstrate why it's not
> possible.
> 
> It's plain dumb for us to justify a fancy-pants new system based on
> features which we could have added to the old one, no?

But why should we add features to the semaphores.  There's very little
users of those real semaphore semantics, and they could do with a generic,
all-C implementation because they are not important fast-pathes.  OTOH
we have lots of places needing plain mutex semantics, that are important
fastpathes.  Let's optimize for the common case instead of the corner
case.

