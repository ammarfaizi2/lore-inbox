Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932694AbWF1GzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932694AbWF1GzQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 02:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932747AbWF1GzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 02:55:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44519 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932694AbWF1GzO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 02:55:14 -0400
Date: Tue, 27 Jun 2006 23:55:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: nanhai.zou@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [Patch] jbd commit code deadloop when installing Linux
Message-Id: <20060627235500.8c2c290e.akpm@osdl.org>
In-Reply-To: <20060628063859.GA9726@elte.hu>
References: <1151470123.6052.17.camel@linux-znh>
	<20060627234005.dda13686.akpm@osdl.org>
	<20060628063859.GA9726@elte.hu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2006 08:38:59 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > > We see system hang in ext3 jbd code
> > > when Linux install program anaconda copying 
> > > packages. 
> > > 
> > > That is because anaconda is invoked from linuxrc 
> > > in initrd when system_state is still SYSTEM_BOOTING.
> 
> [ argh ...! ]

That's what I thought  ;)

> > > Thus the cond_resched checks in  journal_commit_transaction 
> > > will always return 1 without actually schedule, 
> > > then the system fall into deadloop.
> > 
> > That's a bug in cond_resched().
> > 
> > Something like this..
> 
> Acked-by: Ingo Molnar <mingo@elte.hu>
> 

Thanks.  Zou, it'd be great if you could test this in your setup, please. 
I've tagged it as 2.6.17.x material.
