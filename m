Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262369AbUKDTTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262369AbUKDTTu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 14:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262375AbUKDTTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 14:19:40 -0500
Received: from web81309.mail.yahoo.com ([206.190.37.84]:347 "HELO
	web81309.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262317AbUKDTNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 14:13:01 -0500
Message-ID: <20041104191258.77740.qmail@web81309.mail.yahoo.com>
Date: Thu, 4 Nov 2004 11:12:58 -0800 (PST)
From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [PATCH 2.6.10-rc1 2/5] driver-model: bus_recan_devices() locking fix
To: Greg KH <greg@kroah.com>
Cc: Tejun Heo <tj@home-tj.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20041104185826.GA17756@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
> On Thu, Nov 04, 2004 at 04:02:58PM +0900, Tejun Heo wrote:
> >  df_02_bus_rescan_devcies_fix.patch
> > 
> >  bus_rescan_devices() eventually calls device_attach() and thus
> > requires write locking the corresponding bus.  The original code just
> > called bus_for_each_dev() which only read locks the bus.  This patch
> > separates __bus_for_each_dev() and __bus_for_each_drv(), which don't
> > do locking themselves, out from the original functions and call them
> > with read lock in the original functions and with write lock in
> > bus_rescan_devices().
> > 
> > 
> > Signed-off-by: Tejun Heo <tj@home-tj.org>
> 
> Thanks, I cleaned up the formatting a bit in this patch and applied it.
> 

Hmm, I do not like that the patch now fiddles with bus's rwsem before
incrementing bus's refcount.

I think just iterating through device list right the bus_rescan_devices
will be good enough. I sent the patch together with other 3, did it get
lost? 

-- 
Dmitry

