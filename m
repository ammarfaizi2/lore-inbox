Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030197AbWAWVPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030197AbWAWVPV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 16:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030191AbWAWVPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 16:15:21 -0500
Received: from smtp.osdl.org ([65.172.181.4]:37347 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030194AbWAWVPU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 16:15:20 -0500
Date: Mon, 23 Jan 2006 13:14:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: agk@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] device-mapper snapshot: barriers not supported
Message-Id: <20060123131446.3cfc0c1e.akpm@osdl.org>
In-Reply-To: <20060123155605.GP2366@marowsky-bree.de>
References: <20060120211759.GG4724@agk.surrey.redhat.com>
	<20060122214111.11170cdc.akpm@osdl.org>
	<20060123155605.GP2366@marowsky-bree.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lars Marowsky-Bree <lmb@suse.de> wrote:
>
> On 2006-01-22T21:41:11, Andrew Morton <akpm@osdl.org> wrote:
> 
> > Alasdair G Kergon <agk@redhat.com> wrote:
> > >
> > > The snapshot and origin targets are incapable of handling barriers and 
> > >  need to indicate this.
> > > 
> > > ...
> > >   
> > >  +	if (unlikely(bio_barrier(bio)))
> > >  +		return -EOPNOTSUPP;
> > >  +
> > 
> > And what was happening if people _were_ sending such BIOs down?  Did it all
> > appear to work correctly?  If so, will this change cause
> > currently-apparently-working setups to stop working?
> 
> Filesystems basically disable using barriers on a device which doesn't
> support them, which is indicated by -EOPNOTSUPP. Barriers are allowed to
> fail in such fashion.
> 
> Now the interesting question is what happens when barriers are suddenly
> verboten on a stack which used to support them - because the new mapping
> doesn't support it _anymore_. Hrm. _Should_ work, but probably not
> tested much ;-)
> 

I don't understand that, sorry.

My concern is: has the above change any potential to cause
currently-working setups to stop working?

