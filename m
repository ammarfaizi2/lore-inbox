Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263736AbUIINbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263736AbUIINbq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 09:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263769AbUIINbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 09:31:45 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:31662 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263736AbUIINbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 09:31:44 -0400
Message-ID: <41405773.3090403@yahoo.com.au>
Date: Thu, 09 Sep 2004 23:15:31 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Andrew Morton <akpm@osdl.org>, Andrey Savochkin <saw@saw.sw.com.sg>,
       linux-kernel@vger.kernel.org
Subject: Re: Q about pagecache data never written to disk
References: <20040905120147.A9202@castle.nmd.msu.ru> <20040905035233.6a6b5823.akpm@osdl.org> <20040905154336.B9202@castle.nmd.msu.ru> <20040905140040.58a5fcdc.akpm@osdl.org> <20040909123957.GB1065@elf.ucw.cz>
In-Reply-To: <20040909123957.GB1065@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>>No, read() will see the modified pagecache data immediately, apart from CPU
>>cache coherency effects.
> 
> 
> Is not this quite a big security hole?
> 
> cat evil_data > /tmp/sign.me   [Okay, evil_data probably have to
> 				contain lot of zeroes?]
> sync, fill disk or wait for someone to fill disk completely
> 
> attempt to write good_data to /tmp/sign.me using mmap
> 
> "Hey, root, see what /tmp/sign.me contains, can you make it suid?"
> 
> root reads /tmp/sign.me, and sees it is good.
> 
> root does chown root.root /tmp/sign.me; chmod 4755 /tmp/sign.me
> 
> kernel realizes that there's not enough disk space, and discard
> changes, therefore /tmp/sign.me reverts to previous, evil, content.
> 

root would have to make that change while user has the file open,
and should welcome the subsequent unleashing of evil content as a
valuable lesson.
