Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262901AbSJWHtB>; Wed, 23 Oct 2002 03:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262903AbSJWHtB>; Wed, 23 Oct 2002 03:49:01 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:47118 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262901AbSJWHtA>; Wed, 23 Oct 2002 03:49:00 -0400
Date: Wed, 23 Oct 2002 08:55:02 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: peterc@gelato.unsw.edu.au
Cc: david@gibson.dropbear.id.au, linux-kernel@vger.kernel.org
Subject: Re: Ejecting an orinoco card causes hang
Message-ID: <20021023085501.A22736@flint.arm.linux.org.uk>
References: <15797.63740.520358.783516@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15797.63740.520358.783516@wombat.chubb.wattle.id.au>; from peterc@gelato.unsw.edu.au on Wed, Oct 23, 2002 at 11:18:52AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2002 at 11:18:52AM +1000, peterc@gelato.unsw.edu.au wrote:
> 4.  Transferring lots of data causes the link to collapse, and the
>     logs to fill up with `eth0: Error -110 writing Tx descriptor to
>     BAP' messages

I see type of behaviour this with an Orinoco Silver card while trying to
set the mode/essid.  I took the wvlan_cs code from my RH7.2 box and dropped
it into 2.5 - seems to work (although how reliable it is I don't know yet;
I need to get something for this card to talk to.)

   http://ftp.linux.org.uk/pub/linux/rmk/wireless/wvlan_cs-2.5.44.diff

Another difference that I noticed was that when no AP is in range, and the
ESSID has never been set, orinoco v0.07 reports "unspecified SSID!!!" as
the ESSID, as does wvlan_cs on the same RH7.2 kernel and with wvlan_cs on
2.5.44.  However, orinoco 0.13a reports an empty string.

Looking at the bytes read off the card, it seems that it returns a zero
length word, followed by the string "unspecified SSID!!!" with orinoco
0.13a.

Also, (iirc) I could make the card happier with the orinoco 0.13a driver
if I made it read excess bytes when reading the BAP (like wvlan_cs does.)
However, this didn't competely solve the problem - I still saw what I
think are firmware crashes.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

