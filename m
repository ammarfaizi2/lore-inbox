Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263643AbUCUM5q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 07:57:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263644AbUCUM5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 07:57:46 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:34024 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S263643AbUCUM5p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 07:57:45 -0500
Date: Sun, 21 Mar 2004 13:57:30 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cowlinks v2
Message-ID: <20040321125730.GB21844@wohnheim.fh-wedel.de>
References: <s5gznab4lhm.fsf@patl=users.sf.net> <Pine.LNX.4.44.0403200845200.2382-100000@bigblue.dev.mdolabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0403200845200.2382-100000@bigblue.dev.mdolabs.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 March 2004 08:48:43 -0800, Davide Libenzi wrote:
> On 20 Mar 2004, Patrick J. LoPresti wrote:
> 
> > What happens if the disk fills while you are making the copy?  Will
> > open(2) on an *existing file* then return ENOSPC?
> > 
> > I do not think you can implement this without changing the interface
> > to open(2).  Which means applications have to be made aware of it
> > anyway.  Which means you might as well leave your implementation as-is
> > and let userspace worry about creating the copy (and dealing with the
> > resulting errors).
> 
> FWIW I did this quite some time ago to speed up copy+diff linux kernel 
> trees:
> 
> http://www.xmailserver.org/flcow.html
> 
> It is entirely userspace and uses LD_PRELOAD on my dev shell.

Nice work.  I was thinking about something like that as an
intermediate solution (my goal is libc inclusion), just with slightly
different checks:

	int ret = open(...);
	if (ret == -EMLINK)
		ret = cow_open(...);
	return ret;

Jörn

-- 
He that composes himself is wiser than he that composes a book.
-- B. Franklin
