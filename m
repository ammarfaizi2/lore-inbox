Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030256AbVHJUb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030256AbVHJUb1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 16:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030259AbVHJUb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 16:31:27 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:37770
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030256AbVHJUb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 16:31:26 -0400
Date: Wed, 10 Aug 2005 13:31:25 -0700 (PDT)
Message-Id: <20050810.133125.08323684.davem@davemloft.net>
To: riel@redhat.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFT 4/5] CLOCK-Pro page replacement
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050810200943.809832000@jumble.boston.redhat.com>
References: <20050810200216.644997000@jumble.boston.redhat.com>
	<20050810200943.809832000@jumble.boston.redhat.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rik van Riel <riel@redhat.com>
Date: Wed, 10 Aug 2005 16:02:20 -0400

> +DEFINE_PER_CPU(unsigned long, evicted_pages);

DEFINE_PER_CPU() needs an explicit initializer to work
around some bugs in gcc-2.95, wherein on some platforms
if you let it end up as a BSS candidate it won't end up
in the per-cpu section properly.

I'm actually happy you made this mistake as it forced me
to audit the whole current 2.6.x tree and there are few
missing cases in there which I'll fix up and send to Linus.
:-)
