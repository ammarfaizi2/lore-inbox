Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135925AbRAYU3D>; Thu, 25 Jan 2001 15:29:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131811AbRAYU2x>; Thu, 25 Jan 2001 15:28:53 -0500
Received: from vega.digitel2002.hu ([213.163.0.181]:7690 "EHLO
	vega.digitel2002.hu") by vger.kernel.org with ESMTP
	id <S129235AbRAYU2d>; Thu, 25 Jan 2001 15:28:33 -0500
Date: Thu, 25 Jan 2001 21:28:25 +0100
From: Gábor Lénárt <lgb@vega.digitel2002.hu>
To: Thunder from the hill <thunder@ngforever.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: vfat <-> vfat copying of ~700MB file, so slow!
Message-ID: <20010125212825.B23684@vega.digitel2002.hu>
In-Reply-To: <20010124131431.A19957@ikar.t17.ds.pwr.wroc.pl> <997u6tsn18dp9u1h97q4j5jc9a2amn1nsp@i-vic.net> <20010124193525.A28379@ikar.t17.ds.pwr.wroc.pl> <3A7076E3.D9E6AF8B@ngforever.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.12i
In-Reply-To: <3A7076E3.D9E6AF8B@ngforever.de>; from thunder@ngforever.de on Thu, Jan 25, 2001 at 11:56:35AM -0700
X-Operating-System: vega Linux 2.2.18 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 25, 2001 at 11:56:35AM -0700, Thunder from the hill wrote:
> Arkadiusz Miskiewicz wrote:
> > 
> > On/Dnia Wed, Jan 24, 2001 at 12:23:03PM -0600, Brad Felmey wrote/napisa?(a)
> > > > I/O support  =  0 (default 16-bit)
> > >
> > > hdparm -c1 /dev/hda, or are you running in 16-bit mode on purpose?
> > no purpose. Setting this can only speed up all operations a bit but it doesn't
> > change nothing in vfat <-> vfat copying. It still slows down while copying.
> I noticed the kernel to increase cache and let the buffers break down during long file copies, it seems like this is the wrong way if only copying one large file. This also happens on SMB connections. I don't know if this info is useful.

Hmmm, imho this is a more general problem. Of course kernel does not know
if this is a single copy or data should be cached since it will be used
frequently in the near future. I don't know kernel internals very well
but I think cache is block cache. On higher layer (fs) it would be possible
to check out that we simply read blocks of file linear (which means
something like you mentioned especially on big files). I met similar
problems when I copy a harddisk to another (same type), with simple dd'ing
/dev/hda to /dev/hdb. Even with 192Mbs of RAM, the system goes down to
a very uninteractive state :( This copy task may be implemented on raw devices
to avoid caching nowdays. Please correct me, because these are only feelings
or what :)

-- 
 --[ Gábor Lénárt ]---[ Vivendi Telecom Hungary ]--[ lgb@supervisor.hu ]--
 U have 8 bit comp or chip of them and it's unused or to be sold? Call me!
 -------[ +36 30 2270823 ]------> LGB <-----[ Linux/UNIX/8bit 4ever ]-----
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
