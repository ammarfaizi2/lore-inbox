Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262645AbUCJPGa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 10:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262634AbUCJPGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 10:06:30 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:51171 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S262645AbUCJPG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 10:06:28 -0500
Message-ID: <404F2EA1.8030702@softhome.net>
Date: Wed, 10 Mar 2004 16:05:05 +0100
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040116
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Jaco Kroon <jkroon@cs.up.ac.za>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: stack allocation and gcc
References: <404F09C6.7030200@softhome.net> <404F104C.2030206@cs.up.ac.za> <Pine.LNX.4.53.0403100806570.15421@chaos>
In-Reply-To: <Pine.LNX.4.53.0403100806570.15421@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> The caller expects that the space for the second set of local
> variables in the second program unit is not allocated until the
> program unit is entered.
> 
> I don't know why he would expect this behavior. Certainly

    It was my first thought actually - when I have started typeing in 
e-mail.

    When I have reached half e-mail - I have understood that this is 
simple performance consideration - stack space is allocated once.

    I have tryed to convert my e-mail to another issue - but seems I did 
it not good enough :-)

    But then I realized that my thinking was wrong - I'm using variables 
in different never overlapping contextes. But space allocated for 
everyone. "if (..) { int i; }; if (...) { int i; }" will result not in 
sizeof(int) stack space allocated - but in sizeof(int)*2.

    It seems that gcc check size required by all top level contextes in 
function - it checks for "if { int a[16] } else { int a[16] }" - space 
allocated correctly.
    But 'if () { int a[16]; }; if () { int a[16] };' seems to break 
something, and sum of the sizes for both if()'s spaces finishes 
allocated on stack. And this was the case with macro in my module.

    I doubt I can write competent report/query to gcc mail list - 
probably it is worth to ask there.

-- 
Ihar 'Philips' Filipau  / with best regards from Saarbruecken.
--                                                           _ _ _
  "... and for $64000 question, could you get yourself       |_|*|_|
    vaguely familiar with the notion of on-topic posting?"   |_|_|*|
                                 -- Al Viro @ LKML           |*|*|*|
