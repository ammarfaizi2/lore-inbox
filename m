Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261211AbVBVTt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbVBVTt3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 14:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbVBVTt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 14:49:29 -0500
Received: from rain.plan9.de ([193.108.181.162]:61343 "EHLO rain.plan9.de")
	by vger.kernel.org with ESMTP id S261211AbVBVTtH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 14:49:07 -0500
Date: Tue, 22 Feb 2005 20:49:00 +0100
From: <pcg@goof.com ( Marc) (A.) (Lehmann )>
To: Andreas Steinmetz <ast@domdv.de>
Cc: Alex Adriaanse <alex.adriaanse@gmail.com>, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: Odd data corruption problem with LVM/ReiserFS
Message-ID: <20050222194900.GB10968@schmorp.de>
Mail-Followup-To: Andreas Steinmetz <ast@domdv.de>,
	Alex Adriaanse <alex.adriaanse@gmail.com>,
	linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
References: <93ca3067050220212518d94666@mail.gmail.com> <4219C811.5070906@domdv.de> <20050222190149.GB9590@schmorp.de> <421B8A69.8000903@domdv.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <421B8A69.8000903@domdv.de>
X-PGP: "1024D/DA743396 1999-01-26 Marc Alexander Lehmann <schmorp@schmorp.de>
       Key fingerprint = 475A FE9B D1D4 039E 01AC  C217 A1E8 0270 DA74 3396"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2005 at 08:39:21PM +0100, Andreas Steinmetz <ast@domdv.de> wrote:
> To clarify: there were no disk I/O errors, only I/O errors were reported 
>  by find during operation so it is definitely filesystem corruption 
> that is  going on here.
> Though find performs heavy read activity there could well be heavy write 
> activity be involved due to atime updates so this fits your description.

That wouldn't fill my definition for "heavy", but as it is a race
somewhere, it can happen undr many circumstances, I guess.

> >A reboot fixes this for both ext3 and reiserfs (i.e. the error is gone).
> >
> 
> Well, it didn't fix it for me. The fs was trashed for good. The major 
> question for me is now usability of md/dm for any purpose with 2.6.x. 
> For me this is a showstopper for any kind of 2.6 production use.

Well, I do use reiserfs->aes-loop->lvm/dm->md5/raid5, and it never failed
for me, except once, and the error is likely to be outside reiserfs, and
possibly outside lvm.

However, your case *is* different, as corruption wasn't permament for me,
so chances are that you are hitting sth. else.

Of course, many people find 2.6 too unstable for production use (remember
2.4.x, it was the same), and the most important rule is: if it fails for
you, it's a showstopper.

Also, mild corruption is likely to be more disastrous to reiserfs as it
uses a much denser representation on disk (in other words: it uses space
more efficiently, but that comes at the price of redundancy).

-- 
                The choice of a
      -----==-     _GNU_
      ----==-- _       generation     Marc Lehmann
      ---==---(_)__  __ ____  __      pcg@goof.com
      --==---/ / _ \/ // /\ \/ /      http://schmorp.de/
      -=====/_/_//_/\_,_/ /_/\_\      XX11-RIPE
