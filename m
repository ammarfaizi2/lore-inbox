Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264245AbTDPGN2 (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 02:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbTDPGN2 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 02:13:28 -0400
Received: from palrel12.hp.com ([156.153.255.237]:56207 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S264245AbTDPGN1 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 02:13:27 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16028.63307.771533.129067@napali.hpl.hp.com>
Date: Tue, 15 Apr 2003 23:25:15 -0700
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: size of CRCs in module versions
In-Reply-To: <Pine.LNX.4.44.0304160037130.4255-100000@chaos.physics.uiowa.edu>
References: <200304160025.h3G0P52i009908@napali.hpl.hp.com>
	<Pine.LNX.4.44.0304160037130.4255-100000@chaos.physics.uiowa.edu>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 16 Apr 2003 00:43:06 -0500 (CDT), Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de> said:

  Kai> You're right that 32 bits would be enough to hold the
  Kai> CRC. However, we do not yet know the checksum at compile time,
  Kai> so the trick I came up with is to use the linker to fill in the
  Kai> crcs afterwards, using assignment to absolute values. So while
  Kai> the crcs appear to be numbers to the C code, they are handled
  Kai> like addresses from the linker side, and things would most
  Kai> likely go badly wrong if the sizes aren't equal, though I have
  Kai> to admit I didn't try.

Yes, it's not easy (possible) to do it in C, but I suspect most 64-bit
assemblers/linkers can do it.  For example, on ia64, you can do:

	.global foo

	data4 foo

Which will yield a DIR32LSB relocation (32-bit direct value), which is
exactly what we'd need here.

	--david
