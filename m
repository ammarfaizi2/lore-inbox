Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262679AbTJDSAF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 14:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262683AbTJDSAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 14:00:05 -0400
Received: from twinlark.arctic.org ([168.75.98.6]:28384 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S262679AbTJDSAC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 14:00:02 -0400
Date: Sat, 4 Oct 2003 11:00:01 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Erlend Aasland <erlend-a@ux.his.no>
cc: Steven French <sfrench@us.ibm.com>,
       James Morris <jmorris@intercode.com.au>, Matt Mackall <mpm@selenic.com>,
       Samba Technical Mailing List <samba-technical@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH CIFS] use CryptoAPI MD4/MD5
In-Reply-To: <20031002113759.GA19824@badne3.ux.his.no>
Message-ID: <Pine.LNX.4.58.0310041058000.5954@twinlark.arctic.org>
References: <OF9C1504BB.5FB00D5A-ON87256DB3.0015672E-86256DB3.001798AE@us.ibm.com>
 <20031002113759.GA19824@badne3.ux.his.no>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.58.0310041058002.5954@twinlark.arctic.org>
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

what about CryptoAPI is so expensive that you can't use a stack-based
context?

this seems pretty dumb converting a stack-based md5 context to multiple
instances in multiple structures.

the stack is almost guaranteed to be in L1 cache.

multiplying that structure by N connections is just a waste of memory
bandwidth.  not to mention the locking crud you seem to need to do... the
stack is implicitly locked.

is CryptoAPI really this broken?

-dean
