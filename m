Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbTE0AhR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 20:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262424AbTE0AhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 20:37:17 -0400
Received: from dyn-ctb-203-221-73-245.webone.com.au ([203.221.73.245]:14340
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S262422AbTE0AhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 20:37:16 -0400
Message-ID: <3ED2B637.2020606@cyberone.com.au>
Date: Tue, 27 May 2003 10:49:59 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Jens Axboe <axboe@suse.de>, James Bottomley <James.Bottomley@SteelEye.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCHES] add ata scsi driver
References: <Pine.LNX.4.44.0305261705070.15826-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0305261705070.15826-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Linus Torvalds wrote:

>On Tue, 27 May 2003, Nick Piggin wrote:
>
>>There is an elevator notifier which is called on request
>>completion in Andrew's tree (needed for AS io scheduler). This
>>can be used to do what you want.
>>
>
>Well, yeah, sure, you can use it to keep track of outstanding requests. 
>But wouldn't it be nicer to see them in the first place?
>
Yeah. Basically the driver will call:
elv_next_request, elv_remove_request, elv_completed_request

elv_remove_request can easily just move the request to another
list, which is removed by elv_completed_request.

Don't let the names bother you, the elevator (in Andrew's tree)
gets all the information it needs.

