Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267762AbTAMQDK>; Mon, 13 Jan 2003 11:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267812AbTAMQDK>; Mon, 13 Jan 2003 11:03:10 -0500
Received: from main.gmane.org ([80.91.224.249]:20421 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S267762AbTAMQDJ>;
	Mon, 13 Jan 2003 11:03:09 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Lars Magne Ingebrigtsen <larsi@gnus.org>
Subject: Re: Performance problems with NFS under 2.4.20
Date: Mon, 13 Jan 2003 17:11:58 +0100
Organization: Programmerer Ingebrigtsen
Message-ID: <m3iswtkp0x.fsf@quimbies.gnus.org>
References: <m3y95pkqpd.fsf@quimbies.gnus.org> <shsfzrxrqjb.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@main.gmane.org
Mail-Copies-To: never
X-Now-Playing: Cocteau Twins's _Four-Calendar =?iso-8859-1?q?Caf=E9=5F:?=
 "Pur"
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2.50
 (i686-pc-linux-gnu)
Cancel-Lock: sha1:bDuOc2HQ6NHt5ZcfnbnqTGvfDF4=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> writes:

> That is quite deliberate.
>
> open() is supposed to generate an RPC call in order to ensure that
> cached attributes (and hence cached data) are still valid (this is
> part of what is known as NFS 'close-to-open' cache consistency).

Ah, right.  

> If you are certain that you will never access the same file/directory
> from 2 different machines, you can try to mount with the 'nocto' mount
> option.

Thanks; "notco" fixes the problem.  

I have several machines that reads the same files/directories, but
only one machine that writes to the directories.  Will that be OK?

(The reason I noticed this at all is that out PHP-based web servers
started generating much internal network traffic after the upgrade.
The PHP directories are NFS-mounted, and due to the number of PHP
library files opened by each web access, the NFS traffic was about 10
times as high as the HTTP traffic.  :-/)

-- 
(domestic pets only, the antidote for overdose, milk.)
   larsi@gnus.org * Lars Magne Ingebrigtsen

