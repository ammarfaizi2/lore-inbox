Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272791AbTHKQRM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 12:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272781AbTHKQRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 12:17:06 -0400
Received: from werbeagentur-aufwind.com ([217.160.128.76]:59835 "EHLO
	mail.werbeagentur-aufwind.com") by vger.kernel.org with ESMTP
	id S272791AbTHKQQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 12:16:25 -0400
Subject: Re: [PATCH] loop: fixing cryptoloop troubles.
From: Christophe Saout <christophe@saout.de>
To: Fruhwirth Clemens <clemens-dated-1061471465.e213@endorphin.org>
Cc: Pascal Brisset <pascal.brisset-ml@wanadoo.fr>,
       linux-kernel@vger.kernel.org, mbligh@aracnet.com, kernel@gozer.org,
       axboe@suse.de
In-Reply-To: <20030811131105.GA2040@ghanima.endorphin.org>
References: <20030810023606.GA15356@ghanima.endorphin.org>
	 <20030810140912.6F7224007E9@mwinf0301.wanadoo.fr>
	 <1060525667.14835.4.camel@chtephan.cs.pocnet.net>
	 <20030810210306.GA2235@ghanima.endorphin.org>
	 <1060553236.25524.49.camel@chtephan.cs.pocnet.net>
	 <20030811131105.GA2040@ghanima.endorphin.org>
Content-Type: text/plain
Message-Id: <1060618570.4090.29.camel@chtephan.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 11 Aug 2003 18:16:10 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mo, 2003-08-11 um 15.11 schrieb Fruhwirth Clemens:

> > The main problem with CBC is that you can't really do it. It only works
> > when you have a constant stream of data because you always need the
> > result from the previous encryption which you don't have when doing
> > something in the middle of the block device.
> 
> That's partially correct. As most block cipher operate on blocks of 16 bytes
> size it perfectly makes sence to use CBC on a 512 byte block. 

Ah, you're right, I didn't look at it enough to see that the loop in
cipher.c only handles bsize bytes at once.

> > The cryptoloop code is doing things correctly. In ecb mode, every bio
> > could get converted at once, or every bvec. 
> 
> ECB mode is broken in 2.6.0-test[12].

I was speaking theoretically ;)

> It's a quite conservative patch. ECB processing can be optimized.

Yes, you're not restricted to split the request into 512 byte chunks.
But I don't think it's too much of a performance loss. Or should it
better be handled differently? Because I'm not doing it either in my
code.

> Definitly. loop.c is anyway ugly :). It would be nice to rip out the
> block-backend stuff of loop.c and recommend to use device mapper instead.
> loop.c will benefit from that for sure since it doesn't have to handle two
> different case in such a schizophrenic manner.

That's right. I could also write a losetup-like user space utility that
sets up a linear mapped device with the full size of the block device
and optionally uses encryption.

What do you think of this passphrase thing? I could optionally link a
against openssl or such a library to offer password hashing.

> I'll give it a try, promised :)

That'd be nice. :)

--
Christophe Saout <christophe@saout.de>
Please avoid sending me Word or PowerPoint attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html

