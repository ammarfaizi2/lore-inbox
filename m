Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268139AbUHYRKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268139AbUHYRKb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 13:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268155AbUHYRKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 13:10:30 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:10138 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S268139AbUHYRKP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 13:10:15 -0400
Subject: Re: [PATCH] interrupt driven hvc_console as vio device
From: Ryan Arnold <rsa@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc64-dev <linuxppc64-dev@lists.linuxppc.org>,
       Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20040824214620.769e03de.akpm@osdl.org>
References: <1093394937.3402.83.camel@localhost>
	 <20040824214620.769e03de.akpm@osdl.org>
Content-Type: text/plain
Organization: IBM
Message-Id: <1093410594.3402.106.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 25 Aug 2004 00:09:54 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-24 at 23:46, Andrew Morton wrote:
> >  static void hvc_close(struct tty_struct *tty, struct file * filp)
> >   {
> > ...
> >  +		while (hp->n_outbuf) {
> >  +			spin_unlock_irqrestore(&hp->lock, flags);
> >  +			yield();
> >  +			spin_lock_irqsave(&hp->lock, flags);
> >  +		}
> 
> ick.
> 
> I suspect that if the caller of hvc_close() has realtime scheduling policy,
> this locks up.  Unless it's waiting for interrupt activity.
> 
> Really, a real sleep/wakeup would be tons better.

Paulus suggested that tty_wait_until_sent() would be most appropriate
since it actually does a sleep/wakeup.  I think I'll rearrange this
function a bit so that I won't have to drop the spin_lock and then grab
it again as well.  Thanks for the suggestion.

Ryan S. Arnold
IBM Linux Technology Center

