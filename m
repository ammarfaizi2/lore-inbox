Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbTFFQjR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 12:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262015AbTFFQjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 12:39:16 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:28361 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S262013AbTFFQjP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 12:39:15 -0400
Message-ID: <3EE0C6CD.4000407@colorfullife.com>
Date: Fri, 06 Jun 2003 18:52:29 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: arvind.kan@wipro.com
CC: William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, akpm@digeo.com,
       "indou.takao" <indou.takao@jp.fujitsu.com>, Dave Jones <davej@suse.de>
Subject: Re: [RFC][PATCH 2.5.70] Static tunable semvmx and semaem
References: <3EE02C53.1040800@wipro.com>
In-Reply-To: <3EE02C53.1040800@wipro.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arvind Kandhare wrote:

>
> Hi,
> Please find below patch(RFC) for implementing semvmx and semaem
> as static tunable parameters.
>
Have you thought about signed/unsigned issues? Which unix permits values 
 > 32767? Are there any potential user space problems?

I did a quick google search, and found this:
http://www.core-software.ch/samples/www/SunFire_3800/SunFire_3800.pdf, 
i.e. Solaris 2.x:
<<
SEMVMX 32767 Limits the maximum value of a semaphore. Due to the 
interaction with undo structures and semaem (see below), this tunable 
should not be increased beyond its default value of 32767, unless you 
can guarantee that SEM_UNDO is never and will never be used. It can be 
safely reduced, but doing so provides no savings.
SEMAEM 16384 Limits the maximum value of an adjust-on-exit undo element. 
No system resources are allocated based on this value.
<<

And as I wrote, I'd prefer a patch that just does s/32767/65535/ - 
either it is safe, or it's unsafe. If it's unsafe, then it should remain 
at 32767. If it safe, then we can increase it unconditionally, because a 
reduction below the upper limit provides no savings.

--
    Manfred

