Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751604AbVKIXkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751604AbVKIXkG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 18:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751606AbVKIXkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 18:40:06 -0500
Received: from mail27.sea5.speakeasy.net ([69.17.117.29]:56297 "EHLO
	mail27.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751604AbVKIXkD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 18:40:03 -0500
Date: Wed, 9 Nov 2005 15:40:02 -0800 (PST)
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: Andreas Schwab <schwab@suse.de>
cc: "linux-os \\\\(Dick Johnson\\\\)" <linux-os@analogic.com>,
       linas <linas@austin.ibm.com>, "J.A. Magallon" <jamagallon@able.es>,
       Kyle Moffett <mrmacman_g4@mac.com>,
       Douglas McNaught <doug@mcnaught.org>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Subject: Re: typedefs and structs
In-Reply-To: <je3bm5qu2b.fsf@sykes.suse.de>
Message-ID: <Pine.LNX.4.58.0511091537370.23877@shell4.speakeasy.net>
References: <20051107204136.GG19593@austin.ibm.com>
 <1131412273.14381.142.camel@localhost.localdomain> <20051108232327.GA19593@austin.ibm.com>
 <B68D1F72-F433-4E94-B755-98808482809D@mac.com> <20051109003048.GK19593@austin.ibm.com>
 <m27jbihd1b.fsf@Douglas-McNaughts-Powerbook.local> <20051109004808.GM19593@austin.ibm.com>
 <19255C96-8B64-4615-A3A7-9E5A850DE398@mac.com> <20051109111640.757f399a@werewolf.auna.net>
 <Pine.LNX.4.58.0511090816300.4260@shell2.speakeasy.net>
 <20051109192028.GP19593@austin.ibm.com> <Pine.LNX.4.61.0511091459440.12760@chaos.analogic.com>
 <Pine.LNX.4.58.0511091347570.31338@shell3.speakeasy.net> <je3bm5qu2b.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Nov 2005, Andreas Schwab wrote:

> Vadim Lobanov <vlobanov@speakeasy.net> writes:
>
> > However, if the code is as follows:
> > 	void foo (void) {
> > 		int myvar = 0;
> > 		printf("%d\n", myvar);
> > 		bar(&myvar);
> > 		printf("%d\n", myvar);
> > 	}
> > If bar is declared in _another_ file as
> > 	void bar (const int * var);
> > then I think the compiler can validly cache the value of 'myvar' for the
> > second printf without re-reading it. Correct/incorrect?
>
> Incorrect. bar() may cast away const.  In C const does not mean readonly.

In that case, I stand corrected.

Is there any real reason to apply const to pointer targets, aside from
giving yourself a warning in the case you try to write the pointer
target directly? Seems to be a missed opportunity for optimizations
where the coder designates that it's okay to do so.

> Andreas.
>
> --
> Andreas Schwab, SuSE Labs, schwab@suse.de
> SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
> PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
> "And now for something completely different."
>

-Vadim Lobanov
