Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262055AbULPW0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbULPW0u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 17:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbULPW0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 17:26:30 -0500
Received: from [213.146.154.40] ([213.146.154.40]:41411 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262046AbULPWZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 17:25:19 -0500
Date: Thu, 16 Dec 2004 22:25:13 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch] [RFC] move 'struct page' into its own header
Message-ID: <20041216222513.GA15451@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <E1Cf3jM-00034h-00@kernel.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1Cf3jM-00034h-00@kernel.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2004 at 02:04:15PM -0800, Dave Hansen wrote:
> 
> There are currently 24 places in the tree where struct page is
> predeclared.  However, a good number of these places also have to
> do some kind of arithmetic on it, and end up using macros because
> static inlines wouldn't have the type fully definied at
> compile-time.
> 
> But, in reality, struct page has very few dependencies on outside
> macros or functions, and doesn't really need to be a part of the
> header include mess which surrounds many of the VM headers.
> 
> So, put 'struct page' into structpage.h, along with a nasty comment
> telling everyone to keep their grubby mitts out of the file.
> 
> Now, we can use static inlines for almost any 'struct page'
> operations with no problems, and get rid of many of the 
> predeclarations.


What about calling it page.h?  structfoo.h sounds like a really strange
name.  And while you're at it page-flags.h should probably be merged into
it.
