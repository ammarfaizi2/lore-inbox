Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269645AbRIYVn5>; Tue, 25 Sep 2001 17:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269641AbRIYVns>; Tue, 25 Sep 2001 17:43:48 -0400
Received: from mail.zmailer.org ([194.252.70.162]:10765 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S269326AbRIYVnc>;
	Tue, 25 Sep 2001 17:43:32 -0400
Date: Wed, 26 Sep 2001 00:43:45 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Karel Kulhavy <clock@atrey.karlin.mff.cuni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ethernet Error Correction
Message-ID: <20010926004345.D11046@mea-ext.zmailer.org>
In-Reply-To: <20010925223437.A21831@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010925223437.A21831@atrey.karlin.mff.cuni.cz>; from clock@atrey.karlin.mff.cuni.cz on Tue, Sep 25, 2001 at 10:34:37PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2001 at 10:34:37PM +0200, Karel Kulhavy wrote:
> What about implementing an Ethernet error correction in Linux kernel?

	Wrong layer.

	Ok, IF you run it at physical interfaces, then yes, maybe.

> Does exist any standard that would normalize ethernet error correction?
> The situation is basically this:

	No, It is very hardware specific.
 
> Let's say I have two PC's, with ethernet NIC's. An atmospherical optical
> link (full duplex) is between them, connected via AUI. The optics goes
> crazy when there is a fog of course. But dropping a single bit in 1500
> bytes makes a lot of mess.  There is also unsused src and dest address
> (12 bytes) which is obvious and superfluous.

	MAC-level addresses ?  Right.

> What about kicking the address off and putting some error correction codes
> (like Hamming) into it and putting the cards into promisc mode?

	You will need a lot more than 12 octet of hamming code
	in that link for a 1500 octet frame.  The 12 octets might
        barely be enough to tell that a bit has flipped.

	Also, generic PROMISC mode still drops off received frames
	with CRC error.

	Being able to send larger frames, say 2000 - 3000 octets,
	might help more.  That enables doing heavy duty FEC.
	Essentially Reed-Solomon.

	Being able to receive those frames is a requirement, as
	well as being able to receive damaged frames.

	Loosing frame start might not be recoverable at this
	level, though.

> It would make the link work on bigger distance and on thicker mist.
> We could even dynamically change the ECC/data ratio for example with
> Reed Solomon Codes. Ethernet modulation is strong gainst sync dropouts
> so the bits usually remain their place, just some of them happen to flip.
> We could also kick the "lenght" field because end of packet is recognized
> by a pulse longer than 200ns, not neither by ECC nor by the length
> (am I right?).

	You mean the  length/type  field ?

	Better would be to use FEC hardware plugged into the AUI
	port.  Buffering/rate adaptation are also an issue.
	That is, Ethernet card sends the data at nominal rate of
	10 Mbps, but FEC processing adds another set of data on
	the link essentially doubling the data to be sent.
	Now there is a problem of sending generated 20 Mbps
	datastream thru final 10 Mbps optical link.

	Not a trivial thing at all.

	Perhaps modifying the interface card to use halved
	frequency chrystal at the interface cards, and then
	full speed at FEC output.

> Is anybody eager to implement this into the kernel? How would it be done
> at all? I have personally no idea.

	No.  Silicon is cheap and available.
	Furthermore, I see no real advantage at this when compared
	with e.g. 2 Mbps 802.11 radiolink at 2.4 GHz.  Use there
	the nominal 20-100 mW power, and good directional antennas.

	That hardware is half-duplex, but you can have a pair working
	at different frequencies.

	Instead of using standard spreading sequences, use something
	else -- the art of finding those is quite demanding.  Those
	sequences must be such that they have maximum code-distance
	from standard codes, and simultaneously fulfill the primarility
	condition of the sequence -- it must have long period.

	The IEEE 802.11 standard covers this quite well.


	The radio approach is equally complicated as is making
	special interface cards speaking with silicon FEC out
	from an AUI port.


> Clock

/Matti Aarnio
