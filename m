Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314468AbSEKGSA>; Sat, 11 May 2002 02:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314613AbSEKGR7>; Sat, 11 May 2002 02:17:59 -0400
Received: from surf.viawest.net ([216.87.64.26]:8090 "EHLO surf.viawest.net")
	by vger.kernel.org with ESMTP id <S314468AbSEKGR6>;
	Sat, 11 May 2002 02:17:58 -0400
Date: Fri, 10 May 2002 23:17:46 -0700
From: A Guy Called Tyketto <tyketto@wizard.com>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5] opl3 OSS emulation compile fixes
Message-ID: <20020511061746.GA1845@wizard.com>
In-Reply-To: <20020510112819.GA26247@wizard.com> <Pine.LNX.4.44.0205101516200.6271-100000@netfinity.realnet.co.sz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux/2.5.15 (i686)
X-uptime: 10:16pm  up 3 min,  3 users,  load average: 0.04, 0.03, 0.00
X-RSA-KeyID: 0xE9DF4D85
X-DSA-KeyID: 0xE319F0BF
X-GPG-Keys: see http://www.wizard.com/~tyketto/pgp.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2002 at 03:18:15PM +0200, Zwane Mwaikambo wrote:
> On Fri, 10 May 2002, A Guy Called Tyketto wrote:
> 
> >         This is for OPL3 OSS emulation. With your patch applied to 2.5.15, 
> > opl3_oss.c was not compiled at all, whether into the kernel, or as a module. 
> > Also, your patch for include/sound/opl3.h did not need to be applied as the 
> > #ifdef CONFIG_SND_OSSEMUL and #endif lines are already present sound the two 
> > variables listed.
> 
> For my amusement, could you try loading the opl3 module, i didn't get 
> unresolved symbols when i did a depmod. From what i understand of this, 
> opl3_oss should not have been compiled indeed unless CONFIG_SND_OSSEMUL 
> was specified, although Kysela would know best.
> 

        No problem.. modprobe ran cleanly without any unresolved symbols. 
however, with those programs needing OSS opl3 emulation (xmms, mpg123, 
realplayer to name a few), this won't do much good less they forsake OSS 
altogether. The 3 programs above (except xmms, which I believe works with 
ALSA) depend on /dev/dsp existing for them to run. /dev/dsp gets created 
(using DevFS here) when snd-pcm-oss.o is inserted at modprobe time. Hence, the 
below:

root@bellicha:~# modprobe snd-fm801
modprobe: Can't locate module snd-pcm-oss
/lib/modules/2.5.15/kernel/sound/pci/snd-fm801.o: post-install snd-fm801 failed
/lib/modules/2.5.15/kernel/sound/pci/snd-fm801.o: insmod snd-fm801 failed

/etc/modules.conf:

# This is for the new ForteMedia 801 card now, using ALSA.
alias char-major-116 snd
# OSS/Free emulation
alias char-major-14 soundcore
alias snd-card-0 snd-fm801
alias sound-slot-0 snd-card-0
alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss
options snd snd_major=116 snd_cards_limit=1
post-install snd-fm801 modprobe "-k" "snd-pcm-oss"

        For those to run, opl3_oss.c needs to be compiled, which leads back to 
where we were before..

                                                        BL.
-- 
Brad Littlejohn                         | Email:        tyketto@wizard.com
Unix Systems Administrator,             |           tyketto@ozemail.com.au
Web + NewsMaster, BOFH.. Smeghead! :)   |   http://www.wizard.com/~tyketto
  PGP: 1024D/E319F0BF 6980 AAD6 7329 E9E6 D569  F620 C819 199A E319 F0BF

