Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263126AbUC2UEL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 15:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263130AbUC2UEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 15:04:11 -0500
Received: from mx1.redhat.com ([66.187.233.31]:14237 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263126AbUC2UEF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 15:04:05 -0500
Subject: Re: [EXT3/JBD] Periodic journal flush not enough?
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20040326235511.GW1177@schnapps.adilger.int>
References: <20040326231958.GA484@gondor.apana.org.au>
	 <20040326235511.GW1177@schnapps.adilger.int>
Content-Type: text/plain
Organization: 
Message-Id: <1080590630.2285.110.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 29 Mar 2004 21:03:51 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2004-03-26 at 23:55, Andreas Dilger wrote:

> I had created a patch a while ago, but never really got any testing on it.
> It would be great to get this problem fixed.

We don't really want to turn ENOSPC into an operation which always
requires synchronous IO, though, which your patch would do.  We can
probably detect the case where we've failed the allocate due to a
b_committed_data collision, though, and perform the retry only in that
case.

Cheers,
 Stephen


