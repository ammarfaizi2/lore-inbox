Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262776AbVHDXwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262776AbVHDXwy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 19:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262758AbVHDXuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 19:50:40 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:51671 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262751AbVHDXtP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 19:49:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NtOvH6DxYGy9Qa1/nvEf+0pXPJPuRDzmiAuTHzwL4VTqvleGfOoBP6h+5h0Lc7WKt5f9p2yZ9n3xFo+8PtxrQQPKr0+no/nWbufq21SInj+RVsrMYL4zlLOWH06y3kw2fUjTw2F7YObxIZ1Y0/wZHv8SO5T7ZrohzhYsYIQ3qZg=
Message-ID: <311601c9050804164962d8a511@mail.gmail.com>
Date: Thu, 4 Aug 2005 17:49:15 -0600
From: "Eric D. Mudama" <edmudama@gmail.com>
Reply-To: "Eric D. Mudama" <edmudama@gmail.com>
To: Jens Axboe <axboe@suse.de>
Subject: Re: ahci, SActive flag, and the HD activity LED
Cc: Martin Wilck <martin.wilck@fujitsu-siemens.com>,
       linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       linux-ide@vger.kernel.org,
       "Wichert, Gerhard" <Gerhard.Wichert@fujitsu-siemens.com>
In-Reply-To: <20050803061917.GE3710@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42EF93F8.8050601@fujitsu-siemens.com>
	 <20050802163519.GB3710@suse.de> <42F05359.7030006@fujitsu-siemens.com>
	 <20050803061917.GE3710@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/05, Jens Axboe <axboe@suse.de> wrote:
> On Wed, Aug 03 2005, Martin Wilck wrote:
> > Have you (or has anybody else) also seen the wrong behavior of the
> > activity LED?
> 
> No, but I have observed that SActive never gets cleared by the device
> for non-NCQ commands (which is probably which gets you the stuck LED on
> some systems?), which to me is another indication that we should not be
> setting the tag bits for those commands.

The drives won't send a SetBits FIS when not using NCQ, as it can
really confuse some host adapters that don't understand NCQ.  I'd
imagine you're correct that the driver shouldn't be setting the bit in
the first place.

--eric
