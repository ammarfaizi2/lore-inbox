Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262022AbUKJVQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262022AbUKJVQa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 16:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbUKJVQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 16:16:29 -0500
Received: from peabody.ximian.com ([130.57.169.10]:65504 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262022AbUKJVQ1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 16:16:27 -0500
Subject: Re: mmap vs. O_DIRECT
From: Robert Love <rml@novell.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <cmtsoo$j55$1@gatekeeper.tmr.com>
References: <cmtsoo$j55$1@gatekeeper.tmr.com>
Content-Type: text/plain
Date: Wed, 10 Nov 2004 16:13:50 -0500
Message-Id: <1100121230.4739.1.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-09 at 19:05 -0500, Bill Davidsen wrote:
> I have an application which does a lot of mmap to process its data. The 
> huge waitio time makes me think that mmap isn't doing direct i/o even 
> when things are alligned. Before I start poking the code, is there a 
> reason why direct is not default for i/o in page-size transfers on page 
> size file offsets? I don't have source code, but the parameters of the 
> mmap all seem to satisfy the allignment requirements.
> 
> I realize there may be a reason for forcing the i/o through kernel 
> buffers, or for not taking advantage of doing direct i/o whenever 
> possible, it just doesn't jump out at me.

Direct I/O (O_DIRECT) will almost assuredly increase I/O wait and
degrade I/O performance, not improve it.

I don't think direct I/O is what you want and I am sure that we don't
want aligned mmaps to not go through the page cache and be synchronous.

	Robert Love


