Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277509AbRKVLr3>; Thu, 22 Nov 2001 06:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277532AbRKVLrT>; Thu, 22 Nov 2001 06:47:19 -0500
Received: from ns0.dhm-systems.de ([195.126.154.163]:18696 "EHLO
	ns0.dhm-systems.de") by vger.kernel.org with ESMTP
	id <S277509AbRKVLrP>; Thu, 22 Nov 2001 06:47:15 -0500
Message-ID: <3BFCE5BB.AD59B011@web-systems.net>
Date: Thu, 22 Nov 2001 12:47:07 +0100
From: Heinz-Ado Arnolds <Ado.Arnolds@dhm-systems.de>
Reply-To: Ado.Arnolds@dhm-systems.de
Organization: DHM GmbH & Co. KG
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: de, en, fr, ru
MIME-Version: 1.0
To: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        alan@lxorguk.ukuu.org.uk
Subject: Re: fs/exec.c and binfmt-xxx in 2.4.14
In-Reply-To: <3BFBDD32.434AB47B@web-systems.net> <20011121211433.B1424@devcon.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Ferber wrote:
> 
> On Wed, Nov 21, 2001 at 05:58:26PM +0100, Heinz-Ado Arnolds wrote:
> >
> > When i now try to start an older binary in a.out format, which has a
> > magic number of 0x010b0064, it is translated with the 'new' code to a
> > request for "binfmt-0064" instead of "binfmt-267" as expected and
> > properly handled by modprobe.
> 
> Then add
> 
> alias binfmt-0064 binfmt_aout
> 
> to /etc/modules.conf. Simple, isn't it?

That's a nice idea but I wouldn't rely on the fact that the third
and the fourth byte of a file are sufficient to identify the type.
If you look at the magic numbers in /etc/magic, you'll find:

  0x00640107      Linux/i386 impure executable (OMAGIC)
  0x00640108      Linux/i386 pure executable (NMAGIC)
  0x0064010b      Linux/i386 demand-paged executable (ZMAGIC)
  0x006400cc      Linux/i386 demand-paged executable (QMAGIC)
  =0514           80386 COFF executable

It's standard to count on the first (and eventually following) bytes.

And if you look further on in /etc/magic, you'll see that there are
other file types having 0x0064 as 3rd and 4th byte.

I think it would not be a great deal to revert the changes in fs/exec.c

Thanks for your attention

Ado

-- 
------------------------------------------------------------------------
  Heinz-Ado Arnolds                        Ado.Arnolds@web-systems.net
  Websystems GmbH                              +49 2234 1840-0 (voice)
  Max-Planck-Strasse 2, 50858 Koeln, Germany   +49 2234 1840-40  (fax)
