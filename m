Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751029AbWBCIdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbWBCIdo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 03:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbWBCIdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 03:33:44 -0500
Received: from mail.domino-uk.com ([193.131.116.193]:38927 "EHLO
	vMIMEsweeper.dps.local") by vger.kernel.org with ESMTP
	id S1750836AbWBCIdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 03:33:42 -0500
From: Ulrich Eckhardt <eckhardt@satorlaser.com>
Organization: Sator Laser GmbH
To: Akinobu Mita <mita@miraclelinux.com>
Subject: Re: [patch 14/44] generic hweight{64,32,16,8}()
Date: Fri, 3 Feb 2006 09:31:42 +0100
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, Richard Henderson <rth@twiddle.net>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Russell King <rmk@arm.linux.org.uk>, Ian Molton <spyro@f2s.com>,
       dev-etrax@axis.com, David Howells <dhowells@redhat.com>,
       Yoshinori Sato <ysato@users.sourceforge.jp>,
       Linus Torvalds <torvalds@osdl.org>, linux-ia64@vger.kernel.org,
       Hirokazu Takata <takata@linux-m32r.org>, linux-m68k@vger.kernel.org,
       Greg Ungerer <gerg@uclinux.org>, linux-mips@linux-mips.org,
       parisc-linux@parisc-linux.org, linuxppc-dev@ozlabs.org,
       linux390@de.ibm.com, linuxsh-dev@lists.sourceforge.net,
       linuxsh-shmedia-dev@lists.sourceforge.net, sparclinux@vger.kernel.org,
       ultralinux@vger.kernel.org, Miles Bader <uclinux-v850@lsi.nec.co.jp>,
       Andi Kleen <ak@suse.de>, Chris Zankel <chris@zankel.net>
References: <20060201090224.536581000@localhost.localdomain> <20060201090325.905071000@localhost.localdomain>
In-Reply-To: <20060201090325.905071000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602030931.43686.eckhardt@satorlaser.com>
X-OriginalArrivalTime: 03 Feb 2006 08:26:27.0578 (UTC) FILETIME=[86F36DA0:01C6289B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 February 2006 10:02, Akinobu Mita wrote:
> unsigned int hweight32(unsigned int w);
> unsigned int hweight16(unsigned int w);
> unsigned int hweight8(unsigned int w);
> unsigned long hweight64(__u64 w);

IMHO, this should use explicitly sized integers like __u8, __u16 etc, unless 
there are stringent reasons like better register use - which is hard to tell 
for generic C code. Also, why on earth is the returntype for hweight64 a 
long?

> +static inline unsigned int hweight32(unsigned int w)
> +{
> +        unsigned int res = (w & 0x55555555) + ((w >> 1) & 0x55555555);
> +        res = (res & 0x33333333) + ((res >> 2) & 0x33333333);
[...]

Why not use unsigned constants here?

> +static inline unsigned long hweight64(__u64 w)
> +{
[..]
> +	u64 res;
> +	res = (w & 0x5555555555555555ul) + ((w >> 1) & 0x5555555555555555ul);

Why not use initialisation here, too?

just my 2c

Uli
