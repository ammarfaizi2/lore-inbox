Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751451AbWE2WuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbWE2WuK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 18:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbWE2WuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 18:50:10 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:12231 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1751451AbWE2WuI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 18:50:08 -0400
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@ocs.com.au>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 33/61] lock validator: disable NMI watchdog if CONFIG_LOCKDEP 
In-reply-to: Your message of "Mon, 29 May 2006 23:25:50 +0200."
             <20060529212550.GG3155@elte.hu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 30 May 2006 08:49:53 +1000
Message-ID: <14402.1148942993@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar (on Mon, 29 May 2006 23:25:50 +0200) wrote:
>From: Ingo Molnar <mingo@elte.hu>
>
>The NMI watchdog uses spinlocks (notifier chains, etc.),
>so it's not lockdep-safe at the moment.

Fixed in 2.6.17-rc1.  notify_die() uses atomic_notifier_call_chain()
which uses RCU, not spinlocks.

