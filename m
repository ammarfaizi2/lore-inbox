Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262295AbUKKRM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262295AbUKKRM4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 12:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262296AbUKKRMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 12:12:55 -0500
Received: from peabody.ximian.com ([130.57.169.10]:29670 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262295AbUKKRMv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 12:12:51 -0500
Subject: Re: mmap vs. O_DIRECT
From: Robert Love <rml@novell.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1100187716.5358.5.camel@localhost>
References: <cmtsoo$j55$1@gatekeeper.tmr.com>
	 <1100121230.4739.1.camel@betsy.boston.ximian.com>  <41937C1A.30800@tmr.com>
	 <1100187716.5358.5.camel@localhost>
Content-Type: text/plain
Date: Thu, 11 Nov 2004 12:13:39 -0500
Message-Id: <1100193219.5358.25.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-11 at 10:41 -0500, Robert Love wrote:

> There is a difference between being synchronous and not going through
> the page cache, although in Linux we don't really have the distinction.

Rereading this, I should clarify.  We definitely have the distinction.

In the case of direct I/O, you get synchronousness, no page caching, and
no use of buffers.  In my statement, I meant that you cannot separate
the "no page cache" from the "synchronousness" attribute.

But you can get synchronous I/O and still get the page cache, ala
O_SYNC.

The closest you can come to normal I/O without the page cache is by
doing posix_fadvise() to prune your cache pages after you touch them.
That is definitely not what you want.

	Robert Love


