Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965083AbWEaSk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965083AbWEaSk6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 14:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965086AbWEaSk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 14:40:58 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:6340
	"EHLO sunset.sfo1.dsl.speakeasy.net") by vger.kernel.org with ESMTP
	id S965083AbWEaSk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 14:40:57 -0400
Date: Wed, 31 May 2006 11:41:27 -0700 (PDT)
Message-Id: <20060531.114127.14356069.davem@davemloft.net>
To: johnpol@2ka.mipt.ru
Cc: draghuram@rocketmail.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: Question about tcp hash function tcp_hashfn()
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060531105814.GB7806@2ka.mipt.ru>
References: <20060531090301.GA26782@2ka.mipt.ru>
	<20060531035124.B3065@openss7.org>
	<20060531105814.GB7806@2ka.mipt.ru>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Date: Wed, 31 May 2006 14:58:18 +0400

> On Wed, May 31, 2006 at 03:51:24AM -0600, Brian F. G. Bidulock (bidulock@openss7.org) wrote:
> >   Worse: he folded the jenkins algorith result with
> > 
> >    h ^= h >> 16;
> >    h ^= h >> 8;
> > 
> >   Destroying the coverage of the function.
> 
> It was done to simulate socket code which uses the same folding.
> Leaving 32bit space is just wrong, consider hash table size with that
> index.

You absolutely show not do this shifting on the jenkins hash
result, you destroy the distribution entirely.  Just mask
it with the hash mask and that's all you need to do.

Brian is right, this is absolutely critical to using the Jenkins hash
correctly.  You're "unmixing" the bits it worked so hard to mix.

