Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268832AbUHZLSY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268832AbUHZLSY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 07:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268767AbUHZLPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 07:15:15 -0400
Received: from gate.firmix.at ([80.109.18.208]:40669 "EHLO gate.firmix.at")
	by vger.kernel.org with ESMTP id S268727AbUHZLLn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 07:11:43 -0400
Subject: Re: silent semantic changes with reiser4
From: Bernd Petrovitsch <bernd@firmix.at>
To: Spam <spam@tnonline.net>
Cc: Andrew Morton <akpm@osdl.org>, jra@samba.org, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <742303812.20040826125114@tnonline.net>
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com>
	 <20040825152805.45a1ce64.akpm@osdl.org>
	 <112698263.20040826005146@tnonline.net>
	 <Pine.LNX.4.58.0408251555070.17766@ppc970.osdl.org>
	 <1453698131.20040826011935@tnonline.net>
	 <20040825163225.4441cfdd.akpm@osdl.org>
	 <20040825233739.GP10907@legion.cup.hp.com>
	 <20040825234629.GF2612@wiggy.net> <1939276887.20040826114028@tnonline.net>
	 <20040826024956.08b66b46.akpm@osdl.org>
	 <839984491.20040826122025@tnonline.net>
	 <20040826032457.21377e94.akpm@osdl.org>
	 <742303812.20040826125114@tnonline.net>
Content-Type: text/plain
Organization: Firmix Software GmbH
Message-Id: <1093518671.2883.19.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.5 
Date: Thu, 26 Aug 2004 13:11:11 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ shortened Cc: of reiser- and other folks since it is no longer
reiser-specific - sorry, if it was too much ]
[ fixed missing attribution ]

On Thu, 2004-08-26 at 12:51 +0200, Spam wrote:
> On Thu, 2004-08-26 at 03:24 -0700, Andrew Morton wrote:
> > Spam <spam@tnonline.net> wrote:
[...]
> >>   Applications  that support the new features will benefit, all others
> >>   will continue to work without destroying data.
> 
> > Sorry, but that all sounds a bit fluffy.   Please provide some examples.

It is too fluffy.

>   We  already had the examples with cp and mv. Both should continue to
>   work and the files will still be copied. The same with Konqueror and

... after they are patched to support streams. As stated each stream has
an own fd, so - from the user-space perspective - one has to open *all*
streams of this file, read them and write them into the destination.

>   Nautilus.  Files  and  their  meta-files/streams/attributes  will be
>   retained as long as applications are using the OS API.

The OS-API is *one* file descriptor where you can read, write, mmap, ...
on. Therefore stream selection must happen with open() since open()
returns a fd (which uniquely identify a stream). Voila.
And actually this makes transition actually possible: Old apps simply
ignore streams (yes, there will be a default stream, which is used id
nothing else is specified) and throw them away (think of e.g. patch
which opens a new file, writes into it, unlink's the old one and mv's
the new one on the old place) until they are modified to support them.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

