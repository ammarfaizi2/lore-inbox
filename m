Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264936AbUEQIpS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264936AbUEQIpS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 04:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264941AbUEQIpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 04:45:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:4021 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264936AbUEQIpO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 04:45:14 -0400
Date: Mon, 17 May 2004 01:44:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Vladimir Saveliev <vs@namesys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s &&
 s->tree' failed: The saga continues.)
Message-Id: <20040517014439.2eb6a018.akpm@osdl.org>
In-Reply-To: <1084783179.1430.37.camel@tribesman.namesys.com>
References: <200405132232.01484.elenstev@mesatop.com>
	<20040517022816.GA14939@work.bitmover.com>
	<Pine.LNX.4.58.0405161936490.25502@ppc970.osdl.org>
	<200405162136.24441.elenstev@mesatop.com>
	<Pine.LNX.4.58.0405162152290.25502@ppc970.osdl.org>
	<20040517002506.34022cb8.akpm@osdl.org>
	<20040517004626.4377a496.akpm@osdl.org>
	<1084783179.1430.37.camel@tribesman.namesys.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vladimir Saveliev <vs@namesys.com> wrote:
>
> > +	/*
>  > +	 * If there is a pagecache page at the current i_size we need to lock
>  > +	 * it while modifying i_size to synchronise against
>  > +	 * block_write_full_page()'s sampling of i_size.  Otherwise
>  > +	 * block_write_full_page may decide to memset part of this page after
>  > +	 * the application extended the file size.
>  > +	 */
> 
>  Don't down-ings i_sem in do_truncate and in generic_file_write take care
>  of this kind of race?

Nope, the only lock which block_write_full_page() can be guaranteed to hold
is the page lock.
