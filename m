Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261470AbUKIKea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261470AbUKIKea (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 05:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbUKIKea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 05:34:30 -0500
Received: from hera.cwi.nl ([192.16.191.8]:6065 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261470AbUKIKeS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 05:34:18 -0500
Date: Tue, 9 Nov 2004 11:33:54 +0100
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <greg@kroah.com>, mingo@elte.hu, diffie@gmail.com,
       linux-kernel@vger.kernel.org, diffie@blazebox.homeip.net,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andries Brouwer <Andries.Brouwer@cwi.nl>
Subject: Re: 2.6.10-rc1-mm3
Message-ID: <20041109103354.GA14497@apps.cwi.nl>
References: <9dda349204110611043e093bca@mail.gmail.com> <20041107024841.402c16ed.akpm@osdl.org> <20041108075934.GA4602@elte.hu> <20041107234225.02c2f9b6.akpm@osdl.org> <20041108224259.GA14506@kroah.com> <20041108212747.33b6e14a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041108212747.33b6e14a.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2004 at 09:27:47PM -0800, Andrew Morton wrote:

> As for the limitation of 256 legacy ptys: we should either raise it by
> cooking up new device names or limit it to 256 in config.  The latter, I
> guess.  Is there a requirement to support more than 256 legacy ptys?

No. glibc uses 256 of them.

To make life interesting they use names
"pqrstuvwxyzabcde"/"0123456789abcdef"
while BSD used
"pqrsPQRS"/"0123456789abcdefghijklmnopqrstuv"
and the first ENOENT terminates the search, so old BSD programs
might see only 16 ptys.

I would be inclined to remove the variable CONFIG_LEGACY_PTY_COUNT,
using 256. If one really wants to use CONFIG_LEGACY_PTYS, that is
the right number. So, in include/linux/tty.h:

- #define NR_PTYS CONFIG_LEGACY_PTY_COUNT
+ #define NR_PTYS 256

Andries
