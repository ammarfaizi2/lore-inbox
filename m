Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291474AbSBHIvL>; Fri, 8 Feb 2002 03:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291475AbSBHIuv>; Fri, 8 Feb 2002 03:50:51 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:263 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S291474AbSBHIur>; Fri, 8 Feb 2002 03:50:47 -0500
Message-Id: <200202080847.g188lMt13875@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: yodaiken@fsmlabs.com, Martin Wirth <Martin.Wirth@dlr.de>
Subject: Re: [RFC] New locking primitive for 2.5
Date: Fri, 8 Feb 2002 10:47:24 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au, mingo@elte.hu,
        rml@tech9.net, nigel@nrg.org
In-Reply-To: <3C629F91.2869CB1F@dlr.de> <20020207125601.A21354@hq.fsmlabs.com>
In-Reply-To: <20020207125601.A21354@hq.fsmlabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 February 2002 17:56, yodaiken@fsmlabs.com wrote:
> > If a spin_lock request is blocked by a mutex_lock call, the spin_lock
> > attempt also sleeps i.e. behaves like a semaphore.
>
> So what's the difference between combi_spin and combi_mutex?
> combi_spin becomes
> 	if not mutex locked, spin
> 	else sleep
> Bizzare

combi_spin_lock():
If not mutex locked, spin - will be released shortly
else sleep - may take long time before released
 * lock released *
spin lock it!     <=== this is the difference -
                       combi_mutex_lock would mutex lock it here

What's wrong with this?
--
vda
