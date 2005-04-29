Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262661AbVD2OEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262661AbVD2OEo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 10:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262697AbVD2OEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 10:04:44 -0400
Received: from [81.2.110.250] ([81.2.110.250]:11478 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S262661AbVD2OEm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 10:04:42 -0400
Subject: Re: IDE problems with rmmod ide-cd
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1114727044.18330.232.camel@localhost.localdomain>
References: <1114706653.18330.212.camel@localhost.localdomain>
	 <20050428172541.GN1876@suse.de>
	 <1114727044.18330.232.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1114783384.18355.283.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 29 Apr 2005 15:03:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-04-28 at 23:24, Alan Cox wrote:
> One possibility might be that the specific drive is incorrectly
> reporting capabilities and register_cdrom is setting cdi->exit as a
> result. Will try and work out what is going on there tomorrow.

Looks like a dumb bug in ide-cd. The error is coming from mrw_exit.

That gets called because ide-cd sets mask to 0 "I do everything" and
then subtracts features by checking drive bits. What it should do is set
the mask to every flag it knows about and then work back.

The ide-cd code doesn't know about CDC_MRW_W so its always a zero bit in
the mask, CDROM_CAN(CDC_MRW_W) is always true and cache flushes get
written.

Alan

