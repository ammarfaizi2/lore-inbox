Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262289AbTCEFc3>; Wed, 5 Mar 2003 00:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262394AbTCEFc3>; Wed, 5 Mar 2003 00:32:29 -0500
Received: from packet.digeo.com ([12.110.80.53]:48053 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262289AbTCEFc0>;
	Wed, 5 Mar 2003 00:32:26 -0500
Date: Tue, 4 Mar 2003 21:43:26 -0800
From: Andrew Morton <akpm@digeo.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reducing stack usage in v4l?
Message-Id: <20030304214326.7fe7a7ba.akpm@digeo.com>
In-Reply-To: <32833.4.64.238.61.1046841945.squirrel@www.osdl.org>
References: <32833.4.64.238.61.1046841945.squirrel@www.osdl.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Mar 2003 05:42:50.0126 (UTC) FILETIME=[0EF1A2E0:01C2E2DA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> wrote:
>
> Hi,
> 
> I was looking at stack usage in drivers/media/video/v4l1-compat.c::
> v4l_compat_translate_ioctl().  It's 0x924 bytes on my peecee.
> 
> It's fairly straightforward to change the stack space to
> kmalloc() space, but some of these functions (ioctls) are
> speed-critical, so I was wondering if the changes should still
> be done, or done only in some cases and not others, or wait
> until an oops is reported here....
> 

Well the function is doing a memset() of 2k's worth of memory already,
so it presumably doesn't care much.

Your kmalloc will be a small cost compared with that.
