Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbTKOBJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 20:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbTKOBJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 20:09:59 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:59652 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261240AbTKOBJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 20:09:57 -0500
Message-ID: <3FB57CB8.8010604@zytor.com>
Date: Fri, 14 Nov 2003 17:09:12 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031030
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
CC: Larry McVoy <lm@bitmover.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel.bkbits.net off the air
References: <3FB57C00.4080205@gmx.net>
In-Reply-To: <3FB57C00.4080205@gmx.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carl-Daniel Hailfinger wrote:
> Larry,
> 
> regarding rsync from bkbits.net to kernel.org, would it be possible to do
> that with a post-incoming trigger in kernel.bkbits.net which starts rsync
> to kernel.org? That should solve all atomicity requirements, at least on
> the way from bkbits.net to kernel.org.
> Same way for the CVS tree. Since you are starting the conversion (I assume
> it's at least half automated), you could also add a call to rsync at the
> end of that script.
> Using rsync over ssh with pubkey authentication should be pretty
> straightforward and also mostly secure, since no incoming connections to
> bkbits.net are needed. The only thing listening to network connections
> would be bkd.
> 
> Comments on the (in)feasibility of my suggestion are welcome.
> 
> 
> Carl-Daniel
> (happy bk user)

One way to do think would be to have bkcvs flock() a particular key
file; we can then have the upload script flock() the same file, which
will wait if it's already busy.

It does *not* solve all atomicity problems, however.

	-hpa

