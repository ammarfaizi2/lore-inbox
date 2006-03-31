Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751110AbWCaBdw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbWCaBdw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 20:33:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbWCaBdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 20:33:52 -0500
Received: from science.horizon.com ([192.35.100.1]:55875 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751110AbWCaBdv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 20:33:51 -0500
Date: 30 Mar 2006 20:33:46 -0500
Message-ID: <20060331013346.913.qmail@science.horizon.com>
From: linux@horizon.com
To: clameter@sgi.com
Subject: Re: Synchronizing Bit operations V2
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The following patchset implements the ability to specify a
> synchronization mode for bit operations.
>
> I.e. instead of set_bit(x,y) we can do set_bit(x,y, mode).
> 
> The following modes are supported:

Yuck.

The only conceivable reason for passing the mode as a separate parameter is
- To change the mode dynamically at run time.
- To share common code when the sequence is long and mostly shared
  between the various modes (as in open(2) or ll_rw_block()).

I sincerely hope neither of those apply in this case.

On the downside, it's more typing and uglier than a series of

frob_bit_nonatomic()
	(probably temporarily or permanently aliased to frob_bit())
frob_bit_atomic()
frob_bit_acquire()
frob_bit_release()
frob_bit_barrier()

functions, and those also prevent you from doing something silly like
frob_bit(x, y, O_DIRECT).  Also, the MODE_ prefix might be wanted by
something else.
