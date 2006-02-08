Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965174AbWBHQAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965174AbWBHQAH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 11:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965168AbWBHQAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 11:00:06 -0500
Received: from washoe.rutgers.edu ([165.230.95.67]:16849 "EHLO
	washoe.rutgers.edu") by vger.kernel.org with ESMTP id S965174AbWBHQAE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 11:00:04 -0500
Date: Wed, 8 Feb 2006 11:00:03 -0500
From: Yaroslav Halchenko <yoh@psychology.rutgers.edu>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: sound problem on recent PowerBook5,8 MacRISC3
Message-ID: <20060208160002.GI5538@washoe.onerussian.com>
Mail-Followup-To: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-URL: http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: 3BB6 E124 0643 A615 6F00  6854 8D11 4563 75C0 24C8
User-Agent: mutt-ng/devel-r556 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Kernel People,

Sound fails to work on the PowerBook laptop
information on which could be found from
http://www.onerussian.com/Linux/bugs/bug.sound/

On 2.6.16-rc1 and got
dmasound_pmac: couldn't find a Codec we can handle
....
snd: Unknown layout ID 0x52
(and ALSA failed to find any device)

I added 0x52 layout in the list within sound/ppc/pmac.c

                case 0x50:
                case 0x52:
                case 0x5c:
                        chip->num_freqs = ARRAY_SIZE(tumbler_freqs);
                        chip->model = PMAC_SNAPPER;
                        chip->can_byte_swap = 0; /* FIXME: check this */
                        chip->control_mask = MASK_IEPC | 0x11;/* disable IEE */
                        break;
after reboot (it was compiled in) and I get
 dmasound_pmac: couldn't find a Codec we can handle
 ...
 snd: can't request rsrc  0 (Sound Control: 0x80000000:80004fff)

I copied pmac.c from 2.6.16-rc2, added 0x52, compiled, reboot and I get
just
dmasound_pmac: couldn't find a Codec we can handle

and no sound -- I have just

$ ls /dev/{snd,dsp,audio}*
ls: /dev/dsp*: No such file or directory
ls: /dev/audio*: No such file or directory
/dev/sndstat

/dev/snd:
seq  timer



Pre history:
I need to configure Linux in place of OS-X on my chief's laptop. After
some struggle I managed to install Ubuntu Dapper which was running their
2.6.15-14. I had few issues:
sound kinda was there but nothing was produced audible,
video - box freezes under some xorg config as reported
elsewhere https://launchpad.net/malone/bugs/30426 
and decided to give a try to vanilla kernel so I could also report a bug.

-- 
Yaroslav Halchenko
Research Assistant, Psychology Department, Rutgers-Newark
Office: (973) 353-5440x263 | FWD: 82823 | Fax: (973) 353-1171
        101 Warren Str, Smith Hall, Rm 4-105, Newark NJ 07105
Student  Ph.D. @ CS Dept. NJIT
