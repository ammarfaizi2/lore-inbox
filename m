Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262107AbVAYTrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262107AbVAYTrw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 14:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbVAYToa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 14:44:30 -0500
Received: from rproxy.gmail.com ([64.233.170.192]:34415 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262094AbVAYTlM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 14:41:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=l3fbJgMFFlFwDur3EXrjVqli7kRVJMIDX03lIpKf2678EPtMzVVto4j8DlB7D9pXpsU+3cGEVzrQTr0uWYbXSbGm3lrrtkhLJGY9DHQHxAhRHnqXU0k7puSNOFoxg2gmW97n6Bhen+qTiBnpTWAE+nmTzaNXhiwMbAr20bDLcFE=
Message-ID: <d120d500050125114117e9dec5@mail.gmail.com>
Date: Tue, 25 Jan 2005 14:41:08 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: i8042 access timings
Cc: Andries Brouwer <aebr@win.tue.nl>, linux-input@atrey.karlin.mff.cuni.cz,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20050125192519.GA2370@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200501250241.14695.dtor_core@ameritech.net>
	 <20050125105139.GA3494@pclin040.win.tue.nl>
	 <d120d5000501251117120a738a@mail.gmail.com>
	 <20050125192519.GA2370@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2005 20:25:20 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Tue, Jan 25, 2005 at 02:17:33PM -0500, Dmitry Torokhov wrote:
> > On Tue, 25 Jan 2005 11:51:39 +0100, Andries Brouwer <aebr@win.tue.nl> wrote:
> > > On Tue, Jan 25, 2005 at 02:41:14AM -0500, Dmitry Torokhov wrote:
> > >
> > > > Recently there was a patch from Alan regarding access timing violations
> > > > in i8042. It made me curious as we only wait between accesses to status
> > > > register but not data register. I peeked into FreeBSD code and they use
> > > > delays to access both registers and I wonder if that's the piece that
> > > > makes i8042 mysteriously fail on some boards.
> > >
> > > You are following this much more closely than I do, but isn't the
> > > usual complaint "2.4 works, 2.6 fails"?
> > >
> >
> > Quite often it is but too much has changed in input layer to pinpoing
> > exact cause of the failure and I am open to any suggestions. Common
> > problems I see:
> >
> > 1. ACPI sometimes interferes with i8042, especially battery status
> > polling. I am concerned about embedded controller access as well, it
> > looks like it takes sweet time to read/write data to it and ec.c does
> > it with interrupts disabled.
> 
> Furthermore, the EC and the i8042 are often the same chip, resulting in
> the i8042 not answering when EC is busy. Enabling interrupts won't help.

It might or it might not, I think it really depends on firmware implementation.

> > Also, In 2.4 if BIOS detected PS/2 mouse we trusted it and did not do
> > any additional checks, now that i8042 is not x86 specific we do
> > everything by hand and it looks like some hardware is not expecting
> > it...
> 
> We may be able to loosen the checks again now that 98% of machines do
> have the PS/2 mouse port if they have the AT keyboard port.
> 

Maybe only for specific machines - the report was about a Toshiba and
it looks like they have quite a few problems with their KBCs -
bouncing keys, not being able to sustain full Synaptics 480 bytes/s
rate...

-- 
Dmitry
