Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263152AbSJBQbi>; Wed, 2 Oct 2002 12:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263153AbSJBQbi>; Wed, 2 Oct 2002 12:31:38 -0400
Received: from copper.ftech.net ([212.32.16.118]:51164 "EHLO relay5.ftech.net")
	by vger.kernel.org with ESMTP id <S263152AbSJBQbg>;
	Wed, 2 Oct 2002 12:31:36 -0400
Message-ID: <7C078C66B7752B438B88E11E5E20E72E0EF567@GENERAL.farsite.co.uk>
From: Kevin Curtis <kevin.curtis@farsite.co.uk>
To: "'Francois Romieu'" <romieu@cogenit.fr>, linux-kernel@vger.kernel.org
Subject: RE: Generic HDLC interface continued
Date: Wed, 2 Oct 2002 17:30:03 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	sorry that I am miles behind the discussion.  I'll try and keep up
in future.  I think I raised this with Krzysztof on Friday when I noted that
hdlc-2.4.19a.patch seemed to change the configuration interface, and the
utility we use to configure the FarSync card now no longer worked.

	We used the type, data pointer and length in the following way:

If the type indicated that the information was for the card (i.e. not the
driver), then this was passed by a pointer and length to the driver, which
then copied it into shared memory so that the card could then pick it up.
The format of the information was between the utility and the card itself.

Now, when I looked at mapping this into the new structure I had a bit of
difficulty.  I asked if the mechanism could be re-instated.

Surely we could find room for these three items somewhere in the new
structure???

struct if_settings
{
	unsigned int type;	/* Type of physical device or protocol */
	unsigned int data_length; /* device/protocol data length */
	void * data;		/* pointer to data, ignored if length = 0 */
};



Kevin

-----Original Message-----
From: Francois Romieu [mailto:romieu@cogenit.fr]
Sent: 30 September 2002 21:55
To: linux-kernel@vger.kernel.org
Subject: Re: Generic HDLC interface continued


Krzysztof Halasa <khc@pm.waw.pl> :
[...]
> Not exactly. The caller always knows meaning of the returned value
> (or it reports error etc). The caller doesn't just know size of the value
> _in_advance_, as it isn't constant. Still, meaning of the variable portion
> of the data is defined by the constant part.

The caller doesn't know size in advance but he gets 'type' and 'size' at
the same time. Why shouldn't 'size' be deduced from 'type' ?

-- 
Ueimor
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
