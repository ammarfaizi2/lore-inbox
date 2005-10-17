Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750999AbVJQSlJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbVJQSlJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 14:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbVJQSlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 14:41:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:164 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750999AbVJQSlI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 14:41:08 -0400
Date: Mon, 17 Oct 2005 11:40:18 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Dipankar Sarma <dipankar@in.ibm.com>
cc: Eric Dumazet <dada1@cosmosbay.com>, Jean Delvare <khali@linux-fr.org>,
       Serge Belyshev <belyshev@depni.sinp.msu.ru>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: VFS: file-max limit 50044 reached
In-Reply-To: <20051017162930.GC13665@in.ibm.com>
Message-ID: <Pine.LNX.4.64.0510171137400.3369@g5.osdl.org>
References: <Pine.LNX.4.64.0510161912050.23590@g5.osdl.org>
 <JTFDVq8K.1129537967.5390760.khali@localhost> <20051017084609.GA6257@in.ibm.com>
 <43536A6C.102@cosmosbay.com> <20051017103244.GB6257@in.ibm.com>
 <Pine.LNX.4.64.0510170829000.23590@g5.osdl.org> <4353CADB.8050709@cosmosbay.com>
 <Pine.LNX.4.64.0510170911370.23590@g5.osdl.org> <20051017162930.GC13665@in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 17 Oct 2005, Dipankar Sarma wrote:
> 
> At the moment however I do have another concern - open/close taking too
> much time as I mentioned in an earlier email. It is nearly 4 times
> slower than 2.6.13. So, that is first up in my list of things to
> do at the moment.

It's not slower for me. For me, lmbench shows open/close as being pretty 
stable at least since 2.6.12.

Are you sure that your dentry cache tests haven't just filled up the 
dentry lists so much that when you compare open/close performance after 
the dentry tests, they seem much slower than your numbers from before?

If you run something that fills up the dentry cache, open/close will be 
slower just because the open part will have to traverse longer hash 
chains.

			Linus
