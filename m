Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266809AbTAPCqO>; Wed, 15 Jan 2003 21:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266952AbTAPCqO>; Wed, 15 Jan 2003 21:46:14 -0500
Received: from almesberger.net ([63.105.73.239]:3090 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S266809AbTAPCqN>; Wed, 15 Jan 2003 21:46:13 -0500
Date: Wed, 15 Jan 2003 23:55:01 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel@vger.kernel.org,
       adam@yggdrasil.com
Subject: Re: [PATCH] Proposed module init race fix.
Message-ID: <20030115235501.B1589@almesberger.net>
References: <D4E37953801@vcnet.vc.cvut.cz> <20030116015535.355A22C133@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030116015535.355A22C133@lists.samba.org>; from rusty@rustcorp.com.au on Thu, Jan 16, 2003 at 12:48:57PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> And see remove_proc_entry, or notifier_chain_unregister for
> counterexamples.  No doubt there are others.

Perhaps some convenient include file should contain something like
this:

#ifdef CONFIG_DEBUG_KERNEL
#define whistleblower() \
  printk(KERN_ERR "this interface may call back after deregistration\n");
#else
#define whistleblower() /* no failure is silent in Oopsland */
#endif

? ;-)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
