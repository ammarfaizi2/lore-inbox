Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261389AbTCTQvh>; Thu, 20 Mar 2003 11:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261460AbTCTQvh>; Thu, 20 Mar 2003 11:51:37 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:61425 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S261389AbTCTQva>; Thu, 20 Mar 2003 11:51:30 -0500
Message-ID: <3E79F405.9030705@nortelnetworks.com>
Date: Thu, 20 Mar 2003 12:01:57 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Cc: Stuart MacDonald <stuartm@connecttech.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Non-__init functions calling __init functions
References: <200303201632.h2KGW8Vu002620@green.mif.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrzej Krzysztofowicz wrote:

> Not always possible.
> 
> __init A() {
> ...
> }
> 
> __exit B() {
> ...
> }
> 
> C() {
> ...
> A();
> ...
> #ifdef MODULE
> B();
> #endif
> ...
> }
> 
> C cannot be marked __init for #define MODULE case. Even if it is called only
> by some __init code. I can imagine other similar situations.

I thought that in the case of modules, __init is a noop?  At least, that's what 
this page says

http://www.netfilter.org/unreliable-guides/kernel-hacking/routines-init.html

So if MODULE is defined, it doesn't matter if C is labelled as __init or not, 
and if it is not defined, it *should* be labelled as __init since it is itself 
calling __init code.

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

