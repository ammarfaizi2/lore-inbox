Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262536AbVAPQPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262536AbVAPQPA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 11:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbVAPQPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 11:15:00 -0500
Received: from [213.146.154.40] ([213.146.154.40]:3785 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262536AbVAPQOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 11:14:45 -0500
Date: Sun, 16 Jan 2005 16:14:37 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Karim Yaghmour <karim@opersys.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, Andi Kleen <ak@muc.de>,
       Nikita Danilov <nikita@clusterfs.com>, linux-kernel@vger.kernel.org,
       Tom Zanussi <zanussi@us.ibm.com>
Subject: Re: 2.6.11-rc1-mm1
Message-ID: <20050116161437.GA26144@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Karim Yaghmour <karim@opersys.com>,
	Roman Zippel <zippel@linux-m68k.org>, Andi Kleen <ak@muc.de>,
	Nikita Danilov <nikita@clusterfs.com>, linux-kernel@vger.kernel.org,
	Tom Zanussi <zanussi@us.ibm.com>
References: <20050114002352.5a038710.akpm@osdl.org> <m1zmzcpfca.fsf@muc.de> <m17jmg2tm8.fsf@clusterfs.com> <20050114103836.GA71397@muc.de> <41E7A7A6.3060502@opersys.com> <Pine.LNX.4.61.0501141626310.6118@scrub.home> <41E8358A.4030908@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41E8358A.4030908@opersys.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2005 at 04:11:38PM -0500, Karim Yaghmour wrote:
> 	Where does this appear in relayfs and what rights do
> 	user-space apps have over it (rwx).

Why would you want anything but read access?

> bufsize, nbufs:
> 	Usually things have to be subdivided in sub-buffers to make
> 	both writing and reading simple. LTT uses this to allow,
> 	among other things, random trace access.

I think random access is overkill.  Keeping the code simple is more
important and user-space can post-process it.

> resize_min, resize_max:
> 	Allow for dynamic resizing of buffer.

Auto-resizing sounds like a really bad idea.

> init_buf, init_buf_size:
> 	Is there an initial buffer containing some data that should
> 	be used to initialize the channel's content. If you're doing
> 	init-time tracing, for example, you need to have a pre-allocated
> 	static buffer that is copied to relayfs once relayfs is mounted.

And why can't you do this from that code?  It just needs an initcall-like
thing that runs after mounting of relayfs.

