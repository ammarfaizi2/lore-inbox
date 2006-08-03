Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932546AbWHCViM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932546AbWHCViM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 17:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932565AbWHCViL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 17:38:11 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:43188
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932546AbWHCViK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 17:38:10 -0400
Date: Thu, 03 Aug 2006 14:37:28 -0700 (PDT)
Message-Id: <20060803.143728.43853414.davem@davemloft.net>
To: johnpol@2ka.mipt.ru
Cc: dada1@cosmosbay.com, linux-kernel@vger.kernel.org, drepper@redhat.com,
       netdev@vger.kernel.org, zach.brown@oracle.com
Subject: Re: [take3 1/4] kevent: Core files.
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060803145553.GA12915@2ka.mipt.ru>
References: <11545983603399@2ka.mipt.ru>
	<200608031640.34513.dada1@cosmosbay.com>
	<20060803145553.GA12915@2ka.mipt.ru>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Date: Thu, 3 Aug 2006 18:55:57 +0400

> I would not call that wrong - system prevents some threads from removing 
> kevents which are counted to be transfered to the userspace, i.e. when 
> dequeuing was awakened and it had seen some events it is possible, that 
> when it will dequeue them part will be removed by other thread, so I 
> prevent this.

Queue is all that matters to be synchronized, so it seems
better to have a mutex on the queue rather than a global
one.  That way, user can only hurt himself.
