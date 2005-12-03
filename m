Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751266AbVLCOrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbVLCOrP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 09:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbVLCOrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 09:47:15 -0500
Received: from hera.cwi.nl ([192.16.191.8]:13502 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S1751266AbVLCOrO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 09:47:14 -0500
Date: Sat, 3 Dec 2005 15:46:59 +0100
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Bodo Eggert <7eggert@gmx.de>
Cc: Andries Brouwer <Andries.Brouwer@cwi.nl>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, horms@verge.net.au
Subject: Re: security / kbd
Message-ID: <20051203144659.GA2091@apps.cwi.nl>
References: <5f6Fp-1ZB-11@gated-at.bofh.it> <E1EiLA5-0001VE-64@be1.lrz> <20051203013455.GB24760@apps.cwi.nl> <Pine.LNX.4.58.0512030251570.6039@be1.lrz> <20051203023946.GC24760@apps.cwi.nl> <Pine.LNX.4.58.0512030616230.6684@be1.lrz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0512030616230.6684@be1.lrz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 03, 2005 at 06:33:51AM +0100, Bodo Eggert wrote:

> > Please describe the perceived security problem.
> > You log in remotely to my machine. Want to do something evil.
> > What precisely do you do?
> 
> echo -e 'keycode 28 F70
>          string  F70 ";rm -rf /\x0a"' | loadkeys > /proc/0815/fd/1
> 
> where process 0815 is a "sleep 2147483647&"

I already told you the result:

  loadkeys: Couldnt get a file descriptor referring to the console

> I had stale permissions on /dev/tty0. With correct permission settings, 
> you'll need a session belonging to the malicious user.

Aha. So it seems you withdraw the "remote" part, and say that
a local user can leave a process with an open filedescriptor
on a console, and that process can be used to access the console
later. True.

But there are many ways of using such a file descriptor.
This patch cripples the keymap changing but does not solve anything.
The basic problem is that some things are common for all virtual
consoles, while on the other hand vhangup() on one VC does not
influence the other VCs.

Probably those common parts should be split and made per-VC.

Andries


