Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261755AbVCYTT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbVCYTT5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 14:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261751AbVCYTT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 14:19:57 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:46502 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261749AbVCYTTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 14:19:53 -0500
Subject: Re: [PATCH scsi-misc-2.6 08/08] scsi: fix hot unplug sequence
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Tejun Heo <htejun@gmail.com>
Cc: Jens Axboe <axboe@suse.de>, SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050325053842.GA24499@htj.dyndns.org>
References: <20050323021335.960F95F8@htj.dyndns.org>
	 <20050323021335.4682C732@htj.dyndns.org>
	 <1111550882.5520.93.camel@mulgrave> <4240F5A9.80205@gmail.com>
	 <20050323071920.GJ24105@suse.de> <1111591213.5441.19.camel@mulgrave>
	 <20050323152550.GB16149@suse.de> <1111711558.5612.52.camel@mulgrave>
	 <20050325031511.GA22114@htj.dyndns.org> <1111726965.5612.62.camel@mulgrave>
	 <20050325053842.GA24499@htj.dyndns.org>
Content-Type: text/plain
Date: Fri, 25 Mar 2005 13:19:48 -0600
Message-Id: <1111778388.5692.38.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-25 at 14:38 +0900, Tejun Heo wrote:
>  We have users of scsi_do_req() other than scsi_wait_req() and they
> use different done() functions to do different things.  I've checked
> other done functions and none uses contents inside the passed
> scsi_cmnd, so using a dummy command should be okay with them.  Am I
> missing something here?

Well ... the other users are supposed to be going away.  They're
actually all coded wrongly in some way or other ... perhaps I should
speed up the process.

>  Oh, and I would really appreciate if you can fill me in / give a
> pointer about the scsi_request/scsi_cmnd distinction.

The block layer speaks in terms of requests and the scsi layers in terms
of commands.  The scsi_request_fn() actually associates a request with a
command.  However, since SCSI uses the block layer for queueing, all the
internal scsi command submit paths have to use requests.  This is what a
scsi_request is.  The reason for the special casing is that we can't use
the normal REQ_CMD or REQ_BLOCK_PC paths because they need ULD
initialisation and back end processing.

James


