Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261667AbVGZJ4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbVGZJ4k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 05:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbVGZJ4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 05:56:40 -0400
Received: from web30308.mail.mud.yahoo.com ([68.142.200.101]:27543 "HELO
	web30308.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S261670AbVGZJzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 05:55:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=TmGiSuCYEUn8HbjoDTChCy1j6aXEFaFd2bjbFkR5RYswyF1v7nuWkirLjzQ+gsifmR8zClu3lb6iSkO13o2sCOgoJm5Zm3JF2tPKlsZYLyMUuAchv6+OtNTe/fvvO2paY6B9uEUcvLZ2ZBJKWV8hb7ytVAN7vj4LRvwZxEXgY6s=  ;
Message-ID: <20050726095535.95521.qmail@web30308.mail.mud.yahoo.com>
Date: Tue, 26 Jul 2005 10:55:35 +0100 (BST)
From: Mark Underwood <basicmark@yahoo.com>
Subject: Re: Linux tty layer hackery: Heads up and RFC
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050722145716.GA3332@bitwizard.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rogier,

Having just written a DMA UART driver I can say this
is good news :-). Here are some things to think about:

What my driver would like to do is to handle its own
input buffers. It would pass the buffer to the tty
layer when it is full and the tty layer would pass the
buffer back once it has drained the data from it.
The problem is that I don't always receive a block
worth of characters so I also need to pass the tty
layer a buffer (which I'm still DMAing into) with a
count of how many chars there are in the buffer and a
offset of where to start from. If I can't do this then
I have to stop the DMA transfer, pass you a mostly
empty buffer with a char count, and setup DMA transfer
into another buffer. If during this I get a burst of
data I could well lose it :-(.

Best Regards,

Mark

--- Rogier Wolff <R.E.Wolff@BitWizard.nl> wrote:

> On Thu, Jul 21, 2005 at 06:46:32PM +0100, Alan Cox
> wrote:
> > int tty_prepare_flip_string(tty, strptr, len)
> > 
> > Adjust the buffer to allow len characters to be
> added. Returns a buffer
> > pointer in strptr and the length available. This
> allows for hardware
> > that needs to use functions like insl or
> mencpy_fromio.
> 
> Ok, So then I start copying characters into the
> flipstring, but how do
> I say I'm done?
> 
> Or is there a race between that I call
> tty_prepare_flip_string, and
> other processes start pulling my not-yet-filled
> string from the
> buffer? (Surely not!)
> 
> 	Roger. 
> 
> -- 
> ** R.E.Wolff@BitWizard.nl **
> http://www.BitWizard.nl/ ** +31-15-2600998 **
> *-- BitWizard writes Linux device drivers for any
> device you may have! --*
> Q: It doesn't work. A: Look buddy, doesn't work is
> an ambiguous statement. 
> Does it sit on the couch all day? Is it unemployed?
> Please be specific! 
> Define 'it' and what it isn't doing. ---------
> Adapted from lxrbot FAQ
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



	
	
		
___________________________________________________________ 
Yahoo! Messenger - NEW crystal clear PC to PC calling worldwide with voicemail http://uk.messenger.yahoo.com
