Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291878AbSBHWSI>; Fri, 8 Feb 2002 17:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291880AbSBHWSB>; Fri, 8 Feb 2002 17:18:01 -0500
Received: from illiter.at ([63.113.167.61]:27357 "EHLO mail.and.org")
	by vger.kernel.org with ESMTP id <S291878AbSBHWRw>;
	Fri, 8 Feb 2002 17:17:52 -0500
To: "Darren Smith" <data@barrysworld.com>
Cc: "'Aaron Sethman'" <androsyn@ratbox.org>,
        "'Andrew Morton'" <akpm@zip.com.au>, "'Dan Kegel'" <dank@kegel.com>,
        "'Vincent Sweeney'" <v.sweeney@barrysworld.com>,
        <linux-kernel@vger.kernel.org>, <coder-com@undernet.org>,
        "'Kevin L. Mitchell'" <klmitch@mit.edu>
Subject: Re: [Coder-Com] Re: PROBLEM: high system usage / poor SMP network performance
In-Reply-To: <000001c1ada7$5ad5cfb0$5c5a1e3e@wilma>
From: James Antill <james@and.org>
Content-Type: text/plain; charset=US-ASCII
Date: 08 Feb 2002 17:11:38 -0500
In-Reply-To: <000001c1ada7$5ad5cfb0$5c5a1e3e@wilma>
Message-ID: <nnn0yjaajp.fsf@code.and.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Darren Smith" <data@barrysworld.com> writes:

> I mean I added a usleep() before the poll in s_bsd.c for the undernet
> 2.10.10 code.
> 
>  timeout = (IRCD_MIN(delay2, delay)) * 1000;
>  + usleep(100000); <- New Line
>  nfds = poll(poll_fds, pfd_count, timeout);
> 
> And now we're using 1/8th the cpu! With no noticeable effects.

 Note that something else you want to do is call poll() with a 0
timeout first (and if that doesn't return anything call again with the
timeout), this removes all the wait queue manipulation inside the
kernel when something is ready (most of the time).

-- 
# James Antill -- james@and.org
:0:
* ^From: .*james@and\.org
/dev/null
