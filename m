Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265085AbTFYV1o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 17:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265110AbTFYV1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 17:27:43 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:61093 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S265085AbTFYV1D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 17:27:03 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>, Daniel Gryniewicz <dang@fprintf.net>
Subject: Re: patch O1int for 2.5.73 - interactivity work
Date: Thu, 26 Jun 2003 07:43:10 +1000
User-Agent: KMail/1.5.2
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
References: <5.2.0.9.2.20030625204242.00ceda90@pop.gmx.net> <5.2.0.9.2.20030625222455.00cf33f0@pop.gmx.net>
In-Reply-To: <5.2.0.9.2.20030625222455.00cf33f0@pop.gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306260743.10999.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jun 2003 06:33, Mike Galbraith wrote:
> At 03:34 PM 6/25/2003 -0400, Daniel Gryniewicz wrote:
> >On Wed, 2003-06-25 at 15:00, Mike Galbraith wrote:
> > > At 02:09 AM 6/26/2003 +1000, Con Kolivas wrote:
> > > >I'm still working on something for the "xmms stalls if started during
> > > > very heavy load" as a different corner case.
> >
> ><snip scheduler suggestion>
> >
> > > Just a couple random thoughts, both of which I can see problems with
> > > ;-)
> >
> >At least on 2.4 (I use 21-ck3), it appears to be I/O starvation that
> >gets xmms, not scheduler starvation.  When xmms skips for me, there's
> >load, but there's also usually some idle time.  The common thread seems
> >to be heavy I/O on the drive xmms is using, possibly combined with a
> >(formerly?) interactive process (evolution rebuilding my LKML index, for
> >example) doing the disk I/O.  Because of the assorted I/O scheduler
> >changes in 2.5, this is unlikley to be the problem there.
>
> Ahah.  I thought Con was referring to the delay at new song, new task
> starting at priority 20 while things higher are using the cpu.  Yeah, your
> skips sound like xmms is just running out of buffered data.

No, Mike's right. If you do a make -j32 and then start up xmms, xmms seems to 
want to burn off some cpu when it first starts, and _then_ starts sleeping 
regularly; so it starts as a cpu hog for a short while and then sleeps. This 
makes is bloody hard for the scheduler to do the right thing to it since it 
gets treated as a cpu hog initially, meaning it will take forever to burn off 
that cpu time necessary when all other cpu hogs are also running.

Con

