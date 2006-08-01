Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932607AbWHAJ7y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932607AbWHAJ7y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 05:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932608AbWHAJ7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 05:59:54 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:10660 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S932607AbWHAJ7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 05:59:54 -0400
Subject: Re: do { } while (0) question
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Hua Zhong <hzhong@gmail.com>,
       "'Heiko Carstens'" <heiko.carstens@de.ibm.com>,
       "'Andrew Morton'" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "'Martin Schwidefsky'" <schwidefsky@de.ibm.com>
In-Reply-To: <44CF22E8.9020307@gmail.com>
References: <008e01c6b549$59e52f70$493d010a@nuitysystems.com>
	 <1154425171.32739.2.camel@taijtu>  <44CF22E8.9020307@gmail.com>
Content-Type: text/plain
Date: Tue, 01 Aug 2006 11:59:59 +0200
Message-Id: <1154426399.32739.8.camel@taijtu>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-01 at 11:45 +0159, Jiri Slaby wrote:
> Peter Zijlstra wrote:
> > On Tue, 2006-08-01 at 02:03 -0700, Hua Zhong wrote:
> >>> #if KILLER == 1
> >>> #define MACRO
> >>> #else
> >>> #define MACRO do { } while (0)
> >>> #endif
> >>>
> >>> {
> >>> 	if (some_condition)
> >>> 		MACRO
> >>>
> >>> 	if_this_is_not_called_you_loose_your_data();
> >>> }
> >>>
> >>> How do you want to define KILLER, 0 or 1? I personally choose 0.
> >> Really? Does it compile?
> > 
> > No, and that is the whole point.
> > 
> > The empty 'do {} while (0)' makes the missing semicolon a syntax error.
> 
> Bulls^WNope, it was a bad example (we don't want to break the compilation, just 
> not want to emit a warn or an err).

It was a perfectly good example why 'do {} while (0)' is useful. The
perhaps mistakenly forgotten ';' after MACRO will not stop your example
from compiling if KILLER == 1. Even worse, it will compile and do
something totally unexpected.

If however you use KILLER != 1, the while(0) will require a ';' and this
example will fail to compile.

Not compiling when you made a coding error (forgetting ';' is one of the
most common) is a great help.



