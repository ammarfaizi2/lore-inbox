Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262747AbRFQUVt>; Sun, 17 Jun 2001 16:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262829AbRFQUVj>; Sun, 17 Jun 2001 16:21:39 -0400
Received: from ns.suse.de ([213.95.15.193]:28425 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S262747AbRFQUV3>;
	Sun, 17 Jun 2001 16:21:29 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Client receives TCP packets but does not ACK
In-Reply-To: <E15BiHy-0002xC-00@the-village.bc.nu.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 17 Jun 2001 22:21:27 +0200
In-Reply-To: Alan Cox's message of "17 Jun 2001 21:39:32 +0200"
Message-ID: <oupd782rh6g.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > > Specifically
> > > 1.	If the receiver closes and there is unread data many TCP's forget
> > > 	to RST the sender to indicate that data was lost.
> > 
> > Do at least FreeBSD, Solaris and NT sent RST correctly?
> 
> I dont believe so

There is also a different bug in Linux that makes the application not notice
errors. When it does a close() and an error occurs while flushing buffered
data and doing the FIN handshake it is not returned by close() (no matter
if linger time hits or not). Most transaction applications like SMTP fortunately 
use an own ACKing protocol, which works around that.

-Andi
