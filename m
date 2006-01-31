Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbWAaLLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbWAaLLG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 06:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbWAaLLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 06:11:06 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:59566 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1750747AbWAaLLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 06:11:05 -0500
Date: Tue, 31 Jan 2006 12:11:03 +0100
From: Martin Mares <mj@ucw.cz>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: j@bitron.ch, mrmacman_g4@mac.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jengelh@linux01.gwdg.de,
       James@superbug.co.uk, acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <mj+md-20060131.104748.24740.atrey@ucw.cz>
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com> <43D7A7F4.nailDE92K7TJI@burner> <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com> <43D7B1E7.nailDFJ9MUZ5G@burner> <20060125230850.GA2137@merlin.emma.line.org> <43D8C04F.nailE1C2X9KNC@burner> <43DDFBFF.nail16Z3N3C0M@burner> <1138642683.7404.31.camel@juerg-pd.bitron.ch> <43DF3C3A.nail2RF112LAB@burner>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43DF3C3A.nail2RF112LAB@burner>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jörg!

> It seems that you missunderstand this. No operating system uses file names
> internally.

That's right. OS kernels usually use pointers for that, which are surely
not a reasonable user-space API. On Linux, the user-space API is to address
devices by their names.

> OS instead typically handle SCSI devices that are not connected
> via an arbitraring Bus like the "Good old Parallel SCSI 50/68 pin" system
> by asuming they are all on separate SCSI busses that only have one single drive 
> conected each.
> 
> What Linux does is to artificially prevent this view to been seen from outside the
> Linux kernel, or to avoid integrating a particular device into a unique SCSI
> driver system although it would be apropriate.

How exactly does Linux prevent this???

The devices _are_ integrated in a single driver system, at least from the user-space
point of view. You can call open() on the device name and then send the appropriate
ioctl's. The device names are just strings you shouldn't assume anything about.

Feel free to imagine that every device is on its own bus, nothing in the
kernel steps in your way.

> Users like to be able to get a list of posible targets for a single protocol.
> Nobody would ever think about trying to prevent people from getting a unified
> view on the list possible hosts that talk TCP/IP.

How do you perform -scanbus for TCP/IP? :-)

> In addition, nobody would ever think about implementing a separate TCP/IP stack 
> for network interfaces that are PPP connections via a modem vs. network 
> interfaces that go via a Ethernet adaptor. Nobody would ever try to convince
> me that you could save code in the kernel by avoiding the usual network stack 
> as a specific machine may not have Ethernet but a Modem connection only.

There is an interesting similarity: in the TCP/IP stack, you also shouldn't
assume anything about names of network interfaces, they are just opaque
identifiers (in many times assigned by the administrator, not by the kernel).
The right way of addressing is by IP addresses or DNS names, which is
pretty similar to the addressing of SCSI devices on Linux, isn't it?

> If the Linux folks could give technical based explanations for the questions 
> from above and if they would create a new completely orthogonal view on SCSI [*]
> I had no problem. But up to now, the only answer was: "We do it this 
> way because we do it this way". 

We do it this way, because we see no sense in fabricating virtual SCSI
buses, which do not exist in reality.

Also, I don't see a single reason why should I refer to my CD drive by
different names depending on whether I am mounting a CDROM and if I am
burning a CD. The device is still the same and so should be its name.

Scanning for all available CD burners is of course a nice feature, but
I don't think it should be implemented by asking all existing SCSI-like
devices if they are a CD burner (for example because there can be an
almost infinite number of them, given that you can do SCSI-over-IP
and other similar tricks). The problem of presenting devices to the
users is in no way limited to CD burners or SCSI devices, it's a general
problem and I think we should try to find a complete solution. However,
the approach libscg uses is clearly not applicable to other domains.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"Anyone can build a fast CPU. The trick is to build a fast system." -- S. Cray
