Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265441AbUEUI6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265441AbUEUI6J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 04:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265467AbUEUI6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 04:58:09 -0400
Received: from pao-nav01.pao.digeo.com ([12.47.58.24]:34827 "HELO
	pao-nav01.pao.digeo.com") by vger.kernel.org with SMTP
	id S265441AbUEUI6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 04:58:05 -0400
Date: Fri, 21 May 2004 01:56:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: nickpiggin@yahoo.com.au, alexeyk@mysql.com, linuxram@us.ibm.com,
       peter@mysql.com, linux-kernel@vger.kernel.org
Subject: Spam: Re: Random file I/O regressions in 2.6 [patch+results]
Message-Id: <20040521015647.4c383868.akpm@osdl.org>
In-Reply-To: <20040521075027.GN1952@suse.de>
References: <200405022357.59415.alexeyk@mysql.com>
	<1084480888.22208.26.camel@dyn319386.beaverton.ibm.com>
	<1084815010.13559.3.camel@localhost.localdomain>
	<200405200506.03006.alexeyk@mysql.com>
	<20040520145902.27647dee.akpm@osdl.org>
	<20040520152305.3dbfa00b.akpm@osdl.org>
	<40ADB062.8050005@yahoo.com.au>
	<20040521075027.GN1952@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 May 2004 08:57:15.0493 (UTC) FILETIME=[9D0AA150:01C43F11]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
> I think that's pretty similar. Andrew didn't say what device he was
>  testing on, but 2.4 ide defaults to max 64k where 2.6 defaults to 128k.

IDE.

I was being silly, sorry.  Those I/O stats include the (huge linear)
initial write of the "database" files, so the larger IDE request size will
be dominating.

What I need is a way of getting sysbench to create and remove the database
files in separate invokations, but the syntax for that is defeating me at
present.

>  > I'll take a guess at b, and say it could be as-iosched.c.
>  > Another thing might be that 2.6 has smaller nr_requests than
>  > 2.4, although you are unlikely to hid the read side limit
>  > with only 16 threads if they are doing sync IO.
> 
>  Andrew, you did numbers for deadline previously as well, but no rq
>  statistics there? As for nr_requests that's true, would be worth a shot
>  to bump available requests in 2.6.

Doubling the request queue size makes no difference.
