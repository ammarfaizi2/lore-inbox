Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267180AbTBQP3N>; Mon, 17 Feb 2003 10:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267185AbTBQP3N>; Mon, 17 Feb 2003 10:29:13 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:62473 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S267180AbTBQP3M>; Mon, 17 Feb 2003 10:29:12 -0500
Date: Mon, 17 Feb 2003 16:39:00 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Muli Ben-Yehuda <mulix@mulix.org>
cc: lkml <linux-kernel@vger.kernel.org>, Avi Teperman <teperman@il.ibm.com>,
       Muli Ben-Yehuda <muli@il.ibm.com>
Subject: Re: hidden assumptions in generic_file_write
In-Reply-To: <20030217150000.GI6014@latenight.fiasco.org.il>
Message-ID: <Pine.LNX.4.44.0302171628260.32518-100000@serv>
References: <20030217150000.GI6014@latenight.fiasco.org.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 17 Feb 2003, Muli Ben-Yehuda wrote:

> Since the data is copied to the page after prepare_write() returns, it 
> seems that the assumption is that prepare_write() is synchronous and
> the page was already read into memory in case it was not there.

prepare_write tells the fs which part of the page is overwritten, since 
the data is usually managed in buffer sized chunks and if the write is 
misaligned, it's needed to read a buffer from disk, so a complete buffer 
can be written back. That read is indeed syncronous.

> Also, after commit_write(), the code immediately falls through unlock 
> which unlocks the page. Since a page is locked during IO, it seems
> that commit_write() is synchronous and the page was already written
> when it returns.

The write is asynchronous, so the actual IO is started later. commit_write 
only marks the written buffers as dirty.

bye, Roman

