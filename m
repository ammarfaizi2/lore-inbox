Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264607AbTE1Hja (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 03:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264608AbTE1Hja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 03:39:30 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:27564 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264607AbTE1HjY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 03:39:24 -0400
Date: Wed, 28 May 2003 09:52:39 +0200
From: Jens Axboe <axboe@suse.de>
To: Andy Polyakov <appro@fy.chalmers.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69-70 ide-cd to guarantee fault-free CD/DVD burning experience?
Message-ID: <20030528075239.GW845@suse.de>
References: <3ED4681A.738DA3C6@fy.chalmers.se> <20030528074839.GU845@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030528074839.GU845@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 28 2003, Jens Axboe wrote:
> > @@ -1609,7 +1615,7 @@
> >  
> >  static void post_transform_command(struct request *req)
> >  {
> > -	char *ibuf = req->buffer;
> > +	char *ibuf = req->data?req->data:req->buffer;
> >  	u8 *c = req->cmd;
> >  
> >  	if (!blk_pc_request(req))
> 
> That is bad, though. I've changed this to just bail on !ibuf.

Sorry I misread that, ->data is the one we want. I'm wondering how this
got mixed up... So to clarify:

	char *ibuf = req->data;

	if (!blk_pc_request(req))
		return;
	if (!ibuf)
		return;

-- 
Jens Axboe

