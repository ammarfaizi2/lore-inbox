Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263774AbTKXMFU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 07:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbTKXMFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 07:05:20 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:63699 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S263774AbTKXMFN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 07:05:13 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 24 Nov 2003 12:46:20 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>
Cc: kksubramaniam@novell.com, linux-kernel@vger.kernel.org
Subject: Re: Fix for "MT2032 Fatal Error: PLLs didn't lock"
Message-ID: <20031124114620.GA29771@bytesex.org>
References: <20031124004835.3abbb4cf.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031124004835.3abbb4cf.akpm@osdl.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I saw others report same issues but didnt see any
> fixes/patches/solutions. With the debug option on for bttv and tuner in
> /etc/modules.conf and the TV frequency set to 133.25MHz and then
> 140.25MHz, the sign extension defect pops up in rfin value below. This
> is because 133.25MHz is 0x7F13BD0 and 140.25MHz is 0x85C0B90. The high
> bit gets sign extended in as 0xFFFFFFFFF85C0B90 (-128185456)

Huh?  I can't see where a sign extension happens.  0x85C0B90 has the bit
#27 set to one, not #31 ...

Beside that the values are passed around as unsigned values everythere.
Can you please explain in more detail what is going on?

> Nov 16 21:45:56 localhost kernel: tuner: tv freq set to 133.25
> Nov 16 21:45:56 localhost kernel: mt2032_set_if_freq rfin=133250000
> if1=1090000000 if2=38900000 from=32900000 to=39900000

> Nov 16 21:45:58 localhost kernel: tuner: tv freq set to 140.25
> Nov 16 21:45:58 localhost kernel: mt2032_set_if_freq rfin=-128185456
> if1=1090000000 if2=38900000 from=32900000 to=39900000

Works fine here:

tuner: tv freq set to 140.25
mt2032_set_if_freq rfin=140250000 if1=1090000000 if2=38900000 from=32900000 to=39900000

>  	case VIDIOCSFREQ:
>  	{
> -		unsigned long *v = arg;
> +		unsigned int *v = arg;

Wrong, VIDIOCSFREQ is "_IOW('v',15, unsigned long)".  Beside that I'm
very surprised that this actually makes a difference.  What architecture
is that?  And what size int/long have there?

> -				(*iarg)/16,(*iarg)%16*100/16);
> +				(*v)/16,(*v)%16*100/16);

That is ok.

  Gerd

-- 
You have a new virus in /var/mail/kraxel
