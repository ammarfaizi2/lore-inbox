Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262430AbSKKMeI>; Mon, 11 Nov 2002 07:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262460AbSKKMeI>; Mon, 11 Nov 2002 07:34:08 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:28835 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262430AbSKKMeI>; Mon, 11 Nov 2002 07:34:08 -0500
Subject: Re: [PATCH] NCR53C9x ESP: C99 designated initializers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: geert@linux-m68k.org, hch@infradead.org,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dledford@redhat.com
In-Reply-To: <20021111.014328.87369858.davem@redhat.com>
References: <1036939080.1005.10.camel@irongate.swansea.linux.org.uk>
	<Pine.GSO.4.21.0211111029030.20946-100000@vervain.sonytel.be> 
	<20021111.014328.87369858.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 11 Nov 2002 13:05:25 +0000
Message-Id: <1037019925.2887.21.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-11-11 at 09:43, David S. Miller wrote:
> That's a little inconvenient.
> 
> I have to wait for an interrupt from the chip to know the RESET
> started by the eh_reset_bus_handler code is done, and I'm certainly
> not going to spin there for 5 seconds or however long it decides to
> take. :-)

Lots of drivers do

> Either eh_reset_bus_handler needs to be allowed to sleep, or it needs
> to be changed so that an "RESET in progress, please wait" status can
> be returned.

The stupid thing is we take the lock then call the eh function then drop
it. You can drop the lock, wait and retake it. I need to fix a couple of
other drivers to do a proper wait and in much the same way.


