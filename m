Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263375AbTFDO5C (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 10:57:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263394AbTFDO5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 10:57:01 -0400
Received: from wmail.atlantic.net ([209.208.0.84]:62135 "HELO
	wmail.atlantic.net") by vger.kernel.org with SMTP id S263375AbTFDO46
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 10:56:58 -0400
Message-ID: <3EDE0E85.7090601@techsource.com>
Date: Wed, 04 Jun 2003 11:21:41 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: "P. Benie" <pjb1008@eng.cam.ac.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Coding standards.  (Was: Re: [PATCH] [2.5] Non-blocking write can
 block)
References: <Pine.HPX.4.33L.0306040144400.8930-100000@punch.eng.cam.ac.uk> <20030604065336.A7755@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Christoph Hellwig wrote:
> On Wed, Jun 04, 2003 at 01:58:02AM +0100, P. Benie wrote:
> 
>>-	if (down_interruptible(&tty->atomic_write)) {
>>-		return -ERESTARTSYS;
>>+	if (file->f_flags & O_NONBLOCK) {
>>+		if (down_trylock(&tty->atomic_write))
>>+			return -EAGAIN;
>>+	}
>>+	else {
> 
> 
> The else should be on the same line as the closing brace, else
> the patch looks fine.

I am in general agreement with those who feel we should have a common 
standard for code formatting.  There are particular places where it's 
VERY important to maximize consistency and readability, such as function 
headers.

But when do standards turn into nitpicks?

I personally always write else as you suggest, "} else {", but the way 
the other fellow did it does not in any way hurt readability for me. 
Yes, it does irritate me sometimes when people put the braces and else 
on three different lines, but mostly because it reduces the amount of 
code I can see at one time.  But even then, it doesn't make it any less 
readable to me.

I can see patches getting rejected because they violate function header 
standards.  That would make sense to me.  But if the above patch were to 
be rejected on the basis of the "else", I would be hard pressed to see 
that as a valid justification.

Perhaps it would be good to have an explanation for the relative 
importance of placing braces and else on the same line as compared to 
other formatting standards.

