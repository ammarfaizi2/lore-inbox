Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030237AbWARLrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030237AbWARLrs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 06:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030238AbWARLrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 06:47:48 -0500
Received: from smtp010.mail.ukl.yahoo.com ([217.12.11.79]:26742 "HELO
	smtp010.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1030237AbWARLrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 06:47:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=Ik+46yvDdgNdgSBGAPsFoqvBmSX8SuA0xibexGW9w3tK0S+MLtX86Kv26+EHTYHXywbuyuCQRWnYKAxsGm7Xcw71IDFx3ZreI1HFSl9VvxSerHO0d3nqYiT31P26nX3RQRJevh1zCRPhIsYLdggnjEm1efnL4ZPHKZjN13Y7SzI=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 6/9] uml: avoid malloc to sleep in atomic sections
Date: Wed, 18 Jan 2006 12:47:42 +0100
User-Agent: KMail/1.8.3
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
References: <20060117235659.14622.18544.stgit@zion.home.lan> <20060118001938.14622.47308.stgit@zion.home.lan> <20060117165602.3d29f936.akpm@osdl.org>
In-Reply-To: <20060117165602.3d29f936.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601181247.42976.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 January 2006 01:56, Andrew Morton wrote:
> "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it> wrote:
> > +int __cant_sleep(void) {
> > +	return in_atomic() || irqs_disabled() || in_interrupt();
>
> aww, man, this is awful.  Code is supposed to know what context it's
> running in, not go fishing about in core internals trying to fix up its own
> confusion.

Yes, I know.

But is libc supposed too? That's our problem. This code is only used for calls 
to malloc() (not kmalloc()) after the kernel has booted.

There are a few calls to malloc in our code, ok, and those should be fixed 
too.

But the main problem are glibc ones (which are called from all kinds of places 
- we once got a crash because opendir() was calling malloc with big sizes - 
we solved that by optionally using vmalloc()).
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger with Voice: chiama da PC a telefono a tariffe esclusive 
http://it.messenger.yahoo.com
