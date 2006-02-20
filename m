Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964938AbWBTQBL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964938AbWBTQBL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 11:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964941AbWBTQBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 11:01:11 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:57835 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964940AbWBTQBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 11:01:09 -0500
Date: Mon, 20 Feb 2006 16:00:54 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Ian Kent <raven@themaw.net>
Cc: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       autofs mailing list <autofs@linux.kernel.org>
Subject: Re: [PATCH] autofs4 - fix comms packet struct size
Message-ID: <20060220160054.GA31797@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ian Kent <raven@themaw.net>, Andrew Morton <akpm@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	autofs mailing list <autofs@linux.kernel.org>
References: <Pine.LNX.4.64.0602192206440.24506@eagle.themaw.net> <20060219141517.GA7942@infradead.org> <Pine.LNX.4.64.0602200856300.2355@eagle.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602200856300.2355@eagle.themaw.net>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 09:05:59AM +0800, Ian Kent wrote:
> > >  	autofs_wqt_t wait_queue_token;
> > 
> > Hiding types in user visible structures behind typedefs is bad.
> > What type is behind this?  If this is not an __u32 you have
> > a padding issue.
> 
> This has been an occassion problem for a long time.
> Since it dates back to way before version 4 I have always been reluctant 
> to change it. I'd rather leave it as is unless you really can't accept it.

So is this an __u32? ;-)

> OK. But will they be 32 bit for the life of this struct?

If we'd ever bump pid_t or uid_t to 64bits tons of kernel interface
would need to change.  And no one guarantees it'd be come an u64
then.  So __u32 is the safest choice.

