Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317096AbSG1Sqq>; Sun, 28 Jul 2002 14:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317101AbSG1Sqp>; Sun, 28 Jul 2002 14:46:45 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:55797 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317096AbSG1Sqo>; Sun, 28 Jul 2002 14:46:44 -0400
Subject: Re: n_tty.c driver patch (semantic and performance correction) (a
	ll recent versions)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: rwhite@pobox.com
Cc: Andries Brouwer <aebr@win.tue.nl>, Russell King <rmk@arm.linux.org.uk>,
       Ed Vance <EdV@macrolink.com>, "'Theodore Tso'" <tytso@mit.edu>,
       linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
In-Reply-To: <200207271934.27102.rwhite@pobox.com>
References: <11E89240C407D311958800A0C9ACF7D13A789A@EXCHANGE>
	<200207271507.56873.rwhite@pobox.com> <20020727232129.GA26742@win.tue.nl> 
	<200207271934.27102.rwhite@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 28 Jul 2002 21:04:36 +0100
Message-Id: <1027886676.790.5.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-07-28 at 03:34, Robert White wrote:
> Having virtually every user on the planet realize this and just set VMIN == 1 
> is an fairly telling indicator.
> 
> Repeatedly calling the kernel to assemble an input buffer which is necessary 
> if VMIN ==1, is dumb.

VMIN was basically invented for communication protocols when you know
the block length that should arrive within a given timeout. Its pretty
much essential on old old boxes and was very important for
interrupt/context switch reduction when doing block transfers. In that
world the read blocks or in O_NDELAY returns -EAGAIN (0 in old SYS5)
until the data block is big enough to warrant its copying. Similarly
poll has no business saying data is ready until a large enough block is.

When talking to a human setting VMIN > 1 makes no sense anyway. In fact
nowdays it makes even less sense than it did before because of the use
of UTF8 encodings for unicode characters.


