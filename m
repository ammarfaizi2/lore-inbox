Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274972AbRJFEdL>; Sat, 6 Oct 2001 00:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274983AbRJFEdC>; Sat, 6 Oct 2001 00:33:02 -0400
Received: from sushi.toad.net ([162.33.130.105]:39297 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S274972AbRJFEcy>;
	Sat, 6 Oct 2001 00:32:54 -0400
Subject: Re: inux should not set the "PnP OS" boot flag
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14 (Preview Release)
Date: 06 Oct 2001 00:32:55 -0400
Message-Id: <1002342777.813.102.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I append a short patch
> to remove the bit of code that sets the boot flag.  (I see where
> the function also zeroes out the sbf value if it appears not to be
> a valid value.  That seems rather rash to me, but I leave it
> alone because I don't understand why it's there.)

I see also that in that function:

--------------------------------------------------------
static void __init sbf_bootup(void)
{
	u8 v = sbf_read();
	if(!sbf_value_valid(v))
		v = 0;
#if defined(CONFIG_PNPBIOS)
	/* Tell the BIOS to fast init as we are a PnP OS */
	v |= (1<<0);	/* Set PNPOS flag */
#endif
	sbf_write(v);
}
--------------------------------------------------------

there is a parity check (in the sbf_value_valid function)
prior to changing one of the bits, but there is no check to make
sure that the parity is still correct after the "PNPOS" flag
has been set.  Is this okay?  Or am I confused about something?

--
Thomas Hood


