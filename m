Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265833AbUFVWRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265833AbUFVWRH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 18:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266056AbUFVWO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 18:14:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:62101 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266052AbUFVWOF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 18:14:05 -0400
Subject: Re: [2.4] page->buffers vanished in journal_try_to_free_buffers()
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Steven Dake <sdake@mvista.com>, Stian Jordet <liste@jordet.nu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       sct@redhat.logos.cnet, Andrew Morton <akpm@osdl.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20040621155313.GA12559@logos.cnet>
References: <1075832813.5421.53.camel@chevrolet.hybel>
	 <Pine.LNX.4.58L.0402052139420.16422@logos.cnet>
	 <1078225389.931.3.camel@buick.jordet>
	 <1087232825.28043.4.camel@persist.az.mvista.com>
	 <20040615131650.GA13697@logos.cnet>
	 <1087322198.8117.10.camel@persist.az.mvista.com>
	 <20040617131600.GB3029@logos.cnet>
	 <1087830410.2719.53.camel@sisko.scot.redhat.com>
	 <20040621155313.GA12559@logos.cnet>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1087942408.2012.31.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 22 Jun 2004 23:13:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2004-06-21 at 16:53, Marcelo Tosatti wrote:

> > The buffer-ring debug patch that you posted looks like the obvious way
> > to dig further into this.  If that doesn't get anyway, we can also trap
> > the case where following bh->b_this_page gives us a buffer whose b_page
> > is on a different page.
> 
> Fine.  Just printing out bh->b_page at debug_page() will allow us to verify that, yes?

For most cases, yes.  There are basically three corruption cases ---
b_this_page leads us to an oops, an infinite loop, or a loop including a
bogus page.  Trapping the b_this_page ring walks to trap on any bad
b_page would help in the latter two cases, but if we're always getting
the first case, just extending the existing debug patch would be fine.

--Stephen

