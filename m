Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbUCCVow (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 16:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbUCCVow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 16:44:52 -0500
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:33803 "EHLO
	abraham.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S261154AbUCCVov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 16:44:51 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@taverner.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: dm-crypt, new IV and standards
Date: Wed, 3 Mar 2004 21:40:05 +0000 (UTC)
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <c25jbl$732$1@abraham.cs.berkeley.edu>
References: <20040220172237.GA9918@certainkey.com> <20040221164821.GA14723@certainkey.com> <Pine.LNX.4.58.0403022352080.12846@twinlark.arctic.org> <20040303150647.GC1586@certainkey.com>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1078350005 7266 128.32.153.228 (3 Mar 2004 21:40:05 GMT)
X-Complaints-To: usenet@abraham.cs.berkeley.edu
NNTP-Posting-Date: Wed, 3 Mar 2004 21:40:05 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean-Luc Cooke  wrote:
>Christophe and I's scheme of IV = firstIV + blockNum
>for initial setup and IV = IV + 2^64 for IV updates will work fine

That's not ideal.  I'd suggest IV = HMAC_k(firstIV, blockNum) or somesuch.
Sequential IV's aren't a good choice with CBC -- they can leak a little
bit of information about the first block of plaintext, in some cases.
