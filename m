Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261698AbUCBPqj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 10:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261701AbUCBPqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 10:46:39 -0500
Received: from findaloan.ca ([66.11.177.6]:30858 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id S261698AbUCBPqh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 10:46:37 -0500
Date: Tue, 2 Mar 2004 10:44:40 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Ben <linux-kernel-junk-email@slimyhorror.com>
Cc: Davide Libenzi <davidel@xmailserver.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fw: epoll and fork()
Message-ID: <20040302154440.GB24226@mark.mielke.cc>
Mail-Followup-To: Ben <linux-kernel-junk-email@slimyhorror.com>,
	Davide Libenzi <davidel@xmailserver.org>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0403020654080.24044-100000@bigblue.dev.mdolabs.com> <Pine.LNX.4.58.0403021527360.20736@baphomet.bogo.bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0403021527360.20736@baphomet.bogo.bogus>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2004 at 03:38:04PM +0000, Ben wrote:
> I was thinking that epoll should behave like a file descriptor (i.e. a
> child can close an inherited fd without affecting the parent), simply
> because the only connection a process has with epoll is the file
> descriptor. I suppose if you think of epoll_ctl() and epoll_wait() as
> write()s and read()s on the file descriptor, then it makes sense that
> these operations would affect both processes.
> It still feels 'wrong' though :)

If you read from a file descriptor in one process, the file pointer is
moved, and the read from the other process will not get the same bytes
twice.

Seems 'right', although inconvenient might be a better conclusion than
unintuitive... :-)

I wonder if this 'feature' could be taken advantage of somehow? One could
monitor the state of a file descriptor without having access to the file
descriptor... Hmm...

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

