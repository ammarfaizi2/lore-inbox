Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264147AbUIIN64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264147AbUIIN64 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 09:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264389AbUIIN4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 09:56:38 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:18663 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S264147AbUIINy5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 09:54:57 -0400
Date: Thu, 9 Sep 2004 15:54:55 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Andi Kleen <ak@suse.de>, discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] f_ops flag to speed up compatible ioctls in linux kernel
Message-ID: <20040909135455.GC14891@MAIL.13thfloor.at>
Mail-Followup-To: "Michael S. Tsirkin" <mst@mellanox.co.il>,
	Andi Kleen <ak@suse.de>, discuss@x86-64.org,
	linux-kernel@vger.kernel.org
References: <20040901072245.GF13749@mellanox.co.il> <20040903080058.GB2402@wotan.suse.de> <20040907104017.GB10096@mellanox.co.il> <20040907121418.GC25051@wotan.suse.de> <20040907134517.GA1016@mellanox.co.il> <20040907141524.GA13862@wotan.suse.de> <20040907142530.GB1016@mellanox.co.il> <20040907142945.GB20981@wotan.suse.de> <20040907150312.GB19354@MAIL.13thfloor.at> <20040907180719.GA2154@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040907180719.GA2154@mellanox.co.il>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 09:07:19PM +0300, Michael S. Tsirkin wrote:
> Hello!
> Quoting r. Herbert Poetzl (herbert@13thfloor.at) "Re: [discuss] f_ops flag to speed up compatible ioctls in linux kernel":
> > On Tue, Sep 07, 2004 at 04:29:46PM +0200, Andi Kleen wrote:
> > > On Tue, Sep 07, 2004 at 05:25:30PM +0300, Michael S. Tsirkin wrote:
> > > > > It may help your module, but won't solve the general problem shorter
> > > > > term.
> > > > But longer term it will be better, so why not go there?
> > > > Once the infrastructure is there, drivers will be able to be
> > > > migrated as required.
> > > 
> > > I have no problems with that. You would need two new entry points:
> > > one 64bit one without BKL and a 32bit one also without BKL. 
> > > 
> > > I think there were some objections to this scheme in the past,
> > > but I cannot think of a good alternative. 
> > 
> > uhm, apologies for dropping in, for what exactly
> > are two (new) separate entry points needed?
> > 
> > somehow lost context here ...
> > 
> > TIA,
> > Herbert
> 
> There are two uses BKL in the ioctl call path:
> 1. BKL is kept across the whole ioctl call
> 2. BKL is used to protect the compat hash lookup
> 
> So ioctl_native is to let drivers declare they dont need the BKL
> in they ioctl.
> 
> ioctl_compat is to let drivers declare 
> they dont need the hash lookup so it can be replaced by direct call by pointer.

okay, thanks, I guess I got it now, just wondered why
there should be different implementations for 32 and
64 bit, but a different semantic explains it ...

thanks,
Herbert

> MST
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
