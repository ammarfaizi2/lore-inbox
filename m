Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751293AbWCGWtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbWCGWtb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 17:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751019AbWCGWtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 17:49:31 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:33152 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750791AbWCGWta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 17:49:30 -0500
Date: Tue, 7 Mar 2006 22:49:26 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Dean Roe <roe@sgi.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, riel@redhat.com
Subject: Re: [PATCH] Prevent NULL pointer deref in grab_swap_token
Message-ID: <20060307224926.GA13147@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dean Roe <roe@sgi.com>, akpm@osdl.org, linux-kernel@vger.kernel.org,
	riel@redhat.com
References: <20060307211344.GA2946@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060307211344.GA2946@sgi.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2006 at 03:13:44PM -0600, Dean Roe wrote:
> grab_swap_token() assumes that the current process has an mm struct,
> which is not true for kernel threads invoking get_user_pages().  Since
> this should be extremely rare, just return from grab_swap_token()
> without doing anything.

There's a few things that will break if a kernel thread calls
get_user_pages, so we should rather fix those.

