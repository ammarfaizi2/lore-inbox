Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261691AbUCBPoC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 10:44:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261696AbUCBPoC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 10:44:02 -0500
Received: from findaloan.ca ([66.11.177.6]:53124 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id S261691AbUCBPn7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 10:43:59 -0500
Date: Tue, 2 Mar 2004 10:42:02 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Ben <linux-kernel-junk-email@slimyhorror.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: epoll and fork()
Message-ID: <20040302154202.GA24226@mark.mielke.cc>
Mail-Followup-To: Ben <linux-kernel-junk-email@slimyhorror.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0403021224520.20736@baphomet.bogo.bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0403021224520.20736@baphomet.bogo.bogus>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2004 at 12:31:20PM +0000, Ben wrote:
> Is there a defined behaviour for what happens when a process with an epoll
> fd forks?

You found it. :-)

> I've an app that inherits an epoll fd from its parent, and then
> unregisters some file descriptors from the epoll set. This seems to have
> the nasty side effect of unregistering the same file descriptors from the
> parent process as well. Surely this can't be right?

The epoll fd should probably be closed after the fork(), re-allocated,
and then initialized to contain the file descriptors that you want to
watch.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

