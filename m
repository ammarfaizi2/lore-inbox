Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285088AbRLFKAP>; Thu, 6 Dec 2001 05:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285086AbRLFKAG>; Thu, 6 Dec 2001 05:00:06 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:19973 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S285074AbRLFJ7w>; Thu, 6 Dec 2001 04:59:52 -0500
Date: Thu, 6 Dec 2001 12:59:35 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Kurt Garloff <garloff@suse.de>,
        Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: IDE DMA on AXP & barriers
Message-ID: <20011206125935.A3930@jurassic.park.msu.ru>
In-Reply-To: <20011206061315.J13427@garloff.etpnet.phys.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011206061315.J13427@garloff.etpnet.phys.tue.nl>; from garloff@suse.de on Thu, Dec 06, 2001 at 06:13:15AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2001 at 06:13:15AM +0100, Kurt Garloff wrote:
> I would imagine that the following barriers are nacessary:
> * After setting up the IDE DMA tables (PRD) and having the data there,
>   we need to have a barrier before telling the controller to do DMA.

Actually, we have more than one - the memory barriers are hidden in outX()
macros.

> * After the controller is done with it, we need to make sure the
>   data is in mem before we use it (i.e. we need some mb() equiv on the
>   controller)

Sure, otherwise the controller just wouldn't work, and not only on alpha.
I never had any problems with IDE DMA on lx164 (which has exactly the same
IDE chip), but it was back in 2.3 or 2.4-test times...
Maybe something got broken since then - I could check this (if I find
a spare IDE drive).

Ivan.
