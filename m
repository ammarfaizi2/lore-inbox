Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269254AbRGaLNC>; Tue, 31 Jul 2001 07:13:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269255AbRGaLMm>; Tue, 31 Jul 2001 07:12:42 -0400
Received: from mail.teraport.de ([195.143.8.72]:36739 "EHLO mail.teraport.de")
	by vger.kernel.org with ESMTP id <S269254AbRGaLMh>;
	Tue, 31 Jul 2001 07:12:37 -0400
Message-ID: <3B6692A7.BF68CB74@TeraPort.de>
Date: Tue, 31 Jul 2001 13:12:39 +0200
From: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-ac3 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
CC: pworach@mysun.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: eepro100 2.4.7-ac3 problems (apm related)
In-Reply-To: <Pine.LNX.4.33.0107311246360.3857-100000@chaos.tp1.ruhr-uni-bochum.de>
X-MIMETrack: Itemize by SMTP Server on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 07/31/2001 01:11:56 PM,
	Serialize by Router on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 07/31/2001 01:12:03 PM,
	Serialize complete at 07/31/2001 01:12:03 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Kai Germaschewski wrote:
> 
> On Tue, 31 Jul 2001, Martin Knoblauch wrote:
> 
> > > The eepro100 interface in my Fujitsy/Siemens Lifebook S-4546
> > > won't come up after a suspend, if I unload the module and load it again
> > > it works fine...
> > > "ioctl SIOCSIFFLAGS: No such device" is the error message.
> >
> >  same here with an eepro100 inside a IBM Thinkpad570. Happened with
> > 2.4.6-ac2. Since then I apply the appended patch after installing "-ac"
> > stuff. This completely disables power state handling for the device. Not
> > very clean, but I do not care in this particular case. It probably shows
> > a more principal issue with the eepro100. Kai - did you look deeper into
> > the issue?
> 
> I didn't look to deep, since my eepro100 works fine here, so I can't
> reproduce your problem.
> 
> However, I'm wondering if the problems you guys are having are really the
> same. IIRC, Martin's eepro100 wouldn't ever come up from state D2 into
> working state again until the next reboot, right?
>

 You may be 101% right and the problems are not identical, but something
seems to be fishy around eepro100 in notebooks and powersaving. Just
curious - is your working eepro100 in a notebook or in a "traditional"
server/desktop?
 
> Whereas Pawel's eepro100 can be revived by reloading the module, so there
> seems to be a difference. For Pawel, can you supply lspci -vvxxx output
> before and after the suspend. That should give some hints.
> 
> Martin, if you want to spend some work on your problem, you could try to
> collect some more data an your problem, particularly what about using
> another state (D1/D3) when the interface is down. D3 will probably mean
> that you have to save/restore PCI config space, so it's a bit more
> tedious. Also, is there anything which makes your card work again after it
> was in state D2? Like suspend/resume, or putting it into D3 and back into
> D0? Does a warm reboot suffice, or do you need to power cycle.
>

 As I said before, whatever I can do... Care to tell me (offline) where
to put the save/restore stuff?

 In any case, I always need a cold reboot to revive the interface. Cold,
because the fu..... notebook has problems to do warm reboots. I guess
that has nothing to do with the eepro100 though.

> As it stands, I don't see an alternative to Martin's problem apart from
> the patch he's using - well, that could be done a bit more nicely, like
> having a config option for the sleep D state, which would increase chances
> Alan would take it as an -ac patch.
> 

 Actually, my little patch is in no way intended for inclusion. Just to
make my interface work again. If it helps others, wonderful. But the
real solution would be to find the root cause and fix it.

Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
