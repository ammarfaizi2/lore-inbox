Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262491AbTLOCyY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 21:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbTLOCyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 21:54:24 -0500
Received: from mail-04.iinet.net.au ([203.59.3.36]:35769 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262491AbTLOCyX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 21:54:23 -0500
Message-ID: <3FDD205A.6040807@cyberone.com.au>
Date: Mon, 15 Dec 2003 13:45:46 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Guillaume Foliard <guifo@wanadoo.fr>
CC: linux-kernel@vger.kernel.org, george anzinger <george@mvista.com>
Subject: Re: Scheduler degradation since 2.5.66
References: <200312142048.51579.guifo@wanadoo.fr>
In-Reply-To: <200312142048.51579.guifo@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Guillaume Foliard wrote:

>Hello,
>
>I have been playing with kernel 2.5/2.6 for around 6 months now. I was quite 
>pleased with 2.5.65 to see that the soft real-time behaviour was much better 
>than 2.4.x. Since then I tried most of the 2.5/2.6 versions. But recently 
>someone warned me about some degradations with 2.6.0-test6. To show the 
>degradation since 2.5.66 I have run a simple test program on most of the 
>versions. This simple program is measuring the time it takes to a process to 
>be woken up after a call to nanosleep.
>As the results are plots, please visit this small website for more 
>information : http://perso.wanadoo.fr/kayakgabon/linux
>I'm ready to perform more tests or provide more information if necessary.
>

This isn't a problem with the scheduler, its a problem with sys_nanosleep.
jiffies_to_timespec( {1000000us} ) returns 2 jiffies, and nanosleep adds
an extra one and asks to sleep for that long (ie. 3ms).

The more erratic timings could be due to interactivity changes as you say,
but you probably aren't running without RT priority


