Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262042AbTEEIRS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 04:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262054AbTEEIRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 04:17:17 -0400
Received: from verein.lst.de ([212.34.181.86]:772 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id S262042AbTEEIRQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 04:17:16 -0400
Date: Mon, 5 May 2003 10:29:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: "David S. Miller" <davem@redhat.com>
Cc: trond.myklebust@fys.uio.no, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove useless MOD_{INC,DEC}_USE_COUNT from sunrpc
Message-ID: <20030505102940.A16955@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	"David S. Miller" <davem@redhat.com>, trond.myklebust@fys.uio.no,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
References: <16053.25445.434038.90945@charged.uio.no> <1052075166.27465.12.camel@rth.ninka.net> <20030504230010.A12753@lst.de> <20030504.131558.27788112.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030504.131558.27788112.davem@redhat.com>; from davem@redhat.com on Sun, May 04, 2003 at 01:15:58PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 04, 2003 at 01:15:58PM -0700, David S. Miller wrote:
>    From: Christoph Hellwig <hch@lst.de>
>    Date: Sun, 4 May 2003 23:00:11 +0200
>    
>    Oh well, what about something like the following?
>  ...   
>    +	 */
>    +	if (!try_module_get(THIS_MODULE))
>    +		return -EBUSY;
> 
> Ahem... Why don't we just do this right? :-)
> 
> By this I mean provide some real registry thing in the
> main kernel image that we can use to do try_module_get()
> outside of the sunrpc module?

Please read the comment above that piece of code.  We always
enter this through an exported function so we know we currently
aren't unloadable.

> The other option is the make more progress in the area of
> two-stage module unload, and allowing cleanup() to return
> whether the module is unloadable or not.  This is being
> discussed on netdev so that we have some way to make ipv6
> modules work sanely (instead of putting try_module_get() in
> every other line, that simply isn't acceptable).

That's fine with me, but I won't sign up to do that work :)

