Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261455AbVDNJEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbVDNJEr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 05:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbVDNJEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 05:04:47 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:4007 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261455AbVDNJEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 05:04:44 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH encrypted swsusp 1/3] core functionality
Date: Thu, 14 Apr 2005 11:04:39 +0200
User-Agent: KMail/1.7.1
Cc: Pavel Machek <pavel@ucw.cz>, Matt Mackall <mpm@selenic.com>,
       Andreas Steinmetz <ast@domdv.de>, linux-kernel@vger.kernel.org
References: <E1DLgWi-0003Ag-00@gondolin.me.apana.org.au> <20050414065124.GA1357@elf.ucw.cz> <20050414080837.GA1264@gondor.apana.org.au>
In-Reply-To: <20050414080837.GA1264@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504141104.40389.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday, 14 of April 2005 10:08, Herbert Xu wrote:
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
> How is the proposed patch any more secure compared to swsusp over dmcrypt?

It is for different purpose.  It is to prevent swsusp from leaving a readable
memory snapshot on the disk _after_ resume, even if the resume has _failed_
(ie if you encrypt the image during suspend and then destroy the key after
reading the image during resume, you don't need to zero out the swap partition,
which you can't do anyway if the resume has failed).  IOW, please treat it as
a more sophisticated method of zeroing out the swap partition. :-)

Arguably, using dm-crypt is more secure, but it is also more complicated from
the Joe User POV.  IMHO we should not force users to set up dm-crypt, remember
passwords etc., to get some basic security.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
