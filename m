Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750842AbWGQP0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbWGQP0J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 11:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbWGQP0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 11:26:09 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:35517 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1750842AbWGQP0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 11:26:08 -0400
Message-ID: <44BBAC0B.4020602@steeleye.com>
Date: Mon, 17 Jul 2006 11:26:03 -0400
From: Paul Clements <paul.clements@steeleye.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Michal Feix <michal.feix@firma.seznam.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nbd: Abort request on data reception failure
References: <44BA3C58.5080708@firma.seznam.cz>
In-Reply-To: <44BA3C58.5080708@firma.seznam.cz>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Feix wrote:
> When reading from nbd device, we need to receive all the data after
> receiving reply packet from the server - otherwise such request will
> never be ended.
> 
> If socket is closed right after accepting reply control packet and in
> the middle of waiting for read data, nbd_read_stat() returns NULL and
> nbd_end_request() is not called.

That's right. We can't return NULL after pulling the request off the queue.

Thanks,
Paul

