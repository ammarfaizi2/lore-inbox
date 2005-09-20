Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932727AbVITFQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932727AbVITFQp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 01:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932728AbVITFQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 01:16:45 -0400
Received: from mailwasher.lanl.gov ([192.65.95.54]:15780 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S932727AbVITFQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 01:16:45 -0400
Subject: Re: [Question] How to understand Clock-Pro algorithm?
From: Song Jiang <sjiang@lanl.gov>
To: liyu <liyu@ccoss.com.cn>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
In-Reply-To: <432F97E1.4080805@ccoss.com.cn>
References: <432F7DD5.6050204@ccoss.com.cn>
	 <1127188898.3130.52.camel@moon.c3.lanl.gov> <432F97E1.4080805@ccoss.com.cn>
Content-Type: text/plain
Message-Id: <1127193398.3130.131.camel@moon.c3.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-16) 
Date: Mon, 19 Sep 2005 23:16:38 -0600
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.1.128075
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-09-19 at 23:02, liyu wrote:

> 
>     Let's assume Mn is the total number of non-resident pages in follow 
> words.
> 
>     Nod, 'M=Mh+Mc' and 'Mc+Mn' < 2M are always true.
> 
>     Have this implied that Mn is alway less than M? I think so.
    Yes.

> 
>     but if "Once the number exceeds M the memory size in number of pages,
> we terminted the test period of the cold page pointed to by HAND-test."
> 
>     If Mn is alway less than M, when we move to HAND-test?

The algorithm tries to ensure that Mn <= M holds. 
Once Mn == M+1 is detected, run HAND-test to bring it
back to Mn == M. That is, only during the transition period, 
Mn <= M might not hold, and we make a correction quickly.

So there is no contradiction here.
   Song

> 


