Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277705AbRJOQSZ>; Mon, 15 Oct 2001 12:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277656AbRJOQSP>; Mon, 15 Oct 2001 12:18:15 -0400
Received: from gap.cco.caltech.edu ([131.215.139.43]:58000 "EHLO
	gap.cco.caltech.edu") by vger.kernel.org with ESMTP
	id <S277705AbRJOQSN>; Mon, 15 Oct 2001 12:18:13 -0400
Message-ID: <3BCB08B2.5060207@interactivesi.com>
Date: Mon, 15 Oct 2001 11:02:58 -0500
From: Timur Tabi <ttabi@interactivesi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: mlist-linux-kernel@nntp-server.caltech.edu
Subject: Re: 
In-Reply-To: <20011015062505.32762.qmail@mailweb33.rediffmail.com> <3BCA889B.6000504@blue-labs.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Ford wrote:

> That should throw a segmentation fault, in the kernel an OOPS,  in this 
> statement the code is trying to dereference a NULL pointer and store a 
> value at 0x0.


I much smarter way to do this would be to use this code:

static inline void int3(void) { __asm__ __volatile__ (".byte 0xCC\n"); };

Granted, it's x86-specific, but it works better, since gdb will halt the code 
right at that spot rather than inside some trap hander.  And it's just more 
elegant.

