Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964891AbWBPUCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964891AbWBPUCZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 15:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964894AbWBPUCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 15:02:25 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:39148 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S964892AbWBPUCY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 15:02:24 -0500
Message-ID: <43F4EC88.D8B2DEE5@tv-sign.ru>
Date: Fri, 17 Feb 2006 00:20:08 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: paulmck@us.ibm.com
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Roland McGrath <roland@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/2] fix kill_proc_info() vs fork() theoretical race
References: <43E77D3C.C967A275@tv-sign.ru> <20060214223214.GG1400@us.ibm.com> <43F3352C.E2D8F998@tv-sign.ru> <43F37D56.2D7AB32F@tv-sign.ru> <20060216192617.GF1296@us.ibm.com> <43F4E6EC.3B9F91C4@tv-sign.ru> <20060216195341.GG1296@us.ibm.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul E. McKenney" wrote:
> 
> The other thing to think through is tkill on a thread/process while it
> is being created.  I believe that this is OK, since thread-specific
> kill must target a specific thread, so does not do the traversal.
> 

Also, tkill was not converted to use rcu_read_lock yet, it still
takes tasklist_lock, so I think it is safe.

Oleg.
