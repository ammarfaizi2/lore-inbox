Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261732AbVC3Der@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbVC3Der (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 22:34:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261740AbVC3Der
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 22:34:47 -0500
Received: from vega.ipal.net ([209.102.192.64]:49080 "EHLO vega.ipal.net")
	by vger.kernel.org with ESMTP id S261732AbVC3Deo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 22:34:44 -0500
Date: Tue, 29 Mar 2005 21:34:43 -0600
From: Phil Howard <phil-linux-kernel@ipal.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] embarassing typo
Message-ID: <20050330033443.GA2964@vega.ipal.net>
References: <1112128584.25954.6.camel@tux.lan> <yw1xd5ti17z6.fsf@ford.inprovide.com> <4249CFA1.7050907@tls.msk.ru> <yw1xu0mtzy1g.fsf@ford.inprovide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yw1xu0mtzy1g.fsf@ford.inprovide.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2005 at 04:07:39AM +0200, M?ns Rullg?rd wrote:

| Michael Tokarev <mjt@tls.msk.ru> writes:
| 
| > M?ns Rullg?rd wrote:
| >> "Ronald S. Bultje" <rbultje@ronald.bitfreak.net> writes:
| >>
| >>>--- linux-2.6.5/drivers/media/video/zr36050.c.old	16 Sep 2004 22:53:27 -0000	1.2
| >>>+++ linux-2.6.5/drivers/media/video/zr36050.c	29 Mar 2005 20:30:23 -0000
| >>>@@ -419,7 +419,7 @@
| >>> 	dri_data[2] = 0x00;
| >>> 	dri_data[3] = 0x04;
| >>> 	dri_data[4] = ptr->dri >> 8;
| >>>-	dri_data[5] = ptr->dri * 0xff;
| >>>+	dri_data[5] = ptr->dri & 0xff;
| >> Hey, that's a nice obfuscation of a simple negation.
| >
| > It's not a negation.  This statement always assigns zero to
| > dri_data[5] if dri_data is char[].
| 
| Sure about that?
| 
| __u16 i;
| char c;
| i = 1; c = i * 255; /* c = 255 = -1 */
| i = 2; c = i * 255; /* c = 510 & 0xff = 254 = -2 */
| ...
| 
| Looks like negation to me.

Sure it's negation because 255 _is_ 256 - 1.  Basic finite math.

( x * 256 )                 mod 256 == 0
( ( x * 256 ) - ( x * 1 ) ) mod 256 == - ( x * 1 )
( x * ( 256 - 1 ) )         mod 256 == - ( x * 1 )
( x * 255 )                 mod 256 == - ( x * 1 )
( x * 255 )                 mod 256 == - x

Now what I am interested in is if gcc optimized it to a faster negation
or subtraction instruction.

-- 
-----------------------------------------------------------------------------
| Phil Howard KA9WGN       | http://linuxhomepage.com/      http://ham.org/ |
| (first name) at ipal.net | http://phil.ipal.org/   http://ka9wgn.ham.org/ |
-----------------------------------------------------------------------------
