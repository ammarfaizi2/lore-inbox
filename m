Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266825AbTGGGzL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 02:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266832AbTGGGzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 02:55:11 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:60936 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266825AbTGGGzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 02:55:05 -0400
Date: Mon, 7 Jul 2003 08:09:29 +0100
From: Christoph Hellwig <hch@infradead.org>
To: James Morris <jmorris@intercode.com.au>
Cc: Thomas Spatzier <TSPAT@de.ibm.com>, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@redhat.com>
Subject: Re: crypto API and IBM z990 hardware support
Message-ID: <20030707080929.A1848@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	James Morris <jmorris@intercode.com.au>,
	Thomas Spatzier <TSPAT@de.ibm.com>, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@redhat.com>
References: <OF1BACB1D3.F4409038-ONC1256D57.00247A0A-C1256D57.002701D8@de.ibm.com> <Mutt.LNX.4.44.0307021913540.31308-100000@excalibur.intercode.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Mutt.LNX.4.44.0307021913540.31308-100000@excalibur.intercode.com.au>; from jmorris@intercode.com.au on Wed, Jul 02, 2003 at 07:35:16PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 02, 2003 at 07:35:16PM +1000, James Morris wrote:
> The plan is to provide crypto/arch/ subdirectories where arch optimized 
> versions of the crypto algorithms are implemented, and built automatically 
> (via configuration defaults) instead of the generic C versions.
> 
> So, there might be:
> 
> crypto/aes.c
> crypto/arch/i386/aes.s

crypto/arch/ sounds like a bad idea.  We really should avoid arch code
outside arch/ and include/asm*.  So arch/<foo>/crypto/ as suggested by
Thomas is much better.

> where on i386, aes.s would be built into aes.o and aes.c would not be 
> built.

That's a really bad idea.  Think of a i586/i686 optimized assembler
implementaion e.g. using MMX or SSE or whatever.  You'll always need
the generic version as fallback.

> The simple solution for you might be something like:
> 
> crypto/aes.c -> aes.o
> crypto/arch/s390/aes_z990.c -> aes_z990.o
> 
> and the administrator of the system could configure modprobe.conf to alias 
> aes to aes_z990 if the latter is supported in hardware.

Right.  And IMHO this should happen with all optimized version - putting
policy in the kernel to select them sounds like a bad idea, especially
as it could get rather complicated when it involves multiple optimized
and / or hardware implementations.

