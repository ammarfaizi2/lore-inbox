Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbWE2Hid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWE2Hid (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 03:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWE2Hic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 03:38:32 -0400
Received: from hera.kernel.org ([140.211.167.34]:52690 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750746AbWE2Hic (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 03:38:32 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: memcpy_toio on i386 using byte writes even when n%2==0
Date: Mon, 29 May 2006 00:38:05 -0700 (PDT)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <e5e8ct$bl6$1@terminus.zytor.com>
References: <6gMqr-8uW-23@gated-at.bofh.it> <44779358.9010703@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1148888285 11943 127.0.0.1 (29 May 2006 07:38:05 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Mon, 29 May 2006 07:38:05 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <44779358.9010703@shaw.ca>
By author:    Robert Hancock <hancockr@shaw.ca>
In newsgroup: linux.dev.kernel
> 
> It does seem a little bit less efficient, but I don't know think it's 
> necessarily a bug. There's no guarantee of what size writes will be used 
> with the memcpy_to/fromio functions.
> 

There are only a few semantics that make sense: fixed 8, 16, 32, or 64
bits, plus "optimal"; the latter to be used for anything that doesn't
require a specific transfer size.  Logically, an unqualified
"memcpy_to/fromio" should be the optimal size (as few transfers as
possible) -- we have a qualified "memcpy_to/fromio32" already, and 8-
and 16-bit variants could/should be added.

However, having the unqualified version do byte transfers seems like a
really bad idea.

	-hpa

