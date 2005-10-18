Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751110AbVJRR0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbVJRR0F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 13:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbVJRR0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 13:26:05 -0400
Received: from rgminet02.oracle.com ([148.87.122.31]:20136 "EHLO
	rgminet02.oracle.com") by vger.kernel.org with ESMTP
	id S1751110AbVJRR0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 13:26:04 -0400
Message-ID: <4355301F.9020003@oracle.com>
Date: Tue, 18 Oct 2005 10:25:51 -0700
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cam.ac.uk>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       hch@infradead.org
Subject: Re: [RFC] page lock ordering and OCFS2
References: <20051017222051.GA26414@tetsuo.zabbo.net> <20051017161744.7df90a67.akpm@osdl.org> <43544499.5010601@oracle.com> <20051017182407.1f2c591a.akpm@osdl.org> <Pine.LNX.4.64.0510180916420.7514@hermes-1.csi.cam.ac.uk>
In-Reply-To: <Pine.LNX.4.64.0510180916420.7514@hermes-1.csi.cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:

> What I would ask is why does the above dlm thread need to hold the 
> data_lock duing truncate_inode_pages?

I hope the mail I just sent made that a little more clear.

> and repeat truncate_inode_pages, etc.  Eventually it will succeed.  And no 
> need for nasty VFS patch you are proposing...

Yeah, this also came to me this morning in the shower :)  There are some
hard cases because these are actually read-write locks, but it might be
doable.  We're discussing it.

> no pages left, unless there is an overeager read process at work on that 
> mapping at the same time.

I fear that it'll be pretty easy to get bad capture effects, but maybe
that's ok.  We'll see.

- z
