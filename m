Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262500AbSLPXSe>; Mon, 16 Dec 2002 18:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262631AbSLPXSe>; Mon, 16 Dec 2002 18:18:34 -0500
Received: from packet.digeo.com ([12.110.80.53]:21994 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262500AbSLPXSd>;
	Mon, 16 Dec 2002 18:18:33 -0500
Message-ID: <3DFE60EC.3DDA2669@digeo.com>
Date: Mon, 16 Dec 2002 15:25:32 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.51 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>, linux-kernel@vger.kernel.org,
       Chris Mason <mason@suse.com>
Subject: Re: [Benchmark] AIM9 results
References: <20021216225257.5871.qmail@linuxmail.org> <3DFE5D3B.4030402@namesys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Dec 2002 23:26:23.0159 (UTC) FILETIME=[8BD77C70:01C2A55A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:
> 
> Andrew and Chris, are these changes in performance definitely due to VM
> changes (and not some difference I am not thinking of between 2.5 and
> 2.4 reiserfs code)?
> 

aim9 is just doing

	for (lots)
		close(creat(filename))

ie: deleting a zero-length file.

So I changed inode_setattr() to not call into the filesystem
at all if i_size was not being altered.  Not a very interesting
optimisation, but it was simple to do.

It seems that reiserfs_truncate() has a lot of setup overhead.
