Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129747AbRBNUx4>; Wed, 14 Feb 2001 15:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129909AbRBNUxq>; Wed, 14 Feb 2001 15:53:46 -0500
Received: from HSE-Montreal-ppp103309.qc.sympatico.ca ([64.230.176.130]:6152
	"EHLO mx1.lcis.net") by vger.kernel.org with ESMTP
	id <S129747AbRBNUxc>; Wed, 14 Feb 2001 15:53:32 -0500
Date: Wed, 14 Feb 2001 15:53:02 -0500 (EST)
From: "Gord R. Lamb" <glamb@lcis.dyndns.org>
X-X-Sender: <glamb@localhost.localdomain>
To: Jeremy Jackson <jeremy.jackson@sympatico.ca>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Samba performance / zero-copy network I/O
In-Reply-To: <3A8AEDB9.59721801@sympatico.ca>
Message-ID: <Pine.LNX.4.32.0102141548440.27843-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Feb 2001, Jeremy Jackson wrote:

> "Gord R. Lamb" wrote:
>
> > Hi everyone,
> >
> > I'm trying to optimize a box for samba file serving (just contiguous block
> > I/O for the moment), and I've now got both CPUs maxxed out with system
> > load.
> >
> > (For background info, the system is a 2x933 Intel, 1gb system memory,
> > 133mhz FSB, 1gbit 64bit/66mhz FC card, 2x 1gbit 64/66 etherexpress boards
> > in etherchannel bond, running linux-2.4.1+smptimers+zero-copy+lowlatency)
> >
> > CPU states typically look something like this:
> >
> > CPU states:  3.6% user,  94.5% system,  0.0% nice, 1.9% idle
> >
> > .. with the 3 smbd processes each drawing around 50-75% (according to
> > top).
> >
> > When reading the profiler results, the largest consuming kernel (calls?)
> > are file_read_actor and csum_partial_copy_generic, by a longshot (about
> > 70% and 20% respectively).
> >
> > Presumably, the csum_partial_copy_generic should be eliminated (or at
> > least reduced) by David Miller's zerocopy patch, right?  Or am I
> > misunderstanding this completely? :)
>
> I only know enough to be dangerous here, but I believe you will need to
> be using one of the network cards whose driver actually uses the
> zero-copy patches, and/or which can perform tcp checksum in hardware
> (of the network card).

Hmm.  Yeah, I think that may be one of the problems (Intel's card isn't
supported afaik; if I have to I'll switch to 3com, or hopelessly try to
implement support).  I'm looking for a patch to implement sendfile in
Samba, as Alan suggested.  That seems like a good first step.

