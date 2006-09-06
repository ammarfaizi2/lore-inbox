Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030243AbWIFXa5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030243AbWIFXa5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 19:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030244AbWIFXa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 19:30:56 -0400
Received: from smtp19.orange.fr ([80.12.242.18]:24403 "EHLO
	smtp-msa-out19.orange.fr") by vger.kernel.org with ESMTP
	id S1030243AbWIFXaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 19:30:55 -0400
X-ME-UUID: 20060906233054693.A954F1C000A6@mwinf1918.orange.fr
From: Vincent Pelletier <vincent.plr@wanadoo.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched.c: Be a bit more conservative in SMP
Date: Thu, 7 Sep 2006 01:30:53 +0200
User-Agent: KMail/1.9.4
References: <200609031541.39984.subdino2004@yahoo.fr> <200609031910.57259.vincent.plr@wanadoo.fr>
In-Reply-To: <200609031910.57259.vincent.plr@wanadoo.fr>
Cc: mingo@elte.hu
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200609070130.53995.vincent.plr@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found one maybe-drawback to this change :
When runing n+1 process (n = number of cpu), one takes one cpu, the other 2 
share another cpu. And, because of this patch, all processes stay in their 
own cpu, so one always has 100% of cpu power, the 2 others get 50% each.
In current implementation, one of the 2 processes from the same cpu would 
migrate to the other cpu, and so on, somehow sharing cpu time among them.
Is it a feature or a side effect of current implementation ?

I'll do some tests soon to see which version gives better performance at a 
higher level than just process migration cost - if different at all.
-- 
Vincent Pelletier
