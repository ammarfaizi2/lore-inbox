Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264589AbTLTQCb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 11:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264602AbTLTQCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 11:02:31 -0500
Received: from fw.osdl.org ([65.172.181.6]:27069 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264589AbTLTQCa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 11:02:30 -0500
Date: Sat, 20 Dec 2003 08:03:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: jlnance@unity.ncsu.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: Test program with VM or FS problems
Message-Id: <20031220080327.2aef4c11.akpm@osdl.org>
In-Reply-To: <20031220154315.GA12763@ncsu.edu>
References: <20031220154315.GA12763@ncsu.edu>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jlnance@unity.ncsu.edu wrote:
>
>  Hello Andrew,
>      About a year ago I told you I would get you some more information
>  about a problem I was seeing that might be in the Linux VM or ext{2,3}
>  code.

I thought you'd forgotten!

>  For most of the run the temp file is smaller
>  than this.  So for most of the run both files will fit into the
>  memory of the machine.  Thus I would expect the program to run
>  quickly, because it will not need to touch the disk.  Things are
>  in cache.  This is not what I see.  Instead the program seems to
>  be very much disk bound.

I bet the use-once page replacement heuristic is doing the wrong thing.  I
noticed it playing up once - the machine had 30M on the inactive list and
reading a 40M file repeatedly caused that file to never get cached.  it
just kept on reclaiming itself.


