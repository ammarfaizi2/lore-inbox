Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263816AbRFHHiy>; Fri, 8 Jun 2001 03:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263881AbRFHHio>; Fri, 8 Jun 2001 03:38:44 -0400
Received: from 196-41-175-253.citec.net ([196.41.175.253]:41109 "EHLO
	penguin.wetton.prism.co.za") by vger.kernel.org with ESMTP
	id <S263816AbRFHHib>; Fri, 8 Jun 2001 03:38:31 -0400
Date: Fri, 8 Jun 2001 09:37:29 +0200
From: Bernd Jendrissek <berndj@prism.co.za>
To: Brian D Heaton <bdheaton@c4i2.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Break 2.4 VM in five easy steps
Message-ID: <20010608093729.A11720@prism.co.za>
In-Reply-To: <20010607124621.A30328@prism.co.za> <20010607153835.T14203@jessica>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <20010607153835.T14203@jessica>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thu, Jun 07, 2001 at 03:38:35PM -0600, Brian D Heaton wrote:
> 	Maybe i'm missing something.  I just tried this (with the 262144k/1
> and 128k/2048 params) and my results are within .1s of each other.  This is
> without any special patches.  Am I doing something wrong????

Oh, I don't mean the time elapsed, It's that nothing _else_ can happen
while dd is hogging the kernel.

> Oh yes -
> 
> SMP - dual PIII866/133

Yes, this is what you are doing wrong ;)

My hypothesis is that in your case, one cpu gets pegged copying pages
from /dev/zero into dd's buffer, while the other cpu can do things like
updating mouse cursors, run setiathome, etc.

What happens if you do *two* dd-tortures with huge buffers at the same
time?  And then, please don't happen to have a quad box!

I don't know if my symptom (loss of interactivity on heavy writing) is
related to swapoff -a causing the same symptom on deeply-swapped boxes.

BTW keep in mind my 4-liner is based more on voodoo than on analysis.

Bernd Jendrissek
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7IICU/FmLrNfLpjMRAnpTAJ48/jAFxZqfxUf2NXT0O542KDbNOwCfaoZo
Q2xaNE4GBqnbn/cl2vrRxLc=
=4sGO
-----END PGP SIGNATURE-----
