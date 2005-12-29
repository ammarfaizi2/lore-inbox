Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965125AbVL2JNO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965125AbVL2JNO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 04:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965124AbVL2JNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 04:13:13 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:9608 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S965123AbVL2JNN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 04:13:13 -0500
Date: Thu, 29 Dec 2005 11:12:57 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: cai <junjiec@gmail.com>
cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][fat] use mpage_readpage when cluster size is page-alignment
In-Reply-To: <43B3A3D8.6050605@gmail.com>
Message-ID: <Pine.LNX.4.58.0512291107560.16171@sbz-30.cs.Helsinki.FI>
References: <ca992f110512272356l379dccc5k6288c28411ff7af4@mail.gmail.com> 
 <87u0ctwf93.fsf@devron.myhome.or.jp> <43B3844A.5050401@gmail.com>
 <84144f020512290006x71d2c245s5e148fae15720d59@mail.gmail.com>
 <43B3A3D8.6050605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Dec 2005, cai wrote:
> > I am not sure I am following you. Shouldn't do_mpage_readpage work for
> > all adjacent blocks regardless of whether block size is page-aligned
> > or not? What's is the performance problem you're thinking of?
>  
> no, not block size but cluster size
> as you know, in FAT, file is organized in clusters
> and one cluster could have N blocks(sectors).
> so if cluster size is not page-aligned,
> a page may live in non-adjacent blocks, and
> do_mpage_readpage has to fall back to block_read_full_page
> in this case.

But the non-page-aligned clusters can be adjacent on disk, no? Besides, I 
don't think there's enough overhead in do_mpage_readpage for the 
non-adjacent case to justify keeping the non-mpage version around.

				Pekka
