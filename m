Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129905AbRAQVwh>; Wed, 17 Jan 2001 16:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130139AbRAQVw1>; Wed, 17 Jan 2001 16:52:27 -0500
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:27779 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S129905AbRAQVwR>; Wed, 17 Jan 2001 16:52:17 -0500
Date: Wed, 17 Jan 2001 13:51:31 -0800
From: Dan Kegel <dank@alumni.caltech.edu>
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
To: dean-list-linux-kernel@arctic.org, linux-kernel@vger.kernel.org,
        Tony Finch <dot@dotat.at>
Reply-to: dank@alumni.caltech.edu
Message-id: <3A6613E3.218F588C@alumni.caltech.edu>
MIME-version: 1.0
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dean Gaudet wrote:
> consider the case where you're responding to a pair of pipelined HTTP/1.1 
> requests. with the HPUX and BSD sendfile() APIs you end up forcing a 
> packet boundary between the two responses. this is likely to result in 
> one small packet on the wire after each response. 
> 
> with the linux TCP_CORK API you only get one trailing small packet

Tony Finch tells me that BSD also supports TCP_CORK; in fact, it had it first.
He wrote:
> BSDs that include T/TCP (pretty much all of them since 1995) have an
> option called TCP_NOPUSH which is equivalent to Linux's TCP_CORK. A
> pity the Linux people didn't know about it when they implemented their
> version.
>  
> #if defined(TCP_CORK) && !defined(TCP_NOPUSH)
> #define TCP_NOPUSH TCP_CORK
> #endif

Can anyone verify it resolves the problem Dean pointed out?

Now, Linus, does that make you hate BSD less? :-)
- Dan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
