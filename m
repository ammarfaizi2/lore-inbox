Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262149AbVAYVMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262149AbVAYVMY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 16:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262157AbVAYVDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 16:03:24 -0500
Received: from waste.org ([216.27.176.166]:4486 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262142AbVAYVBa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 16:01:30 -0500
Date: Tue, 25 Jan 2005 13:01:05 -0800
From: Matt Mackall <mpm@selenic.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Andrew Morton <akpm@osdl.org>, "Theodore Ts'o" <tytso@mit.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/12] random pt4: Cleanup SHA interface
Message-ID: <20050125210105.GN12076@waste.org>
References: <5.314297600@selenic.com> <200501252244.10612.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501252244.10612.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2005 at 10:49:01PM +0200, Denis Vlasenko wrote:
> On Friday 21 January 2005 23:41, Matt Mackall wrote:
> > +static void sha_transform(__u32 digest[5], const char *data, __u32 W[80])
> >  {
> > -	__u32 A, B, C, D, E;     /* Local vars */
> > +	__u32 A, B, C, D, E;
> >  	__u32 TEMP;
> >  	int i;
> > -#define W (digest + HASH_BUFFER_SIZE)	/* Expanded data array */
> >  
> > +	memset(W, 0, sizeof(W));
> 
> Hmm..... Parameter decays into pointer, sizeof(W) != 80*4. See:

Good spotting.

> In light of this, if your sha1 passed regression tests,
> I conclude that we don't need that memset at all.

Indeed, I noticed it was superfluous when I was benchmarking it. The
entire function is replaced a couple patches later.

-- 
Mathematics is the supreme nostalgia of our time.
