Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263670AbTIBKYH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 06:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263676AbTIBKYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 06:24:07 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:16809 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S263670AbTIBKYC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 06:24:02 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16212.28592.322946.64754@gargle.gargle.HOWL>
Date: Tue, 2 Sep 2003 12:23:44 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Dave Olien <dmo@osdl.org>, Petri Koistinen <petri.koistinen@iki.fi>,
       linux-kernel@vger.kernel.org
Subject: Re: Sparse warning: bitmap.h: bad constant expression
In-Reply-To: <20030902095628.GB7616@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.56.0309012249230.14789@dsl-hkigw4a35.dial.inet.fi>
	<20030902015702.GA10265@osdl.org>
	<20030902095628.GB7616@wohnheim.fh-wedel.de>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

=?iso-8859-1?Q?J=F6rn?= Engel writes:
 > On Mon, 1 September 2003 18:57:02 -0700, Dave Olien wrote:
 > > 
 > > The problem seems to be that sparse currently will only accept array
 > > declarations with a size that can be evaluated at compile time to
 > > a fixed value.  So an array declaration of the form:
 > > 
 > > int asize;
 > > int data[asize];
 > > 
 > > will fail.  sparse needs to be modified to recognize this type of 
 > > declaration with a variable array size.  That'll take a few hours of
 > > someone's time to fix.
 > 
 > Not quite true.  The above is an implicit call to alloca and should
 > not exist in the kernel.  No need to hack support into sparse.

If data is a local variable then this is perfectly valid example of a
C99 variable-length array (VLA). This works at least with gcc-2.95.3
and newer, and gcc handles it by itself w/o calling alloca().

Of course, VLAs should be bounded in size to avoid overflowing the
kernel stack, but that doesn't make them illegal per se.

/Mikael
