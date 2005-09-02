Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161084AbVIBWTF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161084AbVIBWTF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 18:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161085AbVIBWTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 18:19:05 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:34805 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161084AbVIBWTB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 18:19:01 -0400
Subject: Re: [PATCH 07/11] memory hotplug: sysfs and add/remove functions
From: Dave Hansen <haveblue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050902151311.5f292ef5.akpm@osdl.org>
References: <20050902205643.9A4EC17A@kernel.beaverton.ibm.com>
	 <20050902205648.07018412@kernel.beaverton.ibm.com>
	 <20050902151311.5f292ef5.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 02 Sep 2005 15:18:28 -0700
Message-Id: <1125699509.26605.38.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-02 at 15:13 -0700, Andrew Morton wrote:
> Dave Hansen <haveblue@us.ibm.com> wrote:
> >
> > +		for (i = 0; i < PAGES_PER_SECTION; i++) {
> > +			if (PageReserved(first_page+i))
> > +				continue;
> 
> How intimate do these patches get with PageReserved()?  Bear in mind that
> we're slowly working toward making PageReserved go away.

It's basically the same way that the init code uses it.  When
initialized, a struct page has it set.  In theory, an architecture could
decide to keep the bit set when it is doing online_pages().  However, I
don't think any do that today.  Nobody would really notice if we killed
that.  That check could probably instead be something like
page_is_ram().

-- Dave

