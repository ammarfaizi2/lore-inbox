Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266786AbUBQXLo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 18:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266811AbUBQXLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 18:11:44 -0500
Received: from fw.osdl.org ([65.172.181.6]:6318 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266786AbUBQXLh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 18:11:37 -0500
Date: Tue, 17 Feb 2004 15:11:08 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Adrian Bunk <bunk@fs.tum.de>
cc: zippel@linux-m68k.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       GCS <gcs@lsc.hu>, Kernel Mailing List <linux-kernel@vger.kernel.org>,
       vandrove@vc.cvut.cz
Subject: Re: Linux 2.6.3-rc4
In-Reply-To: <20040217225905.GQ1308@fs.tum.de>
Message-ID: <Pine.LNX.4.58.0402171503150.2154@home.osdl.org>
References: <Pine.LNX.4.58.0402161945540.30742@home.osdl.org>
 <20040217184543.GA18495@lsc.hu> <Pine.LNX.4.58.0402171107040.2154@home.osdl.org>
 <20040217200545.GP1308@fs.tum.de> <Pine.LNX.4.58.0402171214230.2154@home.osdl.org>
 <20040217225905.GQ1308@fs.tum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Feb 2004, Adrian Bunk wrote:
> 
> No, I2C_ALGOBIT depends on I2C.
> 
> > That's really what the true dependency is, logically.
> 
> Below is a suggested fix that lets FB_RADEON_I2C select I2C.

Thinking about it, this does the wrong thing for _another_ reason.

Basically, if you compile radeonfb as a module, and say "Y" to RADEON_I2C, 
then that should _not_ force I2C to be built-in to the kernel, but that 
is in fact exactly what this would force.

Damn. I think your first patch was "more correct", but there's no question
that it was also pretty ugly and had exactly the same problem wrt
I2C_ALGOBIT, methinks.

What we actually want to say is something like "select I2C=FB_RADEON",
which makes the minimal dependency of I2C be the same value as FB_RADEON
(which is a tristate) rather than FB_RADEON_I2C (boolean).

Roman, maybe you can help with something that actually gets this right? 

			Linus
