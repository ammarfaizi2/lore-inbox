Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030453AbWEYVuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030453AbWEYVuX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 17:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030454AbWEYVuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 17:50:22 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:48609 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id S1030453AbWEYVuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 17:50:22 -0400
Date: Thu, 25 May 2006 12:40:35 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Andrew Morton <akpm@osdl.org>
cc: Wu Fengguang <wfg@mail.ustc.edu.cn>, linux-kernel@vger.kernel.org,
       mstone@mathom.us
Subject: Re: [PATCH 00/33] Adaptive read-ahead V12
In-Reply-To: <20060525084415.3a23e466.akpm@osdl.org>
Message-ID: <Pine.LNX.4.63.0605251240160.1814@dlang.diginsite.com>
References: <348469535.17438@ustc.edu.cn> <20060525084415.3a23e466.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 May 2006, Andrew Morton wrote:

> Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:
>>
>
> These are nice-looking numbers, but one wonders.  If optimising readahead
> makes this much difference to postgresql performance then postgresql should
> be doing the readahead itself, rather than relying upon the kernel's
> ability to guess what the application will be doing in the future.  Because
> surely the database can do a better job of that than the kernel.
>
> That would involve using posix_fadvise(POSIX_FADV_RANDOM) to disable kernel
> readahead and then using posix_fadvise(POSIX_FADV_WILLNEED) to launch
> application-level readahead.
>
> Has this been considered or attempted?

Postgres chooses not to try and duplicate OS functionality in it's I/O 
routines.

it doesn't try to determine where on disk the data is (other then 
splitting the data into multiple files and possibly spreading things 
between directories)

it doesn't try to do it's own readahead.

it _does_ maintain it's own journal, but depends on the OS to do the right 
thing when a fsync is issued on the files.

yes it could be re-written to do all this itself, but the project has 
decided not to try and figure out the best options for all the different 
filesystems and OS's that it runs on and instead trust the OS developers 
to do reasonable things instead.

besides, do you really want to have every program doing it's own 
readahead?

David Lang
