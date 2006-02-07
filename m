Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964949AbWBGD3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964949AbWBGD3h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 22:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964950AbWBGD3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 22:29:36 -0500
Received: from clix.aarnet.edu.au ([192.94.63.10]:47307 "EHLO
	clix.aarnet.edu.au") by vger.kernel.org with ESMTP id S964949AbWBGD3f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 22:29:35 -0500
Message-ID: <43E813BC.8060003@aarnet.edu.au>
Date: Tue, 07 Feb 2006 13:57:56 +1030
From: Glen Turner <glen.turner@aarnet.edu.au>
Organization: Australia's Academic & Research Network
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Krzysztof Halasa <khc@pm.waw.pl>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: 8250 serial console fixes -- issue
References: <1138844838.5557.17.camel@localhost.localdomain> <43E2B8D6.1070707@aarnet.edu.au> <20060203094042.GB30738@flint.arm.linux.org.uk> <43E36850.5030900@aarnet.edu.au> <20060203160218.GA27452@flint.arm.linux.org.uk> <m3lkwse3nz.fsf@defiant.localdomain> <20060203221346.GA10700@flint.arm.linux.org.uk> <m3mzh7ds45.fsf@defiant.localdomain> <20060204232005.GC24887@flint.arm.linux.org.uk> <43E56D14.80808@aarnet.edu.au> <20060206094740.GA9388@flint.arm.linux.org.uk>
In-Reply-To: <20060206094740.GA9388@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-MDSA: Yes
X-Spam-Score: -104.901 BAYES_00,USER_IN_WHITELIST
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

> I think we're agreed (differently wired serial cables) as to why using
> the 'r' option to also monitor DSR would be a bad idea.

We are.  We need a caveat in the documentation reminding
users of 'r' the consequences of letting CTS float, but
that is all.

> A possible solution to this problem may be to have the additional
> option as you have suggested.  Whether it should be the same option
> as (1) above or not is debatable.

I think the same option will work -- let's define 'm' as
being "strictly observe modem status signals (ie, DSR and
DCD)".

'm' them implies:
  - all other modem signals (CTS and DCD) are undefined
    if DSR is not asserted.
  - transmission will only be allowed if DSR and DCD are
    both asserted at the instant when the character is
    ready for transmission.  There may be additional
    restrictions on transmission from flow control.
    Unlike flow control, the kernel never waits for
    the modem status signals to become asserted, but
    instantly discards the character.

'r' remains the same, namely
  - if CTS is asserted then the character is transmitted.
    Noting that 'm' additionally implies that CTS is only
    defined when DSR is asserted.
  - if 'r' is specificed and CTS is not asserted the
    transmitter will wait a limited period for CTS to
    become asserted.  If CTS is not asserted within this time
    then the character is discarded.

[As you can see I've changed the suggested option character. Perhaps
  's' as an option is just too easily confused with the 's' in 'ttyS'.]

> The advantage of the CRLF patch I posted previously is that we can now
> do a lot of the above in common code, which will fix a lot of serial
> drivers at the same time.

I had noticed that and it's a fine idea.

Depending on your timetable, if you agree with the above and
wait a few days I'll send a patch building atop your patch
and implementing the above.  I'm sorry I can't do that at
this moment, but I'm bandwidth-deprived.  Of course, being
much more experienced in this sort of thing you may have
already whipped something up :-)

Regards,
Glen

-- 
  Glen Turner         Tel: (08) 8303 3936 or +61 8 8303 3936
  Australia's Academic & Research Network  www.aarnet.edu.au
