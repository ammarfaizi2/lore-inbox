Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273923AbRIRVDw>; Tue, 18 Sep 2001 17:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273925AbRIRVDm>; Tue, 18 Sep 2001 17:03:42 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:52749 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S273923AbRIRVDa>; Tue, 18 Sep 2001 17:03:30 -0400
Date: Tue, 18 Sep 2001 16:39:34 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        akpm@zip.com.au
Subject: Re: 2.4.10pre11 vm rewrite fixes for mainline inclusion and testing
In-Reply-To: <Pine.LNX.4.21.0109181627340.7836-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0109181636200.7836-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 18 Sep 2001, Marcelo Tosatti wrote:

> 
> 
> On Tue, 18 Sep 2001, Andrea Arcangeli wrote:
> 
> (testing now)

Well, unfortunately:

Sep 18 17:59:01 matrix PAM_pwdb[842]: (sshd) session opened for user
marcelo by (uid=0)
Sep 18 17:59:27 matrix kernel: __alloc_pages: 0-order allocation failed
(gfp=0x20/0) from c012c5fe
Sep 18 17:59:28 matrix sshd[860]: Accepted password for marcelo from
10.0.17.22 port 1020
Sep 18 17:59:29 matrix PAM_pwdb[860]: (sshd) session opened for user
marcelo by (uid=0)
Sep 18 17:59:42 matrix sshd[873]: Accepted password for marcelo from
10.0.17.22 port 1021
Sep 18 17:59:43 matrix PAM_pwdb[873]: (sshd) session opened for user
marcelo by (uid=0)
Sep 18 17:59:48 matrix PAM_pwdb[875]: (su) session opened for user root by
marcelo(uid=719)
Sep 18 17:59:55 matrix kernel: __alloc_pages: 0-order allocation failed
(gfp=0x20/0) from c012c5fe


(2GB RAM, 4way, 4 setiathome's, 2 fillmem 1GB each)

I really think we need the "fail: loop again: try_to_free_pages()" logic,
Andrea: If there is not enough memory we HAVE to block in the page
reclaiming work.

I'll try do work on some logic like that in 1h or so... 

