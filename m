Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750800AbVHHKOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbVHHKOr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 06:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbVHHKOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 06:14:47 -0400
Received: from [81.2.110.250] ([81.2.110.250]:3029 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S1750800AbVHHKOr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 06:14:47 -0400
Subject: Re: overcommit verses MAP_NORESERVE
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nicholas Miell <nmiell@comcast.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1123485777.17857.10.camel@localhost.localdomain>
References: <1123386755.26540.9.camel@localhost.localdomain>
	 <1123415381.9464.29.camel@localhost.localdomain>
	 <1123485777.17857.10.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 08 Aug 2005 11:41:01 +0100
Message-Id: <1123497662.28681.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-08-08 at 00:22 -0700, Nicholas Miell wrote:
> I don't think you can forcibly reclaim MAP_NORESERVE objects (I'm
> assuming you mean completely throwing away dirty pages).

In which case there is no real difference between MAP_NORESERVE and not
setting it when doing zero overcommit as we do the accounting currently.


> not other errors) and individual writes to unallocated pages in a
> MAP_NORESERVE region should either allocate a new page if possible or
> send a SIGSEGV without triggering the OOM killer.

You'd need to track vma cost seperately which we don't do now and adjust
it for such mappings in the page faulting cases. Certainly practical -
send a patch

