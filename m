Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265529AbSJSDMi>; Fri, 18 Oct 2002 23:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265535AbSJSDMh>; Fri, 18 Oct 2002 23:12:37 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:35593
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S265529AbSJSDMh>; Fri, 18 Oct 2002 23:12:37 -0400
Subject: Re: [PATCH] Priority-based real-time futexes [Try two, stupid
	Outlook wrapped it]
From: Robert Love <rml@tech9.net>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, rusty@rustcorp.com.au
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C7806CAC806@orsmsx116.jf.intel.com>
References: <A46BBDB345A7D5118EC90002A5072C7806CAC806@orsmsx116.jf.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 18 Oct 2002 23:18:47 -0400
Message-Id: <1034997530.16888.271.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-10-18 at 22:57, Perez-Gonzalez, Inaky wrote:

> I have completed the priority-based futex support; now the code
> behaves well completely, as futex_fd and poll() work as before, but
> priority based. So, tasks that are sleeping on a futex get waken up by
> priority order. This is useful for real-time locking, with most
> benefits being for the NGPT and NPTL thread libraries.

Very useful for real-time tasks...

I did not think NPTL did real-time threads, though?

>  - I don't remember if it is safe to call kmalloc with GFP_KERNEL from
>    inside an spinlock. Common sense says NO to me - just in case, in
>    the areas where I need it, I use GFP_ATOMIC. Any confirmations?

No, it is not safe as then you can sleep and consequently deadlock.

GFP_ATOMIC is the fix but be weary of how much memory you allocate and
make sure you always check for failure and have some course of action
there.

	Robert Love

