Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131590AbRC0VhR>; Tue, 27 Mar 2001 16:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131595AbRC0VhI>; Tue, 27 Mar 2001 16:37:08 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:52484 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131590AbRC0Vg4>; Tue, 27 Mar 2001 16:36:56 -0500
Date: Tue, 27 Mar 2001 13:35:23 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "H. Peter Anvin" <hpa@transmeta.com>, <Andries.Brouwer@cwi.nl>,
        <linux-kernel@vger.kernel.org>, <tytso@MIT.EDU>
Subject: Re: Larger dev_t
In-Reply-To: <E14i0u8-0004N1-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.31.0103271333160.25014-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 27 Mar 2001, Alan Cox wrote:
>
> > layer made it impossible for a driver writer to be nice to the user, so
> > instead they got their own major numbers.
>
> Not deficiencies in the SCSI layer, there is no way the scsi layer can
> handle high end raid controllers. In fact one of the reasons we can beat
> NT with some of these controllers is because NT does exactly what you
> suggest with scsi miniport driver hacks and it _sucks_. Its an ugly hack.

We could do this fairly _trivially_ today.

With absolutely no performance degradation.

With a simple "queue" mapping for the SCSI majors. Just look up which
queue to use for requests to which major, and you're done. The actual
IO may by-pass the SCSI layer altogether.

So I'm absolutely not advocating using the SCSI layer for the
high-end-disks. Rather the reverse. I'm advocating the SCSI layer not
hogging a major number, but letting low-level drivers get at _their_
requests directly.

		Linus

