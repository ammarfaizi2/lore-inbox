Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750901AbWG3BEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbWG3BEU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 21:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbWG3BEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 21:04:20 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:9113 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750900AbWG3BET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 21:04:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gSgIY+UFqL6f/vReO36J4vNWfUqAtr+M2muxrvlf3jKgLHOEV7mHyDRE3vnrg4m8Xe8ui81fQHWdcomUZWYleeROQfD9b2nJJ84lDyZaLyCaOwZHBtPrJjSaV8msut1Y8AkaulAZgLYePHv/a+qkvxAYbJyNwV5Dxnoz++95K1c=
Message-ID: <5c49b0ed0607291804j28193807t83d8237cad8d5ecd@mail.gmail.com>
Date: Sat, 29 Jul 2006 18:04:18 -0700
From: "Nate Diller" <nate.diller@gmail.com>
To: "Trond Myklebust" <trond.myklebust@fys.uio.no>
Subject: Re: [PATCH for 2.6.18] [8/8] MM: Remove rogue readahead printk
Cc: "Andi Kleen" <ak@suse.de>, torvalds@osdl.org, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1154207668.5784.35.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44cbba3f.mPUieUe31/EOZ6FZ%ak@suse.de>
	 <1154207668.5784.35.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/06, Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> On Sat, 2006-07-29 at 21:42 +0200, Andi Kleen wrote:
> > For some reason it triggers always with NFS root and spams the kernel
> > logs of my nfs root boxes a lot.
> >
> > Cc: trond.myklebust@fys.uio.no
> > Signed-off-by: Andi Kleen <ak@suse.de>
>
> Big ACK! I never really understood why we needed this printk, and yes,
> it does spam the syslog heavily on all NFS clients...

not an NFS user, but it seems like this is indicating an actual
performance problem.  the printk was introduced by an attempt to
reduce retries after -EIO on scratched CDs/DVDs, and is intended to
curb pathological behavior when one disk sector consitently cannot be
read.

for some reason (maybe just busy networks, dunno), you're getting I/O
errors on NFS, and the readahead window is being reduced.  IMO, the
proper behavior in this case would be to keep it large, or even
increase it, since that would enable the network to more efficiently
transfer data.

of course, it could be that some quirk of the NFS client VFS interface
causes "spurious" -EIO returns.  either way, i'd rather see it fixed
rather than the printk removed, since it is useful to point out that
some performance degradation is occuring.

NATE
