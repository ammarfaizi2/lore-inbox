Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751219AbWEEVM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbWEEVM0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 17:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751782AbWEEVM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 17:12:26 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:53709
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751219AbWEEVMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 17:12:25 -0400
Date: Fri, 05 May 2006 14:10:40 -0700 (PDT)
Message-Id: <20060505.141040.53473194.davem@davemloft.net>
To: mpm@selenic.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/14] random: Remove SA_SAMPLE_RANDOM from network
 drivers
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <8.420169009@selenic.com>
References: <2.420169009@selenic.com>
	<8.420169009@selenic.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Mackall <mpm@selenic.com>
Date: Fri, 05 May 2006 11:42:35 -0500

> Remove SA_SAMPLE_RANDOM from network drivers
> 
> /dev/random wants entropy sources to be both unpredictable and
> unobservable. Network devices are neither as they may be directly
> observed and controlled by an attacker. Thus SA_SAMPLE_RANDOM is not
> appropriate.
> 
> Signed-off-by: Matt Mackall <mpm@selenic.com>

Besides the other issues discussed, what you are doing is
essentially making a headless machine with a quiet disk have
next to zero entropy available.

I don't think we can seriously consider this patch, as I've seen real
users run into this lack of entropy issue.

If you want to do a generic thing in the networking to create
entropy, fine, but it must be on by default or else people in
the above situation (and there are many) will have an unusable
/dev/random and friends.
