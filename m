Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751079AbVICRIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbVICRIB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 13:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbVICRIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 13:08:01 -0400
Received: from [81.2.110.250] ([81.2.110.250]:25794 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751079AbVICRIA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 13:08:00 -0400
Subject: Re: [PATCH 2.6.13] lockless pagecache 2/7
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andi Kleen <ak@suse.de>, Linux Memory Management <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4318FF2B.6000805@yahoo.com.au>
References: <4317F071.1070403@yahoo.com.au> <4317F0F9.1080602@yahoo.com.au>
	 <4317F136.4040601@yahoo.com.au>
	 <1125666486.30867.11.camel@localhost.localdomain>
	 <p73k6hzqk1w.fsf@verdi.suse.de>  <4318C28A.5010000@yahoo.com.au>
	 <1125705471.30867.40.camel@localhost.localdomain>
	 <4318FF2B.6000805@yahoo.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 03 Sep 2005 18:31:36 +0100
Message-Id: <1125768697.14987.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-09-03 at 11:40 +1000, Nick Piggin wrote:
> We'll see how things go. I'm fairly sure that for my usage it will
> be a win even if it is costly. It is replacing an atomic_inc_return,
> and a read_lock/read_unlock pair.

Make sure you bench both AMD and Intel - I'd expect it to be a big loss
on AMD because the AMD stuff will perform atomic locked operations very
efficiently if they are already exclusive on this CPU or a prefetch_w()
on them was done 200+ clocks before.

