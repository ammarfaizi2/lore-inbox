Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271930AbRIDOfy>; Tue, 4 Sep 2001 10:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271937AbRIDOfn>; Tue, 4 Sep 2001 10:35:43 -0400
Received: from d12lmsgate.de.ibm.com ([195.212.91.199]:56755 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id <S271930AbRIDOfh>; Tue, 4 Sep 2001 10:35:37 -0400
Importance: Normal
Subject: Re: [SOLVED + PATCH]: documented Oops running big-endian reiserfs on parisc
 architecture
To: Jeff Mahoney <jeffm@suse.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF263FB8E3.75D4DAB3-ONC1256ABD.004F349C@de.ibm.com>
From: "Ulrich Weigand" <Ulrich.Weigand@de.ibm.com>
Date: Tue, 4 Sep 2001 16:34:28 +0200
X-MIMETrack: Serialize by Router on D12ML028/12/M/IBM(Release 5.0.8 |June 18, 2001) at
 04/09/2001 16:34:32
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jeff Mahoney wrote:

>    Are the S/390 asm/unaligned.h versions broken, or is the ReiserFS code
doing
>    something not planned for? It's a 16-bit member, at a 16-bit alignment
>    in the structure.  The structure itself need not be aligned in any
>    particular manner as it is read directly from disk, and is a packed
structure.

The S/390 unaligned.h macros are just direct assignments because the
S/390 hardware normally *allows* unaligned accesses just fine.

It is only *atomic* accesses (those implemented using the S/390
compare-and-swap instruction) that need to be word aligned; this includes
the atomic bit operations that reiserfs appears to be using.

If these instructions really *need* to be atomic, then reiserfs should
ensure they are performed on properly aligned data, or else there might
be subtle bugs even on Intel, because the operations will not actually
be atomic (even though they don't trap).

If you say that reiserfs doesn't really need these operations to be
atomic because they run under other locks anyway, then they should not
be using atomic operations in the first place; this will only cause
unnecessary slowdown even on Intel.


Mit freundlichen Gruessen / Best Regards

Ulrich Weigand

--
  Dr. Ulrich Weigand
  Linux for S/390 Design & Development
  IBM Deutschland Entwicklung GmbH, Schoenaicher Str. 220, 71032 Boeblingen
  Phone: +49-7031/16-3727   ---   Email: Ulrich.Weigand@de.ibm.com

