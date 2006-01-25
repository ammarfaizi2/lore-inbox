Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbWAYQBb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWAYQBb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 11:01:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWAYQBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 11:01:31 -0500
Received: from mail.gmx.de ([213.165.64.21]:35245 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750735AbWAYQBa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 11:01:30 -0500
X-Authenticated: #428038
Message-ID: <43D7A0D2.3000906@gmx.de>
Date: Wed, 25 Jan 2006 17:01:22 +0100
From: Matthias Andree <matthias.andree@gmx.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
CC: tytso@mit.edu, arjan@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Rationale for RLIMIT_MEMLOCK?
References: <20060123165415.GA32178@merlin.emma.line.org> <1138035602.2977.54.camel@laptopd505.fenrus.org> <20060123180106.GA4879@merlin.emma.line.org> <1138039993.2977.62.camel@laptopd505.fenrus.org> <20060123185549.GA15985@merlin.emma.line.org> <43D530CC.nailC4Y11KE7A@burner> <20060123203010.GB1820@merlin.emma.line.org> <1138092761.2977.32.camel@laptopd505.fenrus.org> <43D5EEA2.nailCE7111GPO@burner> <1138094141.2977.34.camel@laptopd505.fenrus.org> <20060124212843.GA15543@thunk.org> <43D79A32.nailD78B9E1B5@burner>
In-Reply-To: <43D79A32.nailD78B9E1B5@burner>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling wrote:

> RLIMIT_MEMLOCK did first apear in BSD-4.4 around 1994.
> The iplementation is incomplete since then and partially disabled (size check 
> for mmap() in the kernel) on FreeBSD as it has been 1994 on BSD-4.4
> 
> FreeBSD currently uses a default value of RLIMIT_INFINITY for users.

And while it does that (or in fact, rather not distinguish between root and
unprivileged users), mlock() and mlockall() are privileged operations on
FreeBSD.

> I could add this piece of code to the euid == 0 part of cdrecord:
> 
> LOCAL void 
> raise_memlock() 
> { 
> #ifdef  RLIMIT_MEMLOCK 
>         struct rlimit rlim; 
>  
>         rlim.rlim_cur = rlim.rlim_max = RLIM_INFINITY; 
>  
>         if (setrlimit(RLIMIT_MEMLOCK, &rlim) < 0) 
>                 errmsg("Warning: Cannot raise RLIMIT_MEMLOCK limits."); 
> #endif  /* RLIMIT_NOFILE */ 
> } 

Except that your new #endif comment is wrong, that is exactly what I
suggested and what I've tried and found working.
