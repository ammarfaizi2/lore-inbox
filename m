Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267767AbTAaLya>; Fri, 31 Jan 2003 06:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267768AbTAaLya>; Fri, 31 Jan 2003 06:54:30 -0500
Received: from smtp04.iprimus.com.au ([210.50.76.52]:59400 "EHLO
	smtp04.iprimus.com.au") by vger.kernel.org with ESMTP
	id <S267767AbTAaLy3>; Fri, 31 Jan 2003 06:54:29 -0500
Content-Type: text/plain; charset=US-ASCII
From: Paul <krushka@iprimus.com.au>
Reply-To: krushka@iprimus.com.au
To: linux-kernel@vger.kernel.org
Subject: Re: Fwd: File system corruption
Date: Fri, 31 Jan 2003 22:12:11 +1000
X-Mailer: KMail [version 1.2]
References: <0301062138130A.01466@paul.home.com.au> <1042035305.24099.13.camel@irongate.swansea.linux.org.uk> <20030108145503.F25712@bitwizard.nl>
In-Reply-To: <20030108145503.F25712@bitwizard.nl>
MIME-Version: 1.0
Message-Id: <03013122121103.01189@paul.home.com.au>
Content-Transfer-Encoding: 7BIT
X-OriginalArrivalTime: 31 Jan 2003 12:03:52.0393 (UTC) FILETIME=[D248FB90:01C2C920]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have finally received a new batch of CF cards (Mittoni brand) and these do 
not have the problem with data corruption as the Sandisk cards did.  So this 
fault is specific to one batch of Sandisk cards (so far)

Rogier has written below what might be causing this and I would like to try 
fixing it...gulp!  Can anyone spare a minute to point out the function I need 
to change to test the suggested "fix"?  I've looked around a bit and the 
closest I got was to finding an "outsl" function but can't find where the 
actual data is written to the device...

On Wed,  8 Jan 2003 11:55 pm, Rogier Wolff wrote:
> On Wed, Jan 08, 2003 at 02:15:06PM +0000, Alan Cox wrote:
> > On Wed, 2003-01-08 at 11:35, Paul wrote:
> > > What I have found is that just after the start of a sector, usually 43
> > > to 45 bytes, 6 bytes are skipped and the sequence starts again.  This
> > > continues until the next sector starts, where the sequence corrects. 
> > > This appears to happen every 65536 bytes or some multiple of 65536.  It
> > > may skip three blocks of 65536 and then corrupt on the next block of
> > > 65536 bytes.
> >
> > Ok that I'm afraid bears no resemblance to anything the software side
> > does (we write in chunks but we do single PIO block transfers of each
> > sector).
>
> After examining the resulting image, Paul has a "clock" line to his
> flash device that is a bit noisy. This occasionally causes one
> 16-bit entity to be clocked into the device twice.
>
> To detect this going wrong, we could (but only as a configurable
> option), write 255 16-bit words to the device (remember this is PIO!),
> check that DRQ is still active and only then write the last word.
> (at which point DRQ should go inactive).
>
> 				Roger.
