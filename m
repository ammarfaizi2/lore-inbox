Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264126AbUARWEI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 17:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264141AbUARWEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 17:04:08 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:6060 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S264126AbUARWEG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 17:04:06 -0500
Message-ID: <400B02CE.5060907@colorfullife.com>
Date: Sun, 18 Jan 2004 23:03:58 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: caszonyi@rdslink.ro
CC: linux-kernel@vger.kernel.org
Subject: Re: Slab coruption and oops with 2.6.1-mm4
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Calin wrote:

>Then usual oops but *before that* something which hasn't happened before.
>Slab corruption: start=c57c2000, len=4096
>000: 6e 72 6d 71 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
>  
>
Is that reproducable? The selftest code in slab noticed a change in a 
buffer that is not in use: All values should be 0x6b, but the first 4 
bytes are different.
Could you try to boot with CONFIG_DEBUG_PAGEALLOC enabled? Perhaps that 
identifies who corrupts the page. Unfortunately it can't detect DMA writes.

>------------ kernel BUG at include/linux/mm.h:275!
>
put_page_testzero noticed that the page count was already 0. It seems 
that someone uses memory that was already freed.

--
    Manfred



