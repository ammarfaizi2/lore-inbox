Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262611AbVBCBA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262611AbVBCBA6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 20:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262638AbVBCBAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 20:00:50 -0500
Received: from waste.org ([216.27.176.166]:23997 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262611AbVBCBAV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 20:00:21 -0500
Date: Wed, 2 Feb 2005 17:00:01 -0800
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       Christophe Saout <christophe@saout.de>,
       Clemens Fruhwirth <clemens@endorphin.org>, dm-crypt@saout.de
Subject: Re: dm-crypt crypt_status reports key?
Message-ID: <20050203010001.GM2493@waste.org>
References: <20050202211916.GJ2493@waste.org> <20050202235002.GD14097@agk.surrey.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050202235002.GD14097@agk.surrey.redhat.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2005 at 11:50:02PM +0000, Alasdair G Kergon wrote:
> On Wed, Feb 02, 2005 at 01:19:16PM -0800, Matt Mackall wrote:
> > # dmsetup table /dev/mapper/volume1
> > 0 2000000 crypt aes-plain 0123456789abcdef0123456789abcdef 0 7:0 0
>  
> > Obviously, root can in principle recover this password from the
> > running kernel but it seems silly to make it so easy.
>  
> There seemed little point obfuscating it - someone will only
> write a trivial utility that recovers it.

So instead let's do the work for them? We could perhaps put it in the
root prompt. Pray tell, what is the value to the user of exposing the
whole password, ever?

> Consider instead *why* you're worried about the password being
> held in RAM and look for better solutions to *your*
> perceived threats.

My perceived threat, as I've already stated, is that automated suite
of utilities like LVM or EVMS or even initscripts will silently store
this information in the clear on disk in an effort to make life
easier, oblivious to the fact that it might contain security-sensitive
information.

What drives this perception is that the output of "dmsetup tables"
invites it: it appears tailor-made to be fed into a future "dmsetup
create". Thus someone clever (but unaware of dm_crypt) _will_
eventually try this if it's not already happening. Further, there is
nothing in the dmsetup manpage to suggest that its output should be
guarded, etc. See "principle of least surprise."

Given the potential risk of naive use of dmsetup tables, what's the
upside again?

-- 
Mathematics is the supreme nostalgia of our time.
