Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265973AbUGVOQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265973AbUGVOQW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 10:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265966AbUGVOQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 10:16:22 -0400
Received: from hera.kernel.org ([63.209.29.2]:19339 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S265973AbUGVOQH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 10:16:07 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: [PATCH] Delete cryptoloop
Date: Thu, 22 Jul 2004 14:14:42 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <cdoi4i$iic$1@terminus.zytor.com>
References: <Pine.LNX.4.58.0407211609230.19655@devserv.devel.redhat.com> <20040721230044.20fdc5ec.akpm@osdl.org> <Pine.LNX.4.58.0407212319560.13098@devserv.devel.redhat.com> <pan.2004.07.22.07.43.41.872460@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1090505682 19021 127.0.0.1 (22 Jul 2004 14:14:42 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Thu, 22 Jul 2004 14:14:42 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <pan.2004.07.22.07.43.41.872460@smurf.noris.de>
By author:    Matthias Urlichs <smurf@smurf.noris.de>
In newsgroup: linux.dev.kernel
>
> Hi, James Morris wrote:
> 
> > It would be good if we could get some further review on the issue by an 
> > independent, well known cryptographer.
> 
> Well, I'm not, but ...
> 
> AFAIK, the main issue is: If I write some data to the start of block N, I
> get a bit pattern. If I write the same data *anywhere* else (the middle of
> block N, the start of block M != N, a different on-disk bit pattern must
> result.
> 
> If there are identical bit patterns, then the system is vulnerable.
> Obviously, this vulnerability doesn't depend on whether you're using
> cryptoloop or dm-crypt.
> 

So does cryptoloop use a different IV for different blocks?  The need
for the IV to be secret is different for different ciphers, but for
block ciphers the rule is that is must not repeat, and at least
according to some people must not be trivially predictable.  One way
to do that is to use a secure hash of (key,block #) as the IV.

	-hpa

