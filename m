Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932450AbVLNLmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbVLNLmM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 06:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932446AbVLNLmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 06:42:11 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:53661 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932443AbVLNLmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 06:42:09 -0500
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
From: Arjan van de Ven <arjan@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Howells <dhowells@redhat.com>,
       Christopher Friesen <cfriesen@nortel.com>, torvalds@osdl.org,
       akpm@osdl.org, hch@infradead.org, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
In-Reply-To: <1134559470.25663.22.camel@localhost.localdomain>
References: <439EDC3D.5040808@nortel.com>
	 <1134479118.11732.14.camel@localhost.localdomain>
	 <dhowells1134431145@warthog.cambridge.redhat.com>
	 <3874.1134480759@warthog.cambridge.redhat.com>
	 <15167.1134488373@warthog.cambridge.redhat.com>
	 <1134490205.11732.97.camel@localhost.localdomain>
	 <1134556187.2894.7.camel@laptopd505.fenrus.org>
	 <1134558188.25663.5.camel@localhost.localdomain>
	 <1134558507.2894.22.camel@laptopd505.fenrus.org>
	 <1134559470.25663.22.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 14 Dec 2005 12:42:00 +0100
Message-Id: <1134560520.2894.27.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-14 at 11:24 +0000, Alan Cox wrote:
> On Mer, 2005-12-14 at 12:08 +0100, Arjan van de Ven wrote:
> > 1) the BKL change hasn't finished, and we're 5 years down the line. API
> > changes done gradual tend to take forever in practice, esp if there's no
> > "compile" incentive for people to fix things. 
> 
> This isn't a "fix" however, its merely a performance tweak.

it's a conceptual API split that, if nothing else, declares intent and
usage pattern more specifically. Performance is just one of the angles.
Other angles are that it's possible to treat mutex users different (like
Ingo is doing in -rt, where you can temporary boost a mutex owner if the
mutex gets contended, other uses are better hold time metrics etc etc)

>  Drivers
> using the old API are not a problem because
> 
> a) The old API is needed long term for true counting sem users

this is skipping one bridge ;)
A counting semaphore is needed long term. API is up for debate in the
sense that it's not clear that a non-compile-time thing is the right
solution.

> Thats rather different to the BKL

BKL is different in that it's more work to do a conversion (eg the BKL
semantics are rather complex compared to normal spinlock / semaphore /
mutex semantics). So yes BKL is harder, and not really possible to do in
one go. Unlike these...
For BKL there was no choice. Here there is.



