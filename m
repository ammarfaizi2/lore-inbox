Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292903AbSCDUtf>; Mon, 4 Mar 2002 15:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292902AbSCDUsk>; Mon, 4 Mar 2002 15:48:40 -0500
Received: from web12305.mail.yahoo.com ([216.136.173.103]:58634 "HELO
	web12305.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S292901AbSCDUsd>; Mon, 4 Mar 2002 15:48:33 -0500
Message-ID: <20020304204832.79585.qmail@web12305.mail.yahoo.com>
Date: Mon, 4 Mar 2002 12:48:32 -0800 (PST)
From: Raghu Angadi <raghuangadi@yahoo.com>
Subject: Re: Fw: memory corruption in tcp bind hash buckets on SMP?
To: kuznet@ms2.inr.ac.ru
Cc: davem@redhat.com, raghuangadi@yahoo.com, linux-kernel@vger.kernel.org
In-Reply-To: <200203011907.WAA08216@ms2.inr.ac.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We have been load testing the kernel with this patch (reverse the insertion
order in __tcp_tw_hashdance(). It seems to work fine till now.

--- kuznet@ms2.inr.ac.ru wrote:
> Hello!
> 
> The mess happens while concurrent remove and insert: insert adds
> socket to established table and then to binding table. Racing remove
> removes it from established table, but cannot satisfy invariant
> because socket is still not in binding table. (This place should
> be asserted with a BUG() for future)

I think we should just remove the conditional for tw->tb in
tcp_timewait_kill(). That way its clear to the reader that we expect tb to be
set by this time. If it is NULL the code will anyway oops there.. we dont
need BUG().

Raghu.
 
> The second statement, which completes the proof: removing is possible
> only after the socket is added to established hash table (it is evident,
> until this time bucket is private to creator).
> 
> Alexey


__________________________________________________
Do You Yahoo!?
Yahoo! Sports - sign up for Fantasy Baseball
http://sports.yahoo.com
