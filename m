Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272292AbRHXSX5>; Fri, 24 Aug 2001 14:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272290AbRHXSXs>; Fri, 24 Aug 2001 14:23:48 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.121]:40718 "EHLO paip.net")
	by vger.kernel.org with ESMTP id <S272291AbRHXSXh>;
	Fri, 24 Aug 2001 14:23:37 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: macro conflict
Date: 24 Aug 2001 18:20:19 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <9m65t3$410$1@abraham.cs.berkeley.edu>
In-Reply-To: <14764.998658214@redhat.com> <Pine.LNX.3.95.1010824091538.32666A-100000@chaos.analogic.com>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 998677219 4128 128.32.45.153 (24 Aug 2001 18:20:19 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 24 Aug 2001 18:20:19 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
>Looking through the code, min() is most always used to find some value
>that will not overflow some buffer, i.e.,
>
>    len = min(user_request_len, sizeof(buffer));
>
>The problem is that sizeof() returns an unsigned int (size_t), and the
>user request length may be an integer. Everything works fine until
>you get to lengths with the high bit set. Then, you are in trouble.
>
>In this case, you could have a 'min()' that does:
>
>#define min(a,b) (unsigned long)(a) < (unsigned long)(b) ? (a) : (b)
>
>... where the comparison (only) is made unsigned, and you keep the
>original values. This should work, perhaps in all the current uses.

Just a small warning:  If anyone writes something like
    int len = min(user_request_len, sizeof(buffer));
    if (user_request_len > len)
        goto fail;
    memcpy(dst, user_src, len);
they can get into trouble even with your min() macro.
Ok, maybe this is crazy code that noone in their right
mind would ever write.

This is not intended as a criticism -- your approach may be
sufficient for existing code -- but it is something to watch
out for.
