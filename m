Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316780AbSEUX1Q>; Tue, 21 May 2002 19:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316782AbSEUX1Q>; Tue, 21 May 2002 19:27:16 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:41741 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316780AbSEUX1P>; Tue, 21 May 2002 19:27:15 -0400
Date: Tue, 21 May 2002 16:26:44 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Pavel Machek <pavel@suse.cz>
cc: kernel list <linux-kernel@vger.kernel.org>,
        ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: suspend-to-{RAM,disk} for 2.5.17
In-Reply-To: <20020521232001.GK22878@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.33.0205211621310.22624-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 22 May 2002, Pavel Machek wrote:
> Do you think I should modify schedule() to do freezing automatically?
> I wanted to keep my hands off hot paths... I'd rather not do that. 

No, I just suspect you could freeze them _while_ they sleep by just 
picking up their information from the normal save area.

Yeah, I know, Linux tends to save a lot of the process stuff implicitly on
the stack, so maybe that ends up being harder than it sounds, and you've 
done it for other tasks with the signal handler code instead, but you 
_should_ be able to do it without any signal handler hackery by just 
saving off their kernel stack and the stuff in the thread structure.

That's just a gut feeling, not having actually looked at the real details.

		Linus

