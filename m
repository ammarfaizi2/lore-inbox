Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261543AbUKOHiw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261543AbUKOHiw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 02:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261544AbUKOHiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 02:38:52 -0500
Received: from mx6.playtech.com ([194.126.102.184]:4817 "EHLO mx6.playtech.com")
	by vger.kernel.org with ESMTP id S261543AbUKOHiu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 02:38:50 -0500
Message-ID: <41985D28.1080900@vision.ee>
Date: Mon, 15 Nov 2004 09:39:20 +0200
From: =?UTF-8?B?TGVuYXIgTMO1aG11cw==?= <lenar@vision.ee>
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brad Fitzpatrick <brad@danga.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9: unkillable processes during heavy IO
References: <Pine.LNX.4.58.0411141403040.22805@danga.com>
In-Reply-To: <Pine.LNX.4.58.0411141403040.22805@danga.com>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had similar hanging with mysql on 64bit_debian@A64 3500+ + mysql 
4.1.5. 1GB memory.

After digging around I added "skip-concurrent-insert" to mysql conf and 
those hangs disappeared.
It might be mysql problem (not kernel) on 64bit linux.

Although my mysql processess where killable with -9.

Lenar

Brad Fitzpatrick wrote:

>We have two database servers which freeze up during heavy IO load.  The
>machines themselves are responsible, but the mysqld processes are forever
>locked, unkillable with even kill -9.  I can't restart with MySQL without
>rebooting the machines.
>
>I can reasonable rule out hardware, since this is happening in the
>same way on two identical machines.
>
>I'd like to know how I can debug this, to file a proper bug report.
>
>The hardware/software stack is:
>
>  - Dual Opteron 246, SMP kernel, w/ NUMA
>  - 9 GB of memory (4GB in one zone, 5GB in the other)
>  - MySQL, running mostly InnoDB, but some MyISAM
>  - MegaRAID raid-10
>  - device mapper
>  - XFS (used as both O_DIRECT from InnoDB and regularly from MyISAM)
>
>At this point I'm going to try changing different variables on
>different machines in order to try and isolate it, but it's a slow
>process.
>
>  - on raw partions, instead of device mapper
>  - ext3 instead of XFS
>  - not using O_DIRECT
>  
>

