Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbWAPXAh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbWAPXAh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 18:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWAPXAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 18:00:37 -0500
Received: from mail.kroah.org ([69.55.234.183]:37788 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751253AbWAPXAg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 18:00:36 -0500
Date: Mon, 16 Jan 2006 14:51:10 -0800
From: Greg KH <greg@kroah.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm4: sem2mutex problem in USB OHCI
Message-ID: <20060116225110.GA31296@kroah.com>
References: <200601150058.58518.rjw@sisk.pl> <20060114160526.228da734.akpm@osdl.org> <20060115043826.GB23968@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060115043826.GB23968@elte.hu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 15, 2006 at 05:38:26AM +0100, Ingo Molnar wrote:
> 
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > >  Badness in __mutex_trylock_slowpath at kernel/mutex.c:281
> > > 
> > >  Call Trace: <IRQ> <ffffffff80148d8d>{mutex_trylock+141}
> > >         <ffffffff880abaf0>{:ohci_hcd:ohci_hub_status_data+480}
> > >         <ffffffff802d25d0>{rh_timer_func+0} <ffffffff802d24c3>{usb_hcd_poll_rh_status+67}
> 
> > err, taking a mutex from softirq context.
> 
> hm. For now, the patch below undoes the struct device ->mutex 
> conversion.

I've dropped the whole driver mutex patch from my tree till stuff like
this gets worked out.

thanks,

greg k-h
