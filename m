Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283672AbRLEB33>; Tue, 4 Dec 2001 20:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283674AbRLEB3V>; Tue, 4 Dec 2001 20:29:21 -0500
Received: from hermes.domdv.de ([193.102.202.1]:21259 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S283660AbRLEB3A>;
	Tue, 4 Dec 2001 20:29:00 -0500
Message-ID: <XFMail.20011205022659.ast@domdv.de>
X-Mailer: XFMail 1.5.1 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20011204222407.D1772@mouse.mydomain>
Date: Wed, 05 Dec 2001 02:26:59 +0100 (CET)
Organization: D.O.M. Datenverarbeitung GmbH
From: Andreas Steinmetz <ast@domdv.de>
To: Gert Menke <gert@menke.za.net>
Subject: Re: kapm-idled
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
the problem is that kapm-idled and the idle task are both trying to handle the
system idle time. I did send a patch correcting this weird behaviour for
revision to Alan Cox a few days ago but until now there's no reaction from him.
Oh, and there's more problems with kapm-idled. Think of a task like kmix that
is ready to run every fraction of HZ to do some bookkeeping. Now look at the
kapm-idled code. If both run in sync, e.g. they are ready to run during the
same time slice kapm-idled will never do bios idle calls as there's always at
least one task ready to run and this is then accounted as a 'heavily loaded
system'.
If you want to have a look at the patch please let me know though it may take a
few days. I have to recover a system suffering from severe bit errors due to
a memory module having gone south very slowly and quiet.

On 04-Dec-2001 Gert Menke wrote:
> Hi,
> 
> On Tue, Dec 04, 2001 at 09:45:44PM +0100, Dave Jones wrote:
>> http://www.tux.org/lkml/#s14-1
> Sorry, I should have read the FAQ first.
> 
> But it is still annoying that kapm-idled claims to use that much system
> ressources when it isn't. When my system is idle it should say ~100% idle,
> not ~50% system. Right?
> Is there an easy way to fix this? Or a good reason not to?
> 
> Greetings
> Gert
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH
