Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274012AbRISGsG>; Wed, 19 Sep 2001 02:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274013AbRISGr5>; Wed, 19 Sep 2001 02:47:57 -0400
Received: from h24-78-175-24.vn.shawcable.net ([24.78.175.24]:50315 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id <S274012AbRISGrm>;
	Wed, 19 Sep 2001 02:47:42 -0400
Date: Tue, 18 Sep 2001 23:46:48 -0700
From: Simon Kirby <sim@netnation.com>
To: linux-kernel@vger.kernel.org
Subject: O_NONBLOCK on files
Message-ID: <20010918234648.A21010@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've always wondered why it's not possible to do this:

fd = open("an_actual_file",O_RDONLY);
fcntl(fd,F_SETFL,O_NONBLOCK);
r = read(fd,buf,4096);

And actually have read return -1 and errno == EWOULDBLOCK/EAGAIN if the
block requested is not already cached.

Wouldn't this be the ideal interface for daemons of all types that want
to stay single-threaded and still offer useful performance when the
working set doesn't fit in cache?  It works with sockets, so why not
with files?

I see even TUX has to have I/O worker threads to work around this
limitation, which seems a bit silly.

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
