Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262226AbUCEFjz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 00:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262229AbUCEFjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 00:39:55 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:65174 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262226AbUCEFjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 00:39:53 -0500
Message-ID: <404812A2.70207@nortelnetworks.com>
Date: Fri, 05 Mar 2004 00:39:46 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Tom Rini <trini@kernel.crashing.org>
Subject: Re: problem with cache flush routine for G5?
References: <40479A50.9090605@nortelnetworks.com>	 <1078444268.5698.27.camel@gaston>  <4047CBB3.9050608@nortelnetworks.com> <1078452637.5700.45.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:

> In fact, none of the cache flush code is
> relying on supervisor mode, you don't need to add a syscall for
> that, just copy the code you need in userland.

That's useful information.

> That's wrong. You should flush the cache over the range
> where you need it flushed. 

Yeah, I know.  I'm not sure why they want this.

 > Also, there are very few reasons
> why one would want to flush the dcache, so it would be interesting
> to know what you are really trying to do.

I'll look into it further and see what I can find out.

Assuming that I really did want to flush the whole cache, how would I go 
about doing that from userspace?  Do it like the loop in 
arch/ppc/boot/common/util.S?  How would this interact with virtual 
addresses?  Would I need to mmap an appropriately sized area of kernel 
memory to get contiguous memory?  The app is running as root, so 
permissions are not an issue.

Thanks for your help,

Chris




-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

