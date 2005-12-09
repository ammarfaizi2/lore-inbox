Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932490AbVLIRZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932490AbVLIRZa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 12:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932507AbVLIRZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 12:25:30 -0500
Received: from allen.werkleitz.de ([80.190.251.108]:62625 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932490AbVLIRZ3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 12:25:29 -0500
Date: Fri, 9 Dec 2005 18:24:59 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: dtor_core@ameritech.net
Cc: Mauro Carvalho Chehab <mchehab@brturbo.com.br>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, mchehab@infradead.org,
       linux-dvb-maintainer@linuxtv.org, Oliver Endriss <o.endriss@gmx.de>
Message-ID: <20051209172459.GA11025@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	dtor_core@ameritech.net,
	Mauro Carvalho Chehab <mchehab@brturbo.com.br>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, mchehab@infradead.org,
	linux-dvb-maintainer@linuxtv.org, Oliver Endriss <o.endriss@gmx.de>
References: <1134137813.10677.7.camel@localhost> <d120d5000512090722yb975ccah1eef0cde73ca7e88@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000512090722yb975ccah1eef0cde73ca7e88@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: 84.190.189.67
Subject: Re: [PATCH 29/56] DVB (2390) Adds a time-delay to IR remote button presses for av7110 ir input,
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2005, Dmitry Torokhov wrote:
> On 12/9/05, Mauro Carvalho Chehab <mchehab@brturbo.com.br> wrote:
> >  static void input_repeat_key(unsigned long data)
> >  {
> > -       /* dummy routine to disable autorepeat in the input driver */
> > +       /* called by the input driver after rep[REP_DELAY] ms */
> > +       delay_timer_finished = 1;
> >  }
> 
> I always wondered why many IR drivers re-implement autorepeat code
> instead of using autorepeat in the inptu core. Is it because of forced
> (by timer) keyup events?

Remote controls don't generate key-up events (think what would
happen if you press a button and then someone walks in between
while you release the key). Instead they generate key-down
and repeated key-still-down events. The repeat rate generated
by remote controls varies roughly between 100...300 msecs and
even depends on battery level for many remotes.

If you use a timer to simulate key-up after you received no
key-still-down for some time, and use input core autorepeat,
then you get this annoying effect that input core generates
key repeats after you released the key on the remote control.


Johannes
