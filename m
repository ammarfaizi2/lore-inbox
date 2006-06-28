Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932824AbWF1PTX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932824AbWF1PTX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 11:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932830AbWF1PTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 11:19:23 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:61378 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932824AbWF1PTW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 11:19:22 -0400
Date: Wed, 28 Jun 2006 23:41:21 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] srcu: RCU variant permitting read-side blocking
Message-ID: <20060628194121.GA247@oleg>
References: <20060627211358.GA484@oleg> <20060627185945.GD1286@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060627185945.GD1286@us.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/27, Paul E. McKenney wrote:
>
> On Wed, Jun 28, 2006 at 01:13:58AM +0400, Oleg Nesterov wrote:
> > 
> > Also, I can't understand the purpose of 2-nd synchronize_sched() in
> > synchronize_srcu().
> 
> This one handles the srcu_read_unlock() analog of the situation you
> are worried about above.  The reader does not have memory barriers in
> srcu_read_unlock(), so an access to the data structure might get
> reordered to follow the decrement of .c[0] -- which would get messed
> up by the following kfree().

Aha, I see.

The last question. The 'srcu-2' you posted today does synchronize_srcu_flip()
twice. You did it this way because srcu is optimized for readers, otherwise we
could just add smp_rmb() into srcu_read_lock() - this should solve the problem
as well.

Is my understanding correct?

Thanks!

Oleg.

