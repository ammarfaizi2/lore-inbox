Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262649AbVDAF17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262649AbVDAF17 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 00:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262632AbVDAF1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 00:27:35 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:51042 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262625AbVDAFZt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 00:25:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=KGv5BGgCvJAvXQhAjjlSW++4aUYRaCXxNj0c4TtCYlp5LtiRIDdxE8oexqd1MPJOTm9oaF18gbiD6dWo04HCMmVfJnIwbslXWXGm3z9u89a8pEZxdgFiEvKO5gvsgCqUNJaVXZ/ARdmi/kN6TbAVdUtbLOdOZ3Lz6mUK1ZL2s7I=
Date: Fri, 1 Apr 2005 14:25:42 +0900
From: Tejun Heo <htejun@gmail.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Jens Axboe <axboe@suse.de>, SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH scsi-misc-2.6 08/13] scsi: move request preps in other places into prep_fn()
Message-ID: <20050401052542.GG11318@htj.dyndns.org>
References: <20050331090647.FEDC3964@htj.dyndns.org> <20050331090647.94FFEC1E@htj.dyndns.org> <1112292464.5619.30.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112292464.5619.30.camel@mulgrave>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, James.

On Thu, Mar 31, 2005 at 12:07:44PM -0600, James Bottomley wrote:
> On Thu, 2005-03-31 at 18:08 +0900, Tejun Heo wrote:
> > 	Move request preparations scattered in scsi_request_fn() and
> > 	scsi_dispatch_cmd() into scsi_prep_fn().
> > 
> > 	* CDB_SIZE check in scsi_dispatch_cmd()
> > 	* SCSI-2 LUN preparation in scsi_dispatch_cmd()
> > 	* scsi_init_cmd_errh() in scsi_request_fn()
> > 
> > 	No invalid request reaches scsi_request_fn() anymore.
> 
> This one, I like, there's just one small problem:
> 
> You can't move scsi_init_cmd_errh() out of the request function path:
> It's where we set up the sense buffer handling, so it has to be done
> every time the command is prepared for execution (the prep function is
> only called once)---think what happens if we turn a command around for
> retry based on a sense indication.
> 
> So redo the patch and I'll put it in.

 Ah.. with later requeue path consolidation patches, all requests get
their sense buffer cleared during requeueing, which, IMHO, is more
logical.  Moving scsi_init_cmd_errh() should come after the patch.
Sorry. :-)

 I'll make another take of this patchset (maybe subset) after issues
are resolved.  I'll split and reorder relocation of scsi_init_cmd_errh
then.

 Thanks.

-- 
tejun

