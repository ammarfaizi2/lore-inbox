Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266825AbUBFV6z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 16:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266828AbUBFV6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 16:58:55 -0500
Received: from mail-07.iinet.net.au ([203.59.3.39]:7382 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S266825AbUBFV6A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 16:58:00 -0500
Message-ID: <40240DE4.8030705@cyberone.com.au>
Date: Sat, 07 Feb 2004 08:57:56 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Rick Lindsley <ricklind@us.ibm.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, mjbligh@us.ibm.com,
       dvhltc@us.ibm.com
Subject: Re: [PATCH] Load balancing problem in 2.6.2-mm1
References: <200402061813.i16IDO707026@owlet.beaverton.ibm.com>
In-Reply-To: <200402061813.i16IDO707026@owlet.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Rick Lindsley wrote:

>    >+	if ((long)*imbalance < 0)
>    >+		*imbalance = 0;
>    > 
>    
>    You're right Rick, thanks for catching this. Why do you have
>    this last test though? This shouldn't be possible?
>
>A combination of paranoia and leftover code from a previous fix :)  At the
>least, this could probably become a BUG_ON now, or I wouldn't cry if
>we took it out entirely.
>
>

I gave it a run with WARN_ON for a while and its fine so we'll
take it out all together.

We also shouldn't need load_diff, because if (avg_load <= this_load)
then imbalance will be zero, so I'll fix that up.

