Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030215AbWAIRyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030215AbWAIRyy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 12:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030219AbWAIRyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 12:54:54 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:60379 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030215AbWAIRyx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 12:54:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eR6nxWQXW2zPLFUGTYoaKsv+Y3pG8tirgtM7VdyMzrrodjBgdszZn0VdgpBbIb1cqJaN9NyC7+yutU93r0hss6Ir6HmEcL2voIAoMqxBvXQp1Rr4KhaPeAKdkWFCnsDlsbz9g8v1Z9oUSW8UAI1WFqUQYLUSj2F9sj2efnYsxLw=
Message-ID: <d120d5000601090954k3e35c3c7n31d4d6796ac760bf@mail.gmail.com>
Date: Mon, 9 Jan 2006 12:54:52 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: PROBLEM: PS/2 keyboard does not work with 2.6.15
Cc: Martin Bretschneider <mailing-lists-mmv@bretschneidernet.de>,
       linux-kernel@vger.kernel.org, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       linux-usb-devel@lists.sourceforge.net, Greg KH <gregkh@suse.de>,
       Leonid <nouser@lpetrov.net>
In-Reply-To: <Pine.LNX.4.44L0.0601091215070.7432-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <d120d5000601090850k42cc1c1ft6ab4e197119cacd@mail.gmail.com>
	 <Pine.LNX.4.44L0.0601091215070.7432-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/06, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Mon, 9 Jan 2006, Dmitry Torokhov wrote:
>
> > > It would be nice to know which part of the usb-handoff code causes the
> > > problem.
> >
> > Well, it's not handoff code causing problems per se, it's just that it
> > does not look like it performs handoff. If it did then disabling USB
> > legacy emulation in BIOS would have no effect, right?
>
> On the other hand, if the BIOS worked correctly then the ps/2 port would
> have no problems regardless of whether USB legacy emulation was on or off.
> Given that the keyboard works during bootup, I see only two possibilities:
>
>        The USB handoff code somehow causes the BIOS to mess up the
>        state of the 8042;
>
>        The 8042 driver interacts badly with the firmware when USB
>        legacy emulation is on, and the USB handoff code doesn't
>        successfully turn off legacy emulation.
>
> My earlier suggestion was an attempt to test the first possibility.  The
> second is harder to test because it implies problems in both the 8042
> driver and the USB handoff code.
>

My experience is that USB legacy emulation in BIOS + ACPI works as
long as you do not touch it and gets terribly confused if someone
tries to actually use i8042 (like enable active multiplexing mode with
4 AUX ports). As soon as BIOS takes its dirty hands off i8042
everything works fine.

The problem it seems that when usb-handoff code was moved from pci
quirks and enabled inconditionally something happened so it stopped
doing handoff.

--
Dmitry
