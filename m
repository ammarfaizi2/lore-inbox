Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030392AbVLHA7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030392AbVLHA7q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 19:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030405AbVLHA7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 19:59:46 -0500
Received: from ihug-mail.icp-qv1-irony5.iinet.net.au ([203.59.1.199]:33118
	"EHLO mail-ihug.icp-qv1-irony5.iinet.net.au") by vger.kernel.org
	with ESMTP id S1030392AbVLHA7p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 19:59:45 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
Message-ID: <4397857D.8040604@cyberone.com.au>
Date: Thu, 08 Dec 2005 11:59:41 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <clameter@engr.sgi.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [PATCH] swap migration: Fix lru drain
References: <Pine.LNX.4.62.0512071351010.25527@schroedinger.engr.sgi.com> <43976FD4.8060404@cyberone.com.au> <Pine.LNX.4.62.0512071641080.26288@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0512071641080.26288@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:

>On Thu, 8 Dec 2005, Nick Piggin wrote:
>
>
>>Do we need a lock_cpu_hotplug() around here?
>>
>
>Well, then we may need that lock for each "for_each_online_cpu" use?
>

I think it depends on where and how it is used?

eg. for statistics gathering it doesn't matter so much. In this
case it would seem that you do want an actual online CPU... though
on looking at the workqueue code it seems that some of it would be
racy in a similar way, so perhaps this is handled elsewhere (I
can't see how, though).

> 
>
>>Can't this deadlock if 2 CPUs each send work to the other
>>
>
>Then we would need to fix the workqueue flushing function.
>
>

Oh, you're right.

