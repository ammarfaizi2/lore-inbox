Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263585AbUEWUkk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263585AbUEWUkk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 16:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263588AbUEWUkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 16:40:40 -0400
Received: from mail-relay-2.tiscali.it ([212.123.84.92]:37797 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S263585AbUEWUki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 16:40:38 -0400
From: Lorenzo Allegrucci <l_allegrucci@despammed.com>
Organization: -ENOENT
To: Jens Axboe <axboe@suse.de>
Subject: Re: 2.6.6-mm5 oops mounting ext3 or reiserfs with -o barrier
Date: Sun, 23 May 2004 22:41:13 +0200
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200405222107.55505.l_allegrucci@despammed.com> <200405231917.52517.l_allegrucci@despammed.com> <20040523173100.GA9914@suse.de>
In-Reply-To: <20040523173100.GA9914@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405232241.14069.l_allegrucci@despammed.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 23 May 2004 19:31, Jens Axboe wrote:

> It just looks odd that eg reads vary as much as they do, and that -o
> barrier=1 makes -W0 reads faster (and faster then -W1 even). remove
> looks reasonable for -W1, but -W0 is still faster. That is _really_ odd.

I rerun all tests with noatime.
Using noatime numbers look more predictable but I cannot guarantee
any statistical relevance.

hdparm -W1
ext3 (-o barrier=0,noatime)
untar		read		copy		remove
0m56.744s	0m22.452s	1m26.558s	0m20.683s
0m7.187s	0m1.153s	0m0.747s	0m0.101s
0m6.077s	0m3.045s	0m9.132s	0m1.907s

ext3 (-o barrier=1,noatime)
untar		read		copy		remove
0m55.152s	0m21.340s	1m23.705s	0m19.369s
0m7.237s	0m1.217s	0m0.788s	0m0.077s
0m6.513s	0m3.082s	0m9.226s	0m1.507s


haparm -W0
ext3 (-o barrier=0,noatime)
untar		read		copy		remove
1m55.221s	0m23.768s	2m12.458s	0m22.256s
0m7.227s	0m1.216s	0m0.756s	0m0.085s
0m6.424s	0m3.002s	0m9.085s	0m1.560s

ext3 (-o barrier=1,noatime)
untar		read		copy		remove
1m56.578s	0m23.382s	2m14.117s	0m22.289s
0m7.035s	0m1.202s	0m0.766s	0m0.089s
0m6.814s	0m3.103s	0m9.141s	0m1.696s

-- 
Lorenzo
