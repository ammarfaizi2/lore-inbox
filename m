Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314079AbSEMP7W>; Mon, 13 May 2002 11:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314078AbSEMP7U>; Mon, 13 May 2002 11:59:20 -0400
Received: from gateway.ukaea.org.uk ([194.128.63.73]:14544 "EHLO
	fuspcnjc.culham.ukaea.org.uk") by vger.kernel.org with ESMTP
	id <S314079AbSEMP7H>; Mon, 13 May 2002 11:59:07 -0400
Message-ID: <3CDFE2C7.5454B13A@ukaea.org.uk>
Date: Mon, 13 May 2002 16:59:03 +0100
From: Neil Conway <nconway.list@ukaea.org.uk>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-31 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: dalecki@evision-ventures.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.15 IDE 62
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13 2002, Martin Dalecki wrote:
>Oops. Indeed I see now that the ide_lock is exported to
>the upper layers above it in ide-probe.c
>
>blk_init_queue(q, do_ide_request, &ide_lock);
>
>But this is problematic in itself, since it means that
>we are basically serialiazing between *all* requests
>on all channels.

Surely not.  If you look at the line above the one you quoted above, you
see the per-channel serialization being requested:

q->queuedata = drive->channel;

cheers,
Neil
PS: 2.4 doesn't even have the spinlock as a parameter to
blk_init_queue().
