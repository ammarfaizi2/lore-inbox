Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312562AbSDATea>; Mon, 1 Apr 2002 14:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312563AbSDATeU>; Mon, 1 Apr 2002 14:34:20 -0500
Received: from khazad-dum.debian.net ([200.196.10.6]:55196 "EHLO
	khazad-dum.debian.net") by vger.kernel.org with ESMTP
	id <S312562AbSDATeM>; Mon, 1 Apr 2002 14:34:12 -0500
Date: Mon, 1 Apr 2002 16:34:09 -0300
To: Mark Cooke <mpc@star.sr.bham.ac.uk>
Cc: =?iso-8859-1?Q?David_H=E4rdeman?= <david@2gen.com>,
        LinuxKernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.4.17 with VT8367 [KT266] crashes on heavy ide load togeter
Message-ID: <20020401163409.F22174@khazad-dum>
In-Reply-To: <3CA88BC0.2000603@2gen.com> <Pine.LNX.4.44.0204011810380.16203-300000@pc24.sr.bham.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
X-GPG-Fingerprint-1: 1024D/128D36EE 50AC 661A 7963 0BBA 8155  43D5 6EF7 F36B 128D 36EE
X-GPG-Fingerprint-2: 1024D/1CDB0FE3 5422 5C61 F6B7 06FB 7E04  3738 EE25 DE3F 1CDB 0FE3
From: hmh@debian.org (Henrique de Moraes Holschuh)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Apr 2002, Mark Cooke wrote:
> On Mon, 1 Apr 2002, David Härdeman wrote:
> > Date: Mon, 01 Apr 2002 18:33:04 +0200
> > From: David Härdeman <david@2gen.com>
> > To: Mark Cooke <mpc@star.sr.bham.ac.uk>
> > Cc: LinuxKernel <linux-kernel@vger.kernel.org>
> > Subject: Re: Kernel 2.4.17 with VT8367 [KT266] crashes on heavy ide load
> >     togeter
> > 
> > Mark Cooke wrote:
> > > If I run a simultaneous one on hdc and hde, the combined rate tops 
> > > out at 50MB again.  Hence, the limitation isn't the raid card.  Or at 
> > > least I'd be exceedingly surprised.
> > 
> > The bugs that exist in VIA chipsets and Barracuda drives have already 
> > exceedingly surprised me many, many times :-)

Yes. For the VIA side, I have this in my rc.S stuff:

#!/bin/sh
PATH=/sbin:/bin:/usr/sbin:/usr/bin
export PATH

echo -n "Optimizing hardware configuration: "

if command -v setpci >/dev/null 2>&1; then
    echo -n "PCI"
    #
    # Optimize PCI latency for IDE controllers
    #
    setpci -d 1106:0571 latency_timer=60  >/dev/null 2>&1
    setpci -d 105a:*	latency_timer=60  >/dev/null 2>&1
    echo "."
else
    echo '(lspci/setpci not available!)'
fi

Normal latency set by the BIOS is 32, which is too damn small for IDE.

You may have to tweak the PCI ids a bit. You want all storage controllers
(both chipset, Promise and any extra cards). The IDs up there are for my VIA
kt133, and Promise PDC20265.

Oh, some of the PCI 'optimizations' in BIOS must be enabled for that to
actually help a bit. Stuff like the PCI caches.

VIA PCI is utter crap. I am not buying anything of theirs ever again :(

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
