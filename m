Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264798AbUEQAnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264798AbUEQAnz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 20:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264800AbUEQAnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 20:43:55 -0400
Received: from hera.kernel.org ([63.209.29.2]:27551 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S264798AbUEQAnt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 20:43:49 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: [PATCH 2.6.6] bootmem.c cleanup
Date: Mon, 17 May 2004 00:43:16 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c891r4$5i3$1@terminus.zytor.com>
References: <200405142205.27214.mbuesch@freenet.de> <20040514133353.236acf3a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1084754596 5700 127.0.0.1 (17 May 2004 00:43:16 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Mon, 17 May 2004 00:43:16 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20040514133353.236acf3a.akpm@osdl.org>
By author:    Andrew Morton <akpm@osdl.org>
In newsgroup: linux.dev.kernel
>
> Michael Buesch <mbuesch@freenet.de> wrote:
> >
> >  -		if (!test_and_clear_bit(i, bdata->node_bootmem_map))
> >  -			BUG();
> >  +		BUG_ON(!test_and_clear_bit(i, bdata->node_bootmem_map));
> 
> Please don't put expressions whihc actually change state inside BUG_ON(). 
> Someone may decide to make BUG_ON() a no-op to save space.
> 
> I'm not aware of anyone actually trying that, but it's a good objective.
> 

If so they should make it:

#define	BUG_ON(x)	((void)(x))

.. which preserves side effects while generating no object code for a
side-effect-free expression.

The only reason for the cast to (void) at all is to keep gcc from
complaining about an ignored expression.

	-hpa
