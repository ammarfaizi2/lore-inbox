Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262072AbVCNDZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbVCNDZS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 22:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbVCNDXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 22:23:41 -0500
Received: from smtpout1.uol.com.br ([200.221.4.192]:63443 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S261745AbVCNDXM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 22:23:12 -0500
Date: Mon, 14 Mar 2005 00:23:03 -0300
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: Matt Mackall <mpm@selenic.com>
Cc: zippel@linux-m68k.org, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Serious problems with HFS+
Message-ID: <20050314032303.GA29808@ime.usp.br>
Mail-Followup-To: Matt Mackall <mpm@selenic.com>, zippel@linux-m68k.org,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20050313203604.GF3163@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050313203604.GF3163@waste.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 13 2005, Matt Mackall wrote:
> I've noticed a few problems with HFS+ support in recent kernels on
> another user's machine running Ubuntu (Warty) running 2.6.8.1-3-powerpc.

I also saw some of the things that you reported with Debian proper (sarge).
Unfortunately, I haven't been able to use my HFS+ formatted system with
Linux for a while, I may do so, if necessary to fix the bugs.

> I'm not in a position to extensively test or fix either of these problem
> because of the fs tools situation so I'm just passing this on.

I, OTOH, can test fixes on the next weekend, since I have a full backup
scheduled for this week.

> First, it reports inappropriate blocks to stat(2). It uses 4096 byte
> blocks rather than 512 byte blocks which stat callers are expecting.
> This seriously confuses du(1) (and me, for a bit). Looks like it may
> be forgetting to set s_blocksize_bits.

I had not noticed what are the size of the blocks that HFS+ seems to use,
but indeed I saw both very confused du and ls outputs. I don't know what
may be the cause.

> Second, if an HFS+ filesystem mounted via Firewire or USB becomes
> detached, the filesystem appears to continue working just fine.

That's the only way that I am using a HFS+ fs (fia Firewire or USB), since
the drive in question is in an enclosure.

> I can find on the entire tree, despite memory pressure. I can even create
> new files that continue to appear in directory listings! Writes to
> such files succeed (they're async, of course) and the typical app is
> none the wiser. It's only when apps attempt to read later that they
> encounter problems. It turns out that various apps including scp
> ignore IO errors on read and silently copy zero-filled files to the
> destination. So I got this report as "why aren't the pictures I took
> off my camera visible on my website?"

I haven't seen this behaviour for lack of testing, but I will try to
reproduce it with an HFS+ fs on a file mounted via loopback.

> This is obviously a really nasty failure mode. At the very least, open
> of new files should fail with -EIO. Preferably the fs should force a
> read-only remount on IO errors. Given that the vast majority of HFS+
> filesystems Linux is likely to be used with are on hotpluggable media,
> I think this FS should be marked EXPERIMENTAL until such integrity
> problems are addressed.

I agree. This is, indeed, very scary.


Just another data point, Rogério.

-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Rogério Brito - rbrito@ime.usp.br - http://www.ime.usp.br/~rbrito
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
