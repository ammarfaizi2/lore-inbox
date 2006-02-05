Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932472AbWBEDOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbWBEDOM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 22:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbWBEDOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 22:14:11 -0500
Received: from clix.aarnet.edu.au ([192.94.63.10]:5076 "EHLO
	clix.aarnet.edu.au") by vger.kernel.org with ESMTP id S1946153AbWBEDOK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 22:14:10 -0500
Message-ID: <43E56D14.80808@aarnet.edu.au>
Date: Sun, 05 Feb 2006 13:42:20 +1030
From: Glen Turner <glen.turner@aarnet.edu.au>
Organization: Australia's Academic & Research Network
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Krzysztof Halasa <khc@pm.waw.pl>
CC: Russell King <rmk+lkml@arm.linux.org.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 8250 serial console fixes -- issue
References: <Pine.LNX.4.44.0602011911360.22854-100000@gate.crashing.org> <1138844838.5557.17.camel@localhost.localdomain> <43E2B8D6.1070707@aarnet.edu.au> <20060203094042.GB30738@flint.arm.linux.org.uk> <43E36850.5030900@aarnet.edu.au> <20060203160218.GA27452@flint.arm.linux.org.uk> <m3lkwse3nz.fsf@defiant.localdomain> <20060203221346.GA10700@flint.arm.linux.org.uk> <m3mzh7ds45.fsf@defiant.localdomain> <20060204232005.GC24887@flint.arm.linux.org.uk>
In-Reply-To: <20060204232005.GC24887@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-MDSA: Yes
X-Spam-Score: -104.901 BAYES_00,USER_IN_WHITELIST
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

> The problem being discussed in this sub-thread was explicitly related
> to just one case - where a _non root_ user may inject AT command
> sequences.  Your response in that thread was throwing up random
> other issues, and in that respect it's just adding confusion to
> the specific issue being discussed.

Hello Krzysztof,

We closed that out.  I was wrong.  Covert channels are handled
by kernel programmers being careful not to put user-controllable
data in kprintf() stings.  And that makes a lot of sense if you
think about the havoc that covert channels could also cause with
ANSI console (and their redefinable keys) and UTF-8 consoles
(and that character set's large number of easily-confused glyphs).
It might be nice to have the kernel audited for such kprintf()
strings but that is not something that needs discussion with
Russell.

I'm happy to admit error -- I don't do kernel coding and I expect
to make some mistakes.  I just hope to handle them graciously.
With that in mind I'd like to apologise to Russell for claiming
it was a bug.


The serial console still should not write into an unasserted
DSR or DCD since that will hang up on incoming calls. But
they's a totally different, non-security issue.  Which isn't
to say that it's not frustrating for the sysadmin who can't
connect to their misbehaving system.

I think the open issues are:

  1. kernel messages causing modems to hang up during
     the initial training period of the connection.

  2. slow kernel boot times with 'r' option.

For (2) Russell is saying "don't do that".  I am struggling
with what is the meaning of the 'r' option then.  If it is
"I want my kernel console to try to not drop any kernel
messages" then is it reasonable to restrict that to directly
connected machines and disallow the use of the facility with
modems and console servers?

I'm also unsure of the robustness equipment in the face
of Russell's suggestion. The suggestion implies that the
kernel will write strings when CTS is unasserted.  There
is some allowance for that in receivers that are configured
for RTS/CTS flow control, but it that allowance being overly
stressed?  And does it matter if the modem or the receiver
drops some characters?  Is there popular equipment for which
this is a pathological case?

I don't know the answer and have not had much time to think
Russell's suggestion through properly and no time at all
to run it against some popular modems and terminal servers.
Which is why I have not replied.  I am spending the next two
days on airplanes, so there is plenty of time for thinking
then but no time for testing.

I would probably prefer two flags -- 'r' meaning flow control
(CTS) and a new option, say 's', meaning modem status (DSR,DCD).
That would nicely allow backwardly-compatible behaviour and
support a wide range of RS-232 cables and equipment.  But
I want think through and test Russell's suggested interpretation
of the 'r' flag first.

> BTW I think you know all of this very well for years.

I don't know what you were thinking when you wrote this.  But
it is stupid.  It's one thing to be technically wrong  -- all
that is required to fix that is some patience on both sides.
And Russell has been very patient with me, which I appreciate.

It's totally another thing entirely to be insulting.  What
do you now think are the chances of people working together
harmoniously to have the open issues satisfactorily resolved?

What do I say to the readers of the HOWTO about the shortcomings
of the serial console implementation?  I can hardly write that
LKML discussed the issue, but the participants in the mailing
list preferred sly insults over closing the issues that HOWTO
readers had reported.

I don't in any way have a problem with the years this has
taken to get an airing.  I have a day job, and that is not
kernel patch wrangling, so it is not like people are going
to even notice my e-mail in the noise of LKML.  I am not
known to the community. My code probably sucks, despite my
best efforts.  I expect people to be questioning, just as
I am of e-mails from unknown people with 'improvements' to
router behaviour.

Regards,
Glen

-- 
  Glen Turner         Tel: (08) 8303 3936 or +61 8 8303 3936
  Australia's Academic & Research Network  www.aarnet.edu.au
