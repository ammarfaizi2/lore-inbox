Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131457AbRDFKYr>; Fri, 6 Apr 2001 06:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131461AbRDFKYh>; Fri, 6 Apr 2001 06:24:37 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:41478 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S131457AbRDFKYb>; Fri, 6 Apr 2001 06:24:31 -0400
Date: Fri, 6 Apr 2001 14:09:20 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Simmons <jsimmons@linux-fbdev.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: fbcon slowness [was NTP on 2.4.2?]
Message-ID: <20010406140920.A4866@jurassic.park.msu.ru>
In-Reply-To: <Pine.GSO.3.96.1010405150444.21134E-100000@delta.ds2.pg.gda.pl> <m17l0zw6mx.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m17l0zw6mx.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Thu, Apr 05, 2001 at 12:20:22PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2001 at 12:20:22PM -0600, Eric W. Biederman wrote:
> The point is on the Alpha all ram is always cached, and i/o space is
> completely uncached.  You cannot do write-combing for video card
> memory.

Incorrect. Alphas have write buffers - 6x32 bytes on ev5 and
4x64 on ev6, IIRC. So alphas do write up to 32 or 64 bytes
in a single pci transaction.

>  Memory barriers are a separate issue.  On the alpha the
> natural way to implement it would be in the page table fill code.
> Memory barriers are o.k. but the really don't help the case when what
> you want to do is read the latest value out of a pci register.  

You don't need memory barrier for that. "Write memory barriers" are
used to ensure correct write order, and "memory barriers" are used
to ensure that all pending reads/writes will complete before next read
or write.

Ivan.
