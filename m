Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266678AbTAINY7>; Thu, 9 Jan 2003 08:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266693AbTAINY7>; Thu, 9 Jan 2003 08:24:59 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:39124 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S266678AbTAINY6>; Thu, 9 Jan 2003 08:24:58 -0500
Reply-to: Wolfgang Fritz <wolfgang.fritz@gmx.net>
To: linux-kernel@vger.kernel.org
From: Wolfgang Fritz <wolfgang.fritz@gmx.net>
Subject: Re: [Asterisk] DTMF noise
Date: Thu, 09 Jan 2003 14:31:55 +0100
Organization: None
Message-ID: <3E1D79CB.5010503@gmx.net>
References: <D6889804-2291-11D7-901B-000393950CC2@karlsbakk.net> <3E1BD88A.4080808@users.sf.net> <3E1C1CDE.8090600@sktc.net> <3E1C4872.7080508@gmx.net> <3E1D705E.1030203@sktc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1a) Gecko/20020610
X-Accept-Language: en-us, en, de-de, de
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.7; AVE: 6.17.0.2; VDF: 6.17.0.12; host: gurke)
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.7; AVE: 6.17.0.2; VDF: 6.17.0.12; host: gurke)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David D. Hagood wrote:
 > Wolfgang Fritz wrote:
 >
 >> Maybe it would be better to reenable harmonic checks but comparing
 >> harmonic levels to the level of the fundamental instead of using
 >> absolute values as in the present implementation.
 >
 >
 > You mean the code DOESN'T normalize the signal to the total energy
 > first?!?!? YEEP!

No. The original code used _absolute_ thresholds for the DTMF tones and
the harmonics. That did not work very well.

My simple patch added a relative energy comparision of the DTMF tones
and a simple plausibiltity check (DTMF is only accepted if there is
exactly one DTNF pair and no/low signal level on the other DTMF
frequencies. That worked with my (very limited) tests.

 >
 > The very FIRST thing you do is compute the total signal energy in the
 > sample period, trivially reject if Etotal < MinETotal, then normalize
 > all other signal energies to Etotal - that is a basic tenant of DSP.
 >

My patch did a first step in that direction, but took only the energy
on the DTMF frequencies. That does not seem to be sufficient.

Another thing which may improve resistance against false DTMF detection
would be to require more than one consecutive samples to contain a valid
DTMF tone. See the link in one of my posts on lkml.

 >
 >> standard test procedure with a lot of test cases which are not
 >> available to mortal humans (audio tapes from Bellcore IIRC)
 >
 >
 > I think we may have the test cases as WAVs at work, and I think they are
 > freely distributable - I'll kick a reminder to my work account off to
 > check later today.
 >

That would be nice. But that must be a rather big chunk of data - the
Mitel tape alone contains 30 minutes of speech, the Bellcore tapes even
more. Too much for my dialup line, I'm afraid.

Wolfgang




