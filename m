Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265059AbUAGGaa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 01:30:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266136AbUAGGaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 01:30:30 -0500
Received: from smtp809.mail.sc5.yahoo.com ([66.163.168.188]:22165 "HELO
	smtp809.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265059AbUAGGa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 01:30:28 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: john stultz <johnstul@us.ibm.com>
Subject: Re: [2.6.0-mm2] PM timer still has problems
Date: Wed, 7 Jan 2004 01:30:21 -0500
User-Agent: KMail/1.5.4
Cc: Karol Kozimor <sziwan@hell.org.pl>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjanv@redhat.com>, jw schultz <jw@pegasys.ws>
References: <20031230204831.GA17344@hell.org.pl> <200401050117.06681.dtor_core@ameritech.net> <1073377877.2752.38.camel@localhost>
In-Reply-To: <1073377877.2752.38.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401070130.21769.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 January 2004 03:31 am, john stultz wrote:
> On Sun, 2004-01-04 at 22:17, Dmitry Torokhov wrote:
> > I decided to go hpet way and use tsc in ACPI PM timer to do delay
> > stuff and monotonic clock.
>
> I think you have a valid point that as loops_per_jiffy isn't updated,
> delay_pmtmr() and delay_pit() are broken w/ CPUFREQ.
>
> However I don't understand using the TSC for montonic_clock. I have no
> clue why the HPET folks implemented it that way (likely my fault for
> not enough documentaiton), but I haven't had the time to try to clean
> up that code. And really, if your TSC is reliable enough for
> monotonic_clock, why are you using the pmtmr? :) Unless it specifically
> is resolving an issue, I'd drop that change.
>

I thought (it seems that I was mistaken) that the goal of monotonic_clock
is to privide high-resolution cheap timestamps that are guaranteed never
go back as there is no adjustments to the time. The normal clock it supposed
to be stable and accurate but probably give lower resolution. In case of
pmtmr vs. TSC seems to have higher resolution and is cheap so it was used.

Dmitry 

