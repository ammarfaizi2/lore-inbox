Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752163AbWAELrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752163AbWAELrm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 06:47:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752115AbWAELrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 06:47:42 -0500
Received: from affenbande.org ([81.169.150.36]:28038 "EHLO
	tarzan.affenbande.org") by vger.kernel.org with ESMTP
	id S1752163AbWAELrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 06:47:40 -0500
Date: Thu, 5 Jan 2006 12:43:17 +0100
From: Florian Schmidt <tapas@affenbande.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Tomasz =?ISO-8859-1?Q?K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>,
       Adrian Bunk <bunk@stusta.de>, Jesper Juhl <jesper.juhl@gmail.com>,
       Takashi Iwai <tiwai@suse.de>, Olivier Galibert <galibert@pobox.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Andi Kleen <ak@suse.de>,
       perex@suse.cz, alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
       kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
       jgarzik@pobox.com, Thorsten Knabe <linux@thorsten-knabe.de>,
       zwane@commfireservices.com, zaitcev@yahoo.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Message-ID: <20060105124317.2d12a85c@mango.fruits.de>
In-Reply-To: <1136445395.24475.17.camel@mindpipe>
References: <s5h1wzpnjrx.wl%tiwai@suse.de>
	<20060103203732.GF5262@irc.pl>
	<s5hvex1m472.wl%tiwai@suse.de>
	<9a8748490601031256x916bddav794fecdcf263fb55@mail.gmail.com>
	<20060103215654.GH3831@stusta.de>
	<20060103221314.GB23175@irc.pl>
	<20060103231009.GI3831@stusta.de>
	<Pine.BSO.4.63.0601040048010.29027@rudy.mif.pg.gda.pl>
	<20060104000344.GJ3831@stusta.de>
	<Pine.BSO.4.63.0601040113340.29027@rudy.mif.pg.gda.pl>
	<20060104010123.GK3831@stusta.de>
	<Pine.BSO.4.63.0601040242190.29027@rudy.mif.pg.gda.pl>
	<20060104113726.3bd7a649@mango.fruits.de>
	<1136445395.24475.17.camel@mindpipe>
Organization: affenbande
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Jan 2006 02:16:35 -0500
Lee Revell <rlrevell@joe-job.com> wrote:

> On Wed, 2006-01-04 at 11:37 +0100, tapas wrote:
> > ALSA's kernel level OSS emulation (as opposed to aoss) cannot provide
> > software mixing. As aoss cannot provide OSS emulation to all OSS apps
> 
> Why not?

I did write it out before. aoss is a LD_PRELOAD hack. Apps/libs that
resolve the system call symbols at build time cannot be made to use
these calls from a different lib (which is what LD_PRELOAD tries to do).
A famous example is libc for which a workaround was added (as libc
offers its own mechanism to intercept fopen() et al.). Others can lurk
in the background, too. It would even be trivial to write an app that
aoss will not work with - ever (unless the code be modified - which is
not an option for closed source apps).

It simply cannot ever work with _all_ apps (as opposed to kernel level
OSS emu  which can be made to work with _all_ apps (at least in
principle)).

Errm, i'm actually wrong about that. Kernel level OSS emu sw mixing
cannot work together with userspace ALSA sw mixing. I completely missed
that point.

I still think, the easiest way would be to use FUSE as it gives the best
of both worlds:

- device file access as opposed to LD_PRELOAD hack (which has principle
problems)

- access to userspace ALSA lib which would allow it to work together
with ALSA's sw mixing for native ALSA apps.

Maybe it can be developed as a third alternative independently. People
without FUSE would have to try their luck with the other two. Plus,
there's oss2jack which can probably be modified to use ALSA instead of
jack (although i thinkg oss2jack actually uses fusd and not FUSE. Hmm,
some more hacking would be required then). Also i think a FUSE based
approach is actually less ugly than a LD_PRELOAD hack. 

BTW: Don't expect people to always write bug reports. We all know,
people are lazy. More often than not, they simply give up and say "linux
sucks" to their friends. Or if they can differentiate a little more,
they'll say "ALSA sucks" ;) [<- smiley, indicates humor]. Especially
those who use closed source apps ;)

Regards,
Flo

-- 
Palimm Palimm!
http://tapas.affenbande.org
