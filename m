Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313800AbSDIAJW>; Mon, 8 Apr 2002 20:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313801AbSDIAJV>; Mon, 8 Apr 2002 20:09:21 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:19973 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S313800AbSDIAJU>; Mon, 8 Apr 2002 20:09:20 -0400
Message-ID: <3CB222AB.64005F3B@zip.com.au>
Date: Mon, 08 Apr 2002 16:07:23 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
CC: linux-kernel@vger.kernel.org, Tony.P.Lee@nokia.com, kessler@us.ibm.com,
        alan@lxorguk.ukuu.org.uk, Dave Jones <davej@suse.de>
Subject: Re: Event logging vs enhancing printk
In-Reply-To: <3CB21BFC.B3BFDACF@zip.com.au> <91260000.1018310069@flay>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" wrote:
> 
> ...
> for (i=0; i<10; i++) { printk ("%d ", i); } printk("\n");
> 
> and CPU 1 does "printk("hello\n");" then instead of getting either
> 
> 0 1 2 3 4 5 6 7 8 9
> hello
> 
> or
> 
> hello
> 0 1 2 3 4 5 6 7 8 9
> 
> either of which would be fine, we may get
> 
> 0 1 2 3 hello
> 4 5 6 7 8 9
> 
> which I don't think is fine - obviously the example is somewhat
> trite, but with the real instances of things that build output for one
> line through multiple calls to printk, you can get unreadable garbage,
> if I read the code correctly ?

Ah.  Yes, that will definitely happen.  We only have atomicity
at the level of a single printk call.

It would be feasible to introduce additional locking so that
multiple printks can be made atomic.  This should be resisted
though - printk needs to be really robust, and needs to have
a good chance of working even when the machine is having hysterics.
It's already rather complex.

For the rare cases which you cite we can use a local staging
buffer and sprintf, or just live with it, I suspect.

-
