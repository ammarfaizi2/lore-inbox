Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264231AbTDPFbZ (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 01:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264232AbTDPFbY 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 01:31:24 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:3004 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id S264231AbTDPFbX (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 16 Apr 2003 01:31:23 -0400
Date: Wed, 16 Apr 2003 00:43:06 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: davidm@hpl.hp.com
cc: linux-kernel@vger.kernel.org
Subject: Re: size of CRCs in module versions
In-Reply-To: <200304160025.h3G0P52i009908@napali.hpl.hp.com>
Message-ID: <Pine.LNX.4.44.0304160037130.4255-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Apr 2003, David Mosberger wrote:

> What's the point of using "unsigned long" for storing module version
> CRCs?  As far as I can see, the CRCs are 32 bits in size, so using u32
> would be more appropriate (and would avoid wasting space on 64-bit
> platforms).

You're right that 32 bits would be enough to hold the CRC. However, we do 
not yet know the checksum at compile time, so the trick I came up with is 
to use the linker to fill in the crcs afterwards, using assignment to 
absolute values. So while the crcs appear to be numbers to the C code, 
they are handled like addresses from the linker side, and things would 
most likely go badly wrong if the sizes aren't equal, though I have to 
admit I didn't try.

--Kai


