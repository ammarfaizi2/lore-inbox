Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318979AbSIIVHG>; Mon, 9 Sep 2002 17:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318980AbSIIVHG>; Mon, 9 Sep 2002 17:07:06 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:7664 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318979AbSIIVHD>; Mon, 9 Sep 2002 17:07:03 -0400
Subject: Re: LMbench2.0 results
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@digeo.com>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Paolo Ciarrocchi <ciarrocchi@linuxmail.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <3D7B9988.6B8CD04F@digeo.com>
References: <2090000.1031442267@flay>
	<1031504848.26888.238.camel@irongate.swansea.linux.org.uk> 
	<3D7B9988.6B8CD04F@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 09 Sep 2002 22:13:52 +0100
Message-Id: <1031606032.29715.58.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-09-08 at 19:40, Andrew Morton wrote:
> We need to find some way of making vm_enough_memory not call get_page_state
> so often.  One way of doing that might be to make get_page_state dump
> its latest result into a global copy, and make vm_enough_memory()
> only get_page_state once per N invokations.  A speed/accuracy tradeoff there.

Unless the error always falls on the same side the accuracy tradeoff is
fatal to the entire scheme of things. Sorting out the use of
get_page_state is worth doing if that is the bottleneck, and
snapshooting such that we only look at it if we might be close to the
limit would work, but we'd need to know when the limit had shifted too
much

