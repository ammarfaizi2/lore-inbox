Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932093AbVJMRFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbVJMRFu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 13:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932111AbVJMRFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 13:05:50 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:38122 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932093AbVJMRFu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 13:05:50 -0400
Message-ID: <434E96FA.48CBB6E7@tv-sign.ru>
Date: Thu, 13 Oct 2005 21:18:50 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Michael Kerrisk <mtk-lkml@gmx.net>
Cc: dan@debian.org, roland@redhat.com, mingo@elte.hu,
       linux-kernel@vger.kernel.org, michael.kerrisk@gmx.net
Subject: Re: Process with many NPTL threads terminates slowly on core dump signal
References: <434D48FA.FD0439AA@tv-sign.ru> <18436.1129192898@www29.gmx.net>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Kerrisk wrote:
> 
> Thanks.  I've applied it to 2.6.14-rc4: this patch does fix the
> specific behaviour that my program demonstrates.
> 
> What remains to be solved?

The problem remains that all threads spin with TIF_SIGPENDING flag
after the coredumping thread sets SIGNAL_GROUP_EXIT in do_coredump()
and before it kills them in zap_threads(). If one of these threads is
SCHED_FIFO we have a deadlock. Also, the coredumping thread could be
preempted, placed in ->expired array ...

Oleg.
