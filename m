Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263201AbTFPBqm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 21:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263205AbTFPBqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 21:46:42 -0400
Received: from netmagic.net ([206.14.125.10]:41183 "EHLO mail.netmagic.net")
	by vger.kernel.org with ESMTP id S263201AbTFPBqk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 21:46:40 -0400
Subject: Re: PROBLEM: 2.4.21 crashes hard running cdrecord in X.
From: Per Nystrom <pnystrom@netmagic.net>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200306161055.13996.kernel@kolivas.org>
References: <1055722972.1502.39.camel@spike.sunnydale>
	 <200306161055.13996.kernel@kolivas.org>
Content-Type: text/plain
Organization: 
Message-Id: <1055728825.1482.8.camel@spike.sunnydale>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 15 Jun 2003 19:00:26 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I've removed the nvidia driver and changed "Device" in XF86Config
back to Driver "nv".  Here's lsmod:

Module                  Size  Used by    Not tainted
sr_mod                 15960   0 (autoclean)
awe_wave              171296   0 (autoclean) (unused)
sb                      9332   0 (autoclean)
sb_lib                 44526   0 (autoclean) [sb]
uart401                 8484   0 (autoclean) [sb_lib]
sound                  73428   0 (autoclean) [awe_wave sb_lib uart401]
parport_pc             18980   1 (autoclean)
lp                      8352   1 (autoclean)
parport                36864   1 (autoclean) [parport_pc lp]
nfsd                   80112   8 (autoclean)
lockd                  58192   1 (autoclean) [nfsd]
sunrpc                 81884   1 (autoclean) [nfsd lockd]
autofs4                12244   1 (autoclean)
tulip                  45664   1
iptable_filter          2412   0 (autoclean) (unused)
ip_tables              14680   1 [iptable_filter]
ide-scsi               12176   0
scsi_mod               99476   2 [sr_mod ide-scsi]
vfat                   12780   1 (autoclean)
fat                    39160   0 (autoclean) [vfat]
mousedev                5524   0 (unused)
keybdev                 2944   0 (unused)
hid                    22116   1
input                   5760   0 [mousedev keybdev hid]
usb-uhci               26220   0 (unused)
usbcore                77440   1 [hid usb-uhci]


The behavior is exactly the same without nvidia's driver, but I won't go
back to running it until this thing is figured out.

Next thing I'm going to try is starting *just* X with nothing else, and
running cdrecord in a text console.  If that works, I'll try it with
just metacity running, and I'll keep stacking things up until it fails.

Thanks in advance,
Per


On Sun, 2003-06-15 at 17:55, Con Kolivas wrote:
> On Mon, 16 Jun 2003 10:22, Per Nystrom wrote:
> > 2.4.21 crashes hard running cdrecord in X.
> >
> > I just compiled installed 2.4.21, and when I try to burn a cd in X,
> > everything locks up hard.  I've enabled kernel debugging and set up a
> > serial console to try to capture anything I can, but I don't even get a
> > panic or an oops message.  The following line is the last dying gasp
> > from syslogd:
> >
> > Jun 15 16:21:54 spike kernel: scsi : aborting command due to timeout :
> > pid 569,
> > scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00
> >
> > After that, everything is locked up hard.  Even the SysRq keys won't
> > work.  The command I was running that particular time was
> >
> > cdrecord dev=0,0,0 blank=fast
> >
> > This only seems to happen when I'm running in X.  I can use cdrecord to
> > burn cds all day when X is not running.  I haven't gotten any
> > finer-grained with it than that; I don't know if it's X itself, the
> > window manager, the desktop, nvidia's drivers, or any other bits that
> 
> Could you please try without the nvidia drivers. You will get no support here 
> with them running. There is no way of knowing what happens when these are 
> running. They have our source code, we don't have theirs.
> 
> Con
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Per Nystrom <pnystrom@netmagic.net>

