Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262367AbREUDeJ>; Sun, 20 May 2001 23:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262378AbREUDeA>; Sun, 20 May 2001 23:34:00 -0400
Received: from modemcable084.137-200-24.mtl.mc.videotron.ca ([24.200.137.84]:34286
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S262367AbREUDdp>; Sun, 20 May 2001 23:33:45 -0400
Date: Sun, 20 May 2001 23:33:34 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: <nico@xanadu.home>
To: "Eric S. Raymond" <esr@thyrsus.com>
cc: David Woodhouse <dwmw2@infradead.org>,
        Arjan van de Ven <arjanv@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Background to the argument about CML2 design philosophy
In-Reply-To: <20010520164700.H4488@thyrsus.com>
Message-ID: <Pine.LNX.4.33.0105202258030.18874-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 20 May 2001, Eric S. Raymond wrote:

> In order to prevent that happening, I would like to have some recognized
> criterion for configuration cases that are so perverse that it is a
> net loss to accept the additional complexity of handling them within the
> configurator.

Simple:  That extreme perversion represent a kernel that wouldn't compile.
You can't have NFS support if you didn't select networking support, etc.
Such is the recognized basics.

Next, you can ask the question if you would have to modify the ruleset to
add a new driver to be able to use a feature.  Exemple: will you need to
write a new driver for a special IDE interface card and add it in the
ruleset before you could use IDE cdrom support on the MVME147 SBC?  If you
have to edit it anyway then it shouldn't be much pain to remove the
unconditionnal removal of IDE support for that target.

For all other combinations where a slight possibility might make you doubt
then the choice should remain at least in expert mode.

People might also want to remove support for subsystems on a specific target
even if the device comes soldered on it, just because they won't use it
anyway and they want to optimize their kernel size for better memory usage.

IMHO your design goal now is mainly about finding a way to describe rule
derivation related to the selected expertise mode, and only enforce the
strictly impossible combinations for expert mode, just like CML1 is doing
while removing obvious derivations for novice users.

Now you protest with:

> That pushes the third button.  I'm nervous that if we go down this path
> we will end up with a thicket of modes and a combinatorial explosion
> in ruleset complexity, leading immediately to a user configuration
> experience that is more complex than necessary, and eventually to an
> unmaintainable mess in the rulesfiles.

Eric: with this I think you know what everybody here is wishing for, and you
just perfectly stated your design constraint in achieving it.  You can't
avoid the "all semi-possible combination allowed" mode.  So let's switch to
the implementation discussion instead.


Nicolas

