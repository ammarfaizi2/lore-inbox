Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267410AbTACBI2>; Thu, 2 Jan 2003 20:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267413AbTACBI2>; Thu, 2 Jan 2003 20:08:28 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:28042
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267410AbTACBIY>; Thu, 2 Jan 2003 20:08:24 -0500
Subject: Re: [PATCH] TCP Zero Copy for mmapped files
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Larry McVoy <lm@bitmover.com>
Cc: Thomas Ogrisegg <tom@rhadamanthys.org>,
       "David S. Miller" <davem@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030103010107.GB6416@work.bitmover.com>
References: <20021230012937.GC5156@work.bitmover.com>
	<1041489421.3703.6.camel@rth.ninka.net>
	<20030102221210.GA7704@window.dhis.org>
	<20030102.151346.113640740.davem@redhat.com>
	<20030103004543.GA12399@window.dhis.org> 
	<20030103010107.GB6416@work.bitmover.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Jan 2003 01:59:55 +0000
Message-Id: <1041559195.24901.119.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-01-03 at 01:01, Larry McVoy wrote:
> And the list of applications which do
> 
> 	sock = socket(...);
> 	map = mmap(...);
> 	write(sock, map, bytes);
> 
> are?  There are not very many that I know of and if you look carefully
> at the bandwidth graphs in LMbench you'll see why.  There is a cross
> over point where mmap becomes cheaper but it used to be around 16-64K.
> I don't know what it is now, I doubt it's moved much.  I can check if
> you really want.

You may not be doing an mmap a send, its more likely to look like

	page = hash(url);
	memcpy(current_time, page->clock, TIMESIZE);
	write(sock, page->data, page->len);

that changes the breakeven point a lot

Alan

