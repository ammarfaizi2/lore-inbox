Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263573AbTJ0V3I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 16:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263575AbTJ0V3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 16:29:08 -0500
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:52655 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S263573AbTJ0V3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 16:29:06 -0500
From: Daniel Phillips <phillips@arcor.de>
To: Lars Marowsky-Bree <lmb@suse.de>, Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [PATCH] ide write barrier support
Date: Mon, 27 Oct 2003 23:35:17 +0200
User-Agent: KMail/1.5.3
Cc: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
References: <20031013140858.GU1107@suse.de> <200310262206.53904.phillips@arcor.de> <20031027102919.GC13640@marowsky-bree.de>
In-Reply-To: <20031027102919.GC13640@marowsky-bree.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310272235.17845.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 October 2003 11:29, Lars Marowsky-Bree wrote:
> On 2003-10-26T23:06:53,
>
>    Daniel Phillips <phillips@arcor.de> said:
> > Not entirely within the multipath virtual device, that's the problem.
> > If it could stay somehow all within one device driver then ok, but
> > since we want to build this modularly, as a device mapper target,
> > there are API issues.
>
> Are you seeing problems with the write-ordering properties of
> multipathing? If so, what is the issue with handling them in the DM
> target once?

No, no problem.  A multipath write barrier can be handled by blocking incoming 
writes in the target and waiting for all outstanding writes to complete.  I'd 
prefer to let the write barrier flow down the pipe to the SCSI disk if I 
could, but there are technical challenges.  Mainly I need to know if an 
ordered write is able to read its buffer into the drive's cache while it is 
waiting for preceding commands to complete; if so it would be worth putting 
the effort into developing the flow-through scheme.

Regards,

Daneil

