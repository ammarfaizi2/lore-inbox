Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263646AbTKKSQM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 13:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263650AbTKKSQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 13:16:12 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:38345 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S263646AbTKKSQJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 13:16:09 -0500
Message-ID: <3FB1275B.1000901@colorfullife.com>
Date: Tue, 11 Nov 2003 19:15:55 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Erik Jacobson <erikj@subway.americas.sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6 /proc/interrupts fails on systems with many CPUs
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik wrote:

>	/* don't ask for more than the kmalloc() max size, currently 128 KB */
> 	if (size > 128 * 1024)
> 		size = 128 * 1024;
>-	buf = kmalloc(size, GFP_KERNEL);
>+	buf = __vmalloc(size, GFP_KERNEL, PAGE_KERNEL);
>  
>
kmalloc needs a contiguous memory block. Thus after a long runtime, 
large kmalloc calls can fail due to fragmentation. I'd prefer if you 
switch to vmalloc after 2*PAGE_SIZE.

Or switch to a line based seq file iterator, then you wouldn't need the 
huge buffer.
--
    Manfred

