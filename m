Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313575AbSDICPs>; Mon, 8 Apr 2002 22:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313596AbSDICPr>; Mon, 8 Apr 2002 22:15:47 -0400
Received: from mail3.aracnet.com ([216.99.193.38]:33700 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S313575AbSDICPq>; Mon, 8 Apr 2002 22:15:46 -0400
Date: Mon, 08 Apr 2002 19:14:44 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andrew Morton <akpm@zip.com.au>
cc: linux-kernel@vger.kernel.org, Tony.P.Lee@nokia.com, kessler@us.ibm.com,
        alan@lxorguk.ukuu.org.uk, Dave Jones <davej@suse.de>
Subject: Re: Event logging vs enhancing printk
Message-ID: <1934841354.1018293283@[10.10.2.3]>
In-Reply-To: <3CB222AB.64005F3B@zip.com.au>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ah.  Yes, that will definitely happen.  We only have atomicity
> at the level of a single printk call.
> 
> It would be feasible to introduce additional locking so that
> multiple printks can be made atomic.  This should be resisted
> though - printk needs to be really robust, and needs to have
> a good chance of working even when the machine is having hysterics.
> It's already rather complex.
> 
> For the rare cases which you cite we can use a local staging
> buffer and sprintf, or just live with it, I suspect.

Right - what I'm proposing would be a generic equivalent of the
local staging buffer and sprintf - basically just a little wrapper
that does this for you, keeping a per task buffer somewhere.

The reason I want to do it like this, rather than what you suggest,
is that there are over 5000 of these "rare cases" of a printk without
a newline, according to the IBM RAS group's code search ;-) I don't
fancy changing that for 5000 instances (obviously some of those are
grouped together, but the count is definitely non-trivial). I'd 
attach the report they sent me, but it's 657K long ;-) 

M.

