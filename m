Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbUHGKgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbUHGKgA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 06:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbUHGKgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 06:36:00 -0400
Received: from [80.190.193.18] ([80.190.193.18]:33989 "EHLO mx.vsadmin.de")
	by vger.kernel.org with ESMTP id S261239AbUHGKf6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 06:35:58 -0400
From: Stefan Meyknecht <sm0407@nurfuerspam.de>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] cdrom: MO-drive open write fix (trivial)
Date: Sat, 7 Aug 2004 12:35:56 +0200
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200408061833.30751.sm0407@nurfuerspam.de> <20040806220654.5e857bed.akpm@osdl.org> <20040807083835.GA24860@suse.de>
In-Reply-To: <20040807083835.GA24860@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408071235.56546.sm0407@nurfuerspam.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

thanks for your feedback.

Jens Axboe <axboe@suse.de> wrote:
> Sorry, guess I forgot to reply on linux-kernel. What I mean is that
> MO drives should just have CDC_RAM set - it doesn't denote a
> specific device type, rather just the ability to work like a hard
> drive. If you could look into why that isn't set for your mo device
> and send a patch for that, it would be much better.

You are right. After inserting some debug messages I found out that in 
function cdrom_open_write CDC_RAM is initially set. The function 
cdrom_is_random_writable sets ram_write to 0 and therefore CDC_RAM 
gets masked out later. cdrom_is_random_writable calls 
cdrom_get_random_writable and there cdi->ops->generic_packet returns 
-5 (-EIO?). But I have no idea what to do in this case.

-- 
Stefan Meyknecht
stefan at meyknecht dot org
