Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261333AbVBRKqs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbVBRKqs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 05:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbVBRKqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 05:46:48 -0500
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:17796 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S261319AbVBRKqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 05:46:44 -0500
Date: Fri, 18 Feb 2005 11:46:33 +0100
To: Stefan =?iso-8859-15?Q?D=F6singer?= <stefandoesinger@gmx.at>
Cc: acpi-devel@lists.sourceforge.net,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       Pavel Machek <pavel@suse.cz>,
       kernel list <linux-kernel@vger.kernel.org>, seife@suse.de, rjw@sisk.pl
Subject: Re: [ACPI] Call for help: list of machines with working S3
Message-ID: <20050218104633.GA28246@gamma.logic.tuwien.ac.at>
References: <20050214211105.GA12808@elf.ucw.cz> <200502152038.00401.stefandoesinger@gmx.at> <20050217190815.GC4925@gamma.logic.tuwien.ac.at> <200502172158.56721.stefandoesinger@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200502172158.56721.stefandoesinger@gmx.at>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Don, 17 Feb 2005, Stefan Dösinger wrote:
> > Ok, I installed xlibmesa-gl1-dri-trunk, xserver-xfree86-dri-trunk and
> > compiled linux-2.6.11-rc4 and drm modules from drm-trunk-module-src, all
> > from http://www.nixnuts.net/files/
> >
> > But I had no success whatsoever. With this (Xorg server, current dri/drm
> > stuff, ..) the laptop not even wakes up from sleep!
> Sorry, no Idea. What about 2.6.11-rc3-mm2 + Xorg 6.8.1.99? Did you test this 
> combination?

I tried:
	2.6.11-rc3-mm2 + Xorg + DRI disabled
and this works.

I cannot enable dri/drm with the cvs version of the drm modules, because
the drm modules do not compile for -mm kernels, since there is the patch
for multiple agp bridges included (that's the reason why I tried -rc4
without mm) and the drm modules from drm-trunk-module-src are not
prepared to the change of the api. I even tried to incorporate the
changes to the api but gave up.

I *can* active dri but with the builtin kernel drm modules, which makes
the kernel freeze while resuming.

> Am I right with assuming that resumeworked after the X upgrade if X wasn't 
> started before suspend?

NO!!! Most interestingly: Doing a suspend from single user mode makes
the machine freeze (not even sysrq!)

I suspect that it has to do with the restoring of graphics state with
vbetool from a data set which was taken *while* running X: My
suspend2ram script looks like this (as suggested here):

statedir=/root/s3/state
/usr/bin/chvt 1
cat /dev/vcsa >$statedir/vcsa
sync
echo 3 > /proc/acpi/sleep
sync
vbetool post
vbetool vbestate restore <$statedir/vbe
cat $statedir/vcsa >/dev/vcsa
...

but $statedir/vbe was taken once for XFree86 running. Can this be the
reason for the freeze?


Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>                 Università di Siena
sip:preining@at43.tuwien.ac.at                             +43 (0) 59966-690018
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
MAVIS ENDERBY (n.)
The almost-completely-forgotten girlfriend from your distant past for
whom your wife has a completely irrational jealousy and hatred.
			--- Douglas Adams, The Meaning of Liff
