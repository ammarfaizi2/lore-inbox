Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272197AbRJGLMW>; Sun, 7 Oct 2001 07:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276302AbRJGLMN>; Sun, 7 Oct 2001 07:12:13 -0400
Received: from [193.252.19.44] ([193.252.19.44]:59271 "EHLO
	mel-rti19.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S272197AbRJGLMC>; Sun, 7 Oct 2001 07:12:02 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: <linux-kernel@vger.kernel.org>, <linux-xfs@oss.sgi.com>
Subject: Re: %u-order allocation failed
Date: Sun, 7 Oct 2001 13:12:02 +0200
Message-Id: <20011007111202.17296@smtp.wanadoo.fr>
In-Reply-To: <Pine.LNX.3.96.1011007003227.18004B-100000@artax.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.3.96.1011007003227.18004B-100000@artax.karlin.mff.cuni.cz>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>You are right. Code that allocates more than page and expects it to be
>physicaly contignuous is broken by design. Even rewrite the driver or
>allocate memory on boot. It will be very hard to audit all drivers for it.

Well, the problem here is not code. Some piece of hardware just can't
scatter gather, or in some case, they can, but the scatter/gather list
itself has to be contiguous and can be larger than a page.

The fact that kmalloc returns physically contiguous memory is a feature
and can't be modified that easily. If you intend to do so, then you need
different GFP flags, for example a GFP_CONTIGUOUS flag, and then make
sure that drivers allocating DMA memory use that new flag.

Ben.


