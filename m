Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbUCBFrq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 00:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbUCBFrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 00:47:46 -0500
Received: from hera.kernel.org ([63.209.29.2]:48004 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261569AbUCBFrf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 00:47:35 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: something funny about tty's on 2.6.4-rc1-mm1
Date: Tue, 2 Mar 2004 05:47:27 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c2175f$6hn$1@terminus.zytor.com>
References: <20040301184512.GA21285@hobbes.itsari.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1078206447 6712 63.209.29.3 (2 Mar 2004 05:47:27 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Tue, 2 Mar 2004 05:47:27 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20040301184512.GA21285@hobbes.itsari.int>
By author:    Nuno Monteiro <nuno@itsari.org>
In newsgroup: linux.dev.kernel
> 
> I know for a fact that I don't have 157 logged in users (well, there's  
> only 45 processes running right now), and shouldn't pts' be recycled, and  
> a lower number be assigned? The last kernel I ran was 2.6.3, and none of  
> this happened.
> 
> My config is:
> 
> CONFIG_UNIX98_PTYS=y
> CONFIG_LEGACY_PTYS=y
> CONFIG_LEGACY_PTY_COUNT=512
> 
> and this is a plain jane static /dev -- not devfs nor udev. Despite the  
> supposedly 157 users logged in, /dev/pts only contains '358', which is  
> the one allocated to this instance of aterm right now.
> 
> nuno@hobbes:~$ ls -l /dev/pts
> total 0
> crw--w----    1 nuno     users    136, 102 Mar  1 18:41 358
> 
> In the mean time I'll fall back to 2.6.3.
> 

No need to, as there is no error (except that you need a newer libc or
ls to properly show the device number.)

As RBJ said, ptys are now recycled in pid-like fashion, which means
numbers won't be reused until wraparound happens.  This is good for
security/fault tolerance, at least to some minor degree.

	-hpa

