Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262153AbVAOCfH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbVAOCfH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 21:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262156AbVAOCfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 21:35:07 -0500
Received: from hera.kernel.org ([209.128.68.125]:6823 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S262153AbVAOCe6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 21:34:58 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: short read from /dev/urandom
Date: Sat, 15 Jan 2005 02:34:37 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <cs9vft$412$1@terminus.zytor.com>
References: <41E7509E.4030802@redhat.com> <20050114191056.GB17481@thunk.org> <41E833F4.8090800@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1105756477 4131 127.0.0.1 (15 Jan 2005 02:34:37 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Sat, 15 Jan 2005 02:34:37 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <41E833F4.8090800@redhat.com>
By author:    Ulrich Drepper <drepper@redhat.com>
In newsgroup: linux.dev.kernel
> 
> The code in question comes from a crypto library which is in wide use 
> (http://www.cryptopp.com) and it is using urandom under this assumption. 
>   I fear there is quite a bit more code like this out there.  Changing 
> the ABI after the fact is no good and dangerous in this case.
> 
> I know this is making the device special, but I really think the 
> no-short-reads property should be perserved for urandom.
> 

Does *anything* have it, including files?

I think read() always has the option of returning a short read on
signal delivery.

What urandom has is a no-block guarantee, i.e. the behaviour should be
identical in the presense of the O_NONBLOCK flag, and select/poll
should always indicate that data can be read.

	-hpa
