Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262750AbTCPUUy>; Sun, 16 Mar 2003 15:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262751AbTCPUUy>; Sun, 16 Mar 2003 15:20:54 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:62430
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262750AbTCPUUx>; Sun, 16 Mar 2003 15:20:53 -0500
Subject: Re: Any hope for ide-scsi (error handling)?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: wrlk@riede.org
Cc: Zwane Mwaikambo <zwane@holomorphy.com>,
       dan carpenter <d_carpenter@sbcglobal.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030316005556.GM7082@linnie.riede.org>
References: <Pine.LNX.4.50.0303151343140.9158-100000@montezuma.mastecende.com>
	 <200303151926.h2FJQLnB103490@pimout1-ext.prodigy.net>
	 <Pine.LNX.4.50.0303151453010.9158-100000@montezuma.mastecende.com>
	 <200303152012.h2FKCulK283698@pimout2-ext.prodigy.net>
	 <Pine.LNX.4.50.0303151519240.9158-100000@montezuma.mastecende.com>
	 <20030315210120.GI7082@linnie.riede.org>
	 <1047777805.1327.23.camel@irongate.swansea.linux.org.uk>
	 <20030316005556.GM7082@linnie.riede.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047850871.21610.9.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 16 Mar 2003 21:41:12 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-03-16 at 00:55, Willem Riede wrote:
> I hear you, and I will take a hard look at that code. But please
> realize, that if we get to this code segment, the drive has _not_ 
> responded to the regular command and is in an _unknown_ state.

Indeed. The error/abort distinction is more about locking/recovery
than drive level semantics. We will still issue an ATAPI reset and
if need be fall back to an ATA reset. What we handle differently is
the assumption that the drive status registers are valid (they are
not), that we are in an interrupt handle an IDE phase (we are not)
and that we want to recovery/reissue or issue the next command
from this context.

