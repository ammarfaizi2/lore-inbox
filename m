Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264773AbUEERQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264773AbUEERQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 13:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264782AbUEERQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 13:16:55 -0400
Received: from niit.caravan.ru ([217.23.131.158]:7 "EHLO mail.tv-sign.ru")
	by vger.kernel.org with ESMTP id S264773AbUEERPq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 13:15:46 -0400
Message-ID: <4099218D.E1543E67@tv-sign.ru>
Date: Wed, 05 May 2004 21:17:01 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.6-rc3-mm2
References: <4098CFEB.468E6326@tv-sign.ru> <4098DB41.1A7FC5DF@tv-sign.ru> <20040505155906.GN1397@holomorphy.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

William Lee Irwin III wrote:
> 
> On Wed, May 05, 2004 at 04:17:05PM +0400, Oleg Nesterov wrote:
> > also, exclusive wakeups have no problems, and process
> > waiting in wait_on_page_writeback() won't be waken
> > by unlock_page(). it will be waken _only_ when that
> > bit will be cleared.
> 
> The object isn't passed down to the wake function at all, so it can't
> avoid falsely scheduling waiters on the wrong objects and/or bits.

I think you are wrong. __wake_up_common() calls wait_queue_t().func,
which is wake_bit_function(). It casts wait argument to wait_bit_queue,
and checks test_bit(wait_bit->bit_nr, wait_bit->flags) in _waker_
context, and wakes up wait->task _only_ if that bit is cleared,
so there is no false wakeups.

Oleg.
