Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290430AbSAPQze>; Wed, 16 Jan 2002 11:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290435AbSAPQzZ>; Wed, 16 Jan 2002 11:55:25 -0500
Received: from colorfullife.com ([216.156.138.34]:15117 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S290430AbSAPQzR>;
	Wed, 16 Jan 2002 11:55:17 -0500
Message-ID: <3C45B06C.5AA45DCD@colorfullife.com>
Date: Wed, 16 Jan 2002 17:55:08 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.2-pre11 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andre Hedrick <andre@linuxdiskcert.org>, Andrew Morton <akpm@zip.com.au>
Subject: Re: block completion races
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Also, there is this code in ide_do_drive_cmd():
> 
>         if (action == ide_wait) {
>                 wait_for_completion(&wait);     /* wait for it to be serviced */
>                 return rq->errors ? -EIO : 0;   /* return -EIO if errors */
>         }
> 
> Is it safe to use `rq' here?  It has just been recycled in
> end_that_request_last() and we don't own it any more.
>

Yes, this is safe. rq lies on the stack of the caller of
ide_do_drive_cmd() - it can't disappear before we return.

--
	Manfred
