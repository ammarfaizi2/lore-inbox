Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269395AbUIYTXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269395AbUIYTXR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 15:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269398AbUIYTXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 15:23:16 -0400
Received: from dp.samba.org ([66.70.73.150]:59291 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S269395AbUIYTXG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 15:23:06 -0400
Date: Sat, 25 Sep 2004 12:22:24 -0700
From: Jeremy Allison <jra@samba.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeremy Allison <jra@samba.org>,
       YOSHIFUJI Hideaki / =?utf-8?B?5ZCJ6Jek6Iux5piO?= 
	<yoshfuji@linux-ipv6.org>,
       samuel.thibault@ens-lyon.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6] smbfs & "du" illness
Message-ID: <20040925192224.GZ580@jeremy1>
Reply-To: Jeremy Allison <jra@samba.org>
References: <20040917205422.GD2685@bouh.is-a-geek.org> <Pine.LNX.4.58.0409250929030.2317@ppc970.osdl.org> <20040925171104.GN580@jeremy1> <20040926.024131.06508879.yoshfuji@linux-ipv6.org> <20040925174406.GP580@jeremy1> <Pine.LNX.4.58.0409251054490.2317@ppc970.osdl.org> <Pine.LNX.4.58.0409251108570.2317@ppc970.osdl.org> <20040925182021.GR580@jeremy1> <Pine.LNX.4.58.0409251216000.2317@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409251216000.2317@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2004 at 12:16:24PM -0700, Linus Torvalds wrote:
> 
> 
> On Sat, 25 Sep 2004, Jeremy Allison wrote:
> > 
> > To recap, if we have st_blocks from the filesystem we use it
> > and send the value scaled as bytes, if not we send the actual
> > file size there in bytes (as we know any POSIX system has at
> > least that).
> > 
> > Happy ?
> 
> Not really. Where did that 1MB minimum value come from?

A Samba bug for Linux clients. Sending 1mb minimum for Windows
clients causes them to use larger internal buffers and do
larger reads. So making this value 1mb is good for us when
serving Windows clients.

The "blocks used on disk" logic in smbd is one function
called from all the (several :-) different info levels
that return this value. I made this mistake of calling
it for the UNIX info level return also, instead of returning
the real value for UNIX clients (who can handle the truth
rather better than Windows :-).

I'll fix it for the next Samba release. Happy *now* ? :-).

Jeremy.
