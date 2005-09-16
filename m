Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161161AbVIPKb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161161AbVIPKb6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 06:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161160AbVIPKb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 06:31:58 -0400
Received: from ozlabs.org ([203.10.76.45]:27059 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1161157AbVIPKb5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 06:31:57 -0400
Date: Fri, 16 Sep 2005 20:28:30 +1000
From: Anton Blanchard <anton@samba.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Dipankar Sarma <dipankar@in.ibm.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, stern@rowland.harvard.edu
Subject: Re: [2.6.14-rc1] sym scsi boot hang
Message-ID: <20050916102830.GC14962@krispykreme>
References: <20050913124804.GA5008@in.ibm.com> <20050913131739.GD26162@krispykreme> <20050913142939.GE26162@krispykreme> <1126629345.4809.36.camel@mulgrave> <20050914080629.GB19051@krispykreme> <1126717062.4584.4.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1126717062.4584.4.camel@mulgrave>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> OK, my fault.  Your fix is almost correct .. I was going to do this
> eventually, honest, because there's no need to unprep and reprep a
> command that comes in through scsi_queue_insert().
> 
> However, I decided to leave it in to exercise the scsi_unprep_request()
> path just to make sure it was working.  What's happening, I think, is
> that we also use this path for retries.  Since we kill and reget the
> command each time, the retries decrement is never seen, so we're
> retrying forever.
> 
> This should be the correct reversal.

Thanks James, that did the trick.

Anton
