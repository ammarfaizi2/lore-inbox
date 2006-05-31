Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932394AbWEaBNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbWEaBNj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 21:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932554AbWEaBNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 21:13:39 -0400
Received: from hera.kernel.org ([140.211.167.34]:19076 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932394AbWEaBNi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 21:13:38 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: memcpy_toio on i386 using byte writes even when n%2==0
Date: Tue, 30 May 2006 18:13:27 -0700 (PDT)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <e5iqjn$u22$1@terminus.zytor.com>
References: <6gUec-3mb-7@gated-at.bofh.it> <6icVy-56r-9@gated-at.bofh.it> <6idov-5Tc-7@gated-at.bofh.it> <447CE99B.7070707@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1149038007 30787 127.0.0.1 (31 May 2006 01:13:27 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Wed, 31 May 2006 01:13:27 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <447CE99B.7070707@shaw.ca>
By author:    Robert Hancock <hancockr@shaw.ca>
In newsgroup: linux.dev.kernel
> > 
> > Note that there isn't any code for moving dwords because the
> > chances of gaining anything are slim (alignment may hurt).
> 
> I'd say the chances of gaining something from executing half as many 
> instructions on copying a large block of memory are very good indeed..
> 

For something that generates I/O transactions, it's imperative to
generate the smallest possible number of transactions.  Furthermore,
smaller than dword transactions aren't burstable, except at the
beginning and end of a burst.

	-hpa

