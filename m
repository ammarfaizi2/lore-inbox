Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261430AbVFAPld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbVFAPld (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 11:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbVFAPlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 11:41:32 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:49601 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261430AbVFAPjU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 11:39:20 -0400
Message-ID: <429DD88B.7168BC77@tv-sign.ru>
Date: Wed, 01 Jun 2005 19:47:23 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Walker <dwalker@mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc4-V0.7.47-06
References: <Pine.LNX.4.44.0506010756490.23057-100000@dhcp153.mvista.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Walker wrote:
> 
> On Wed, 1 Jun 2005, Oleg Nesterov wrote:
> 
> > Sorry, I don't understand you. Could you please explain this to me?
> 
> plist_for_each() was just created to walk through all the nodes in the
> list, There is no guaranteed ordering via that method. From your test it
> appeared to be working since you printed all the nodes you inserted.

Yes, plist_for_each() without plist_entry() works.

> There are other methods like plist_first() which will give you FIFO
> ordered nodes (or should) . The reason is that plist_first() pulls off the
> dp_node , which is the first node inserted at that priority. All the other
> nodes are inserted behind the dp_node. That's why I used list_add() and
> not list_add_tail()

So plist_for_each() works in reverse order, and the comment about
fifo ordering applies only to plist_first(). Thanks for explanation.

I don't understand why you are doing it this way, though.

Oleg.
