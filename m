Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265978AbSLCC20>; Mon, 2 Dec 2002 21:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265982AbSLCC20>; Mon, 2 Dec 2002 21:28:26 -0500
Received: from packet.digeo.com ([12.110.80.53]:59554 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265978AbSLCC2Z>;
	Mon, 2 Dec 2002 21:28:25 -0500
Message-ID: <3DEC1880.722745C6@digeo.com>
Date: Mon, 02 Dec 2002 18:35:44 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: CaT <cat@zip.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.50: floppy/buffer related oops
References: <20021203021133.GD617@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Dec 2002 02:35:48.0659 (UTC) FILETIME=[B06CA830:01C29A74]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CaT wrote:
> 
> I was dding to a floppy disc that had errors on it.
> ...
> buffer layer error at fs/buffer.c:2641
> Pass this trace through ksymoops for reporting
> Call Trace:
>  [<c0143c03>] __buffer_error+0x33/0x38


That's not an oops.  It's a debug warning.

You had non-uptodate buffers against an uptodate page.  This
is an absurdity, but is not harmful.

Clearing BH_Uptodate on a write error has always seemed weird.
The error handling needs a review/rethink.  Meanwhile I'll drop
a buffer_req test into those warnings to shut them up.
