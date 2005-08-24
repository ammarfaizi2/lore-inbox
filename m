Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751232AbVHXRME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbVHXRME (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 13:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbVHXRME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 13:12:04 -0400
Received: from main.gmane.org ([80.91.229.2]:43488 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751232AbVHXRMC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 13:12:02 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Parag Warudkar <kernel-stuff@comcast.net>
Subject: Re: kernel BUG at kernel/workqueue.c:104!
Date: Wed, 24 Aug 2005 17:01:52 +0000 (UTC)
Message-ID: <loom.20050824T183802-165@post.gmane.org>
References: <430B48A5.4040702@hiramoto.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 198.208.223.35 (Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karl Hiramoto <karl <at> hiramoto.org> writes:

> 
> Hi,  i get this a lot now when doing:  "rmmod  cp2101 io_edgeport "
> 
> I try and do the rmmod, because i loose comunications on the USB to 
> RS-232 adapters.
> ------------[ cut here ]------------
> kernel BUG at kernel/workqueue.c:104!
> invalid operand: 0000 [#1]

Thats because the scheduled work became empty before it was executed.
 
        --  BUG_ON(!list_empty(&work->entry)); --

Looks like someone forgot to flush_scheduled_work() before exiting. Can you 
try putting flush_scheduled_work() as the first line in cp2101_exit and 
whatever is the exit function of io_edgeport?

Just a wild guess. Things might be more complicated than this, but no harm in 
trying.

Parag

