Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265378AbTLHL2a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 06:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265380AbTLHL2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 06:28:30 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:10393 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265378AbTLHL22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 06:28:28 -0500
Subject: Re: partially encrypted filesystem
From: David Woodhouse <dwmw2@infradead.org>
To: Phillip Lougher <phillip@lougher.demon.co.uk>
Cc: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Kallol Biswas <kbiswas@neoscale.com>, linux-kernel@vger.kernel.org,
       "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
In-Reply-To: <3FCF7AD5.4050501@lougher.demon.co.uk>
References: <1070485676.4855.16.camel@nucleon>
	 <20031203214443.GA23693@wohnheim.fh-wedel.de>
	 <Pine.LNX.4.58.0312031600460.2055@home.osdl.org>
	 <20031204141725.GC7890@wohnheim.fh-wedel.de>
	 <Pine.LNX.4.58.0312040712270.2055@home.osdl.org>
	 <20031204172653.GA12516@wohnheim.fh-wedel.de>
	 <3FCF7AD5.4050501@lougher.demon.co.uk>
Content-Type: text/plain
Message-Id: <1070882901.31993.72.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8.dwmw2.1) 
Date: Mon, 08 Dec 2003 11:28:22 +0000
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: dwmw2@infradead.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
X-Pentafluge-Mail-From: <dwmw2@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-12-04 at 18:20 +0000, Phillip Lougher wrote:
> Considering that Jffs2 is the only writeable compressed filesystem, yes. 
>   What should be borne in mind is compressed filesystems never expect 
> the data after compression to be bigger than the original data.

In fact that assumption is fairly trivial to remove, if you can put an
upper bound on the growth. Adding encryption of data to JFFS2 would
actually be fairly trivial; encryption of metadata would be harder. 

You could do it without touching or grokking the core of JFFS2 at all --
just poke at fs/jffs2/compr.c and note that you're expected to eat as
much of the input as will fit into the output buffer, returning success
even if it didn't all fit.

-- 
dwmw2

