Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262666AbRE3XBh>; Wed, 30 May 2001 19:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262880AbRE3XB1>; Wed, 30 May 2001 19:01:27 -0400
Received: from csl.Stanford.EDU ([171.64.66.149]:4074 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S262666AbRE3XBK>;
	Wed, 30 May 2001 19:01:10 -0400
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200105302301.QAA08564@csl.Stanford.EDU>
Subject: Re: [CHECKER] 2.4.5-ac4 non-init functions calling init functions
To: dwmw2@infradead.org (David Woodhouse)
Date: Wed, 30 May 2001 16:01:03 -0700 (PDT)
Cc: linux-kernel@vger.kernel.org, mc@CS.Stanford.EDU
In-Reply-To: <26484.991258403@redhat.com> from "David Woodhouse" at May 30, 2001 10:33:23 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > drivers/mtd/docprobe.c:195:DoC_Probe: ERROR:INIT: non-init fn
> > 'DoC_Probe' calling init fn 'doccheck'
> 
> Strictly speaking, not actually a bug. DoC_Probe() itself is only ever 
> called from __init code. But it's probably not worth trying to make the 
> checker notice that situation - I've fixed it anyway by making DoC_Probe() 
> __init too, which saves a bit more memory. Thanks.

It's a space/performance bug, though, right?  From the original mail:

        1. The best case: the caller should actually be an __init function
        as well.  This is a performance bug since it won't be freed.
