Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261292AbSJUJam>; Mon, 21 Oct 2002 05:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261293AbSJUJam>; Mon, 21 Oct 2002 05:30:42 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:18099 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261292AbSJUJam>; Mon, 21 Oct 2002 05:30:42 -0400
Subject: Re: [PATCH] [2.4.20-pre10]  dpt_i2o fix
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ducrot Bruno <poup@poupinou.org>
Cc: deanna_bonds@adaptec.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ducrot@poupinou.org
In-Reply-To: <20021015134001.GA3842@poup.poupinou.org>
References: <20021015134001.GA3842@poup.poupinou.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Oct 2002 10:52:12 +0100
Message-Id: <1035193932.27318.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-15 at 14:40, Ducrot Bruno wrote:
> The first chunk of attached patch alloc wait_data with
> kmalloc(..., GFP_ATOMIC) instead of GPF_KERNEL
> in the function adpt_i2o_post_wait() because this function
> is called in the function adpt_i2o_passthru() (line 1717 or
> so) but with a spin_lock held.

Given the nature of the usage I think its probably better to fix it
properly than to just hack it up to be GFP_ATOMIC. If the caller was to
pass in the wait_data buffer then the problem could be fixed cleanly

