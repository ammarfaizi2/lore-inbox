Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S135439AbQK0E3m>; Sun, 26 Nov 2000 23:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132549AbQK0E3d>; Sun, 26 Nov 2000 23:29:33 -0500
Received: from munchkin.spectacle-pond.org ([209.192.197.45]:15112 "EHLO
        munchkin.spectacle-pond.org") by vger.kernel.org with ESMTP
        id <S132522AbQK0E3Y>; Sun, 26 Nov 2000 23:29:24 -0500
Date: Sun, 26 Nov 2000 23:00:10 -0500
From: Michael Meissner <meissner@spectacle-pond.org>
To: Tim Waugh <twaugh@redhat.com>
Cc: James A Sutherland <jas88@cam.ac.uk>, Andries Brouwer <aeb@veritas.com>,
        Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0"
Message-ID: <20001126230010.A16176@munchkin.spectacle-pond.org>
In-Reply-To: <20001125211939.A6883@veritas.com> <200011252211.eAPMBIo21200@gondor.apana.org.au> <20001125234624.A7049@veritas.com> <0011252259430A.11866@dax.joh.cam.ac.uk> <20001125235511.A16662@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20001125235511.A16662@redhat.com>; from twaugh@redhat.com on Sat, Nov 25, 2000 at 11:55:11PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2000 at 11:55:11PM +0000, Tim Waugh wrote:
> On Sat, Nov 25, 2000 at 10:53:00PM +0000, James A Sutherland wrote:
> 
> > Which is silly. The variable is explicitly defined to be zero
> > anyway, whether you put this in your code or not.
> 
> Why doesn't the compiler just leave out explicit zeros from the
> 'initial data' segment then?  Seems like it ought to be tought to..

Because sometimes it matters.  For example, in kernel mode (and certainly for
embedded programs that I'm more familiar with), the kernel does go through and
zero out the so called BSS segment, so that normally uninitialized static
variables will follow the rules as laid out under the C standards (both C89 and
C99).  I can imagine however, that the code that is executed before the BSS
area is zeroed out needs to be extra careful in terms of statics that it
references, and those must be hand initialized.

-- 
Michael Meissner, Red Hat, Inc.
PMB 198, 174 Littleton Road #3, Westford, Massachusetts 01886, USA
Work:	  meissner@redhat.com		phone: +1 978-486-9304
Non-work: meissner@spectacle-pond.org	fax:   +1 978-692-4482
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
