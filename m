Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262684AbTJDSYf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 14:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262686AbTJDSYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 14:24:35 -0400
Received: from waste.org ([209.173.204.2]:43162 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262684AbTJDSYe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 14:24:34 -0400
Date: Sat, 4 Oct 2003 13:24:17 -0500
From: Matt Mackall <mpm@selenic.com>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: Erlend Aasland <erlend-a@ux.his.no>, Steven French <sfrench@us.ibm.com>,
       James Morris <jmorris@intercode.com.au>,
       Samba Technical Mailing List <samba-technical@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH CIFS] use CryptoAPI MD4/MD5
Message-ID: <20031004182417.GC13573@waste.org>
References: <OF9C1504BB.5FB00D5A-ON87256DB3.0015672E-86256DB3.001798AE@us.ibm.com> <20031002113759.GA19824@badne3.ux.his.no> <Pine.LNX.4.58.0310041058000.5954@twinlark.arctic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0310041058000.5954@twinlark.arctic.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 04, 2003 at 11:00:01AM -0700, dean gaudet wrote:
> what about CryptoAPI is so expensive that you can't use a stack-based
> context?

The alloc functions hide a bunch of module lookup details and the size
of the context structures vary from one alg to the next. They also
tend to hide block-sized buffers to deal with fragments. So it's a
little ugly but not insurmountable.

> this seems pretty dumb converting a stack-based md5 context to multiple
> instances in multiple structures.
> 
> the stack is almost guaranteed to be in L1 cache.
> 
> multiplying that structure by N connections is just a waste of memory
> bandwidth.  not to mention the locking crud you seem to need to do... the
> stack is implicitly locked.
> 
> is CryptoAPI really this broken?

It's a bit inflexible in this regard, yes.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
