Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261476AbVDNJGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261476AbVDNJGU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 05:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbVDNJGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 05:06:19 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:20904 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261458AbVDNJFp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 05:05:45 -0400
Date: Thu, 14 Apr 2005 11:05:24 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Matt Mackall <mpm@selenic.com>, Andreas Steinmetz <ast@domdv.de>,
       rjw@sisk.pl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH encrypted swsusp 1/3] core functionality
Message-ID: <20050414090524.GA1706@elf.ucw.cz>
References: <425D17B0.8070109@domdv.de> <20050413212731.GA27091@gondor.apana.org.au> <425D9D50.9050507@domdv.de> <20050413231044.GA31005@gondor.apana.org.au> <20050413232431.GF27197@elf.ucw.cz> <20050413233904.GA31174@gondor.apana.org.au> <20050413234602.GA10210@elf.ucw.cz> <20050414003506.GQ25554@waste.org> <20050414065124.GA1357@elf.ucw.cz> <20050414080837.GA1264@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050414080837.GA1264@gondor.apana.org.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Čt 14-04-05 18:08:37, Herbert Xu wrote:
> On Thu, Apr 14, 2005 at 08:51:25AM +0200, Pavel Machek wrote:
> >
> > > This solution is all wrong.
> > > 
> > > If you want security of the suspend image while "suspended", encrypt
> > > with dm-crypt. If you want security of the swap image after resume,
> > > zero out the portion of swap used. If you want both, do both.
> 
> Pavel, you're not answering our questions.
> 
> How is the proposed patch any more secure compared to swsusp over
> dmcrypt?

It is not "more secure". It solves completely different problem.

> In fact if anything it is less secure.  If I understand correctly the
> proposal is to store the key used to encrypt the swsusp image in the
> swap device.  This means that anybody who gains access to the swap
> device can trivially decrypt it.

Yes. It also means that key is gone after resume.

> Compare this to the properly setup dmcrypt case where the swap
> device can only be decrypted with a passphrase obtained from the
> user at resume time.

Solution above does not require passphrase (so users will actually use
it) and dmcrypt with passphrase does not destroy the key after resume,
so data can still be recovered.

They are orthogonal. You want both.

If something is still unclear, we can talk on irc somewhere, if you
agree to write FAQ entry afterwards ;-).
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
