Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263691AbTJ1Ams (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 19:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263791AbTJ1Ams
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 19:42:48 -0500
Received: from [213.173.228.18] ([213.173.228.18]:13841 "HELO mail.tpack.net")
	by vger.kernel.org with SMTP id S263691AbTJ1Amr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 19:42:47 -0500
Message-ID: <3F9DBB7F.7030309@tpack.net>
Date: Tue, 28 Oct 2003 01:42:39 +0100
From: Tommy Christensen <tommy.christensen@tpack.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kuznet@ms2.inr.ac.ru
CC: Linus Torvalds <torvalds@osdl.org>, akpm@osdl.org, Andries.Brouwer@cwi.nl,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com,
       "David S. Miller" <davem@redhat.com>
Subject: Re: Linux 2.6.0-test9
References: <200310271936.WAA07348@yakov.inr.ac.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kuznet@ms2.inr.ac.ru wrote:
> Hello!
> 
> 
>>And Alexey apparently tried to do the "FIXME" part, but without thinking 
>>about the SIGURG part.
> 
> 
> Actually, it was thought a lot for several linux-2.x. :-)
> 
> 
> 
>>We _need_ to stop at urgent data and we _should_ return -EINTR, and let
>>the SIGURG handler do the URG read. Otherwise we'll lose urgent data (or
>>we'll just read it inline without realizing that it was urgent data).
> 
> 
> The patch was expected not to break this property. Alas, something
> is overlooked yet. I still do not understand what exactly is broken,
> I feel I have to find some rlogin to experiment in vivo.

Hi Alexey

I think the patch breaks things because it consumes (or rather skips)
the urgent data ( in the code after the label found_ok_skb: ).

Since this happens before the SIGURG handler is run, it won't find
any urgent data.

What do you think?

The patch by Linus seems to be fine though.

-Tommy

