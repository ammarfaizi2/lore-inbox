Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965139AbVKBRhH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965139AbVKBRhH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 12:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbVKBRhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 12:37:06 -0500
Received: from agmk.net ([217.73.31.34]:8716 "EHLO mail.agmk.net")
	by vger.kernel.org with ESMTP id S1751266AbVKBRhF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 12:37:05 -0500
From: =?utf-8?q?Pawe=C5=82_Sikora?= <pluto@agmk.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6.14-rt1] slowdown / oops.
Date: Wed, 2 Nov 2005 18:36:58 +0100
User-Agent: KMail/1.8.3
Cc: Ingo Molnar <mingo@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511021836.59055.pluto@agmk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > more updates: NETFILTER_DEBUG catches the situation too - the problem 
> > seems to be wrong reference counts on the skb. [...]
> 
> ok, could you check whether the patch below fixes the problem for you?  
> (I have also put it into -rt4)
> 
> local_bh_disable()/enable() is a NOP under PREEMPT_RT, and the 
> ip_ct_deliver_cached_events PER_CPU code relies on not being preempted 
> by the net_rx_action softirq handler. So this is a bug in PREEMPT_RT and 
> the upstream code should be fine.

Thx, -rt4 works fine.

-- 
The only thing necessary for the triumph of evil
  is for good men to do nothing.
                                           - Edmund Burke
