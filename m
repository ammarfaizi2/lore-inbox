Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRADCX2>; Wed, 3 Jan 2001 21:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129324AbRADCXS>; Wed, 3 Jan 2001 21:23:18 -0500
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:48868 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S129267AbRADCXF>; Wed, 3 Jan 2001 21:23:05 -0500
Date: Wed, 03 Jan 2001 18:11:54 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: usb dc2xx quirk
To: "Dunlap, Randy" <randy.dunlap@intel.com>, josh <skulcap@mammoth.org>
Cc: linux-kernel@vger.kernel.org,
        l-u-d <linux-usb-devel@lists.sourceforge.net>
Message-id: <046801c075f3$b6211ce0$6600000a@brownell.org>
MIME-version: 1.0
X-Mailer: Microsoft Outlook Express 5.00.2314.1300
Content-type: text/plain; charset="iso-8859-1"
Content-transfer-encoding: 7bit
X-MSMail-Priority: Normal
X-MIMEOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
In-Reply-To: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDE9F@orsmsx31.jf.intel.com>
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The proximate cause of that Oops looked to be in one of the
> > UHCI drivers, but of course it's also possible that it was
> > triggered by driver misbehavior.
> 
> You didn't look hard enough.  8;)

I suspected you had ... :-)


> hub_thread got a disconnect event, called usb_disconnect,
> which tried to call driver->disconnect, which wasn't there
> due to using __devexit without CONFIG_HOTPLUG defined.

Ah, and <linux/init.h> moved the __devexit code into the
"__exit" segment, which got removed because clearly such
devices could never get removed (no hotplugging).


> > Have we identified anything that actually does anything with
> > code labeled __dev{in,ex}it (or data), beyond putting it into
> > a different section?  If so, what's it doing?
> 
> That's a great question.  I'd like to know the answer also.

(Calling it and oopsing ... sorry, wrong answer!  :-)


> Then we can see what the correct fixes should be.
> This patch could just be a short-lived 2.4.0-prerel
> fix-the-oops patch.

Put it into 2.4.0-next, sure.

I suspect the simplest thing is to say that no USB devices
should use those __dev{in,ex}it #defines ... we'd suspected
they were harmless; evidently not.

- Dave


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
