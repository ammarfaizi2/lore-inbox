Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261338AbVGSW5K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbVGSW5K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 18:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261412AbVGSW5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 18:57:10 -0400
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:26812 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261338AbVGSW5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 18:57:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=2WhN0I5awi0XldjKtogJE83yZ4rw6QU/i37N1mDhgIWj6z74rsjGuOcVJLJ3lELPo+5t7yOwzJLV8J2Q+QY/81pyZIgd+uL2+ODv7OswULhXORf8iRqY04c7NvHVmFvYgCWOIUaLpmNvTv+jIL6vLEiYxXq6Ae8winy1+7ufQzQ=  ;
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Date: Wed, 20 Jul 2005 01:00:33 +0200
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       "K.R. Foley" <kr@cybsft.com>, Chuck Harding <charding@llnl.gov>,
       William Weston <weston@sysex.net>
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <20050719135715.GA20664@elte.hu> <200507191119.06671.gene.heskett@verizon.net>
In-Reply-To: <200507191119.06671.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507200100.33439.annabellesgarden@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 19. Juli 2005 17:19 schrieb Gene Heskett:
> On Tuesday 19 July 2005 09:57, Ingo Molnar wrote:
> >* Karsten Wiese <annabellesgarden@yahoo.de> wrote:
> >> > Found another error:
> >> > the ioapic cache isn't fully initialized in -51-31's
> >> > ioapic_cache_init(). <snip>
> >>
> >> and another: some NULL-pointers are used in -51-31 instead of
> >> ioapic_data[0]. Please apply attached patch on top of -51-31. It
> >> includes yesterday's fix.
> >
> >thanks, i've applied it and released -32.
> 
> And this fixed ntpd (in mode 4) right up.  But now Im seeing some 
> fussing from Xprint when its started, from my logs:
> 
> Jul 19 10:59:58 coyote rc: Starting xprint:  succeeded
> Jul 19 10:59:58 coyote kernel: set_rtc_mmss: can't update from 7 to 59
> Jul 19 10:59:58 coyote kernel: set_rtc_mmss: can't update from 7 to 59
> Jul 19 10:59:59 coyote Xprt_33: lpstat: Unable to connect to server: Connection refused
> Jul 19 10:59:59 coyote Xprt_33: No matching visual for __GLcontextMode with visual class = 0 (32775), nplanes =
> 8
> Jul 19 11:00:00 coyote kernel: set_rtc_mmss: can't update from 7 to 59
> 
> The font path stuff I snipped has been there since forever.
> And, I didn't get the set_rtc_mmss messages when I did a service xprint restart.
> 
And then it "xprinted" right away just fine?

> Is this even connected to Xprint, that looks like something from maybe ntp?
> 
"set_rtc_mmss: can't update from 7 to 59"
is printk()ed from here:
linux-2.6.12-RT/include/asm-i386/mach-default/mach_time.h
<snip>
/*
 * In order to set the CMOS clock precisely, set_rtc_mmss has to be
 * called 500 ms after the second nowtime has started, because when
 * nowtime is written into the registers of the CMOS clock, it will
 * jump to the next second precisely 500 ms later. Check the Motorola
 * MC146818A or Dallas DS12887 data sheet for details.
 *
 * BUG: This routine does not handle hour overflow properly; it just
 *      sets the minutes. Usually you'll only notice that after reboot!
 */
static inline int mach_set_rtc_mmss(unsigned long nowtime)
</snip>
so its a rtc timingrelated.

which PREEMPT_RT / mode 4 was the last one to do it on the fly ?

> And of course in mode 4, tvtime has a blue screen.  But you knew that. :)
> 
what is tvtime supposed to do, is it  a wine thing as in "bleu screen"?

    Karsten

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
