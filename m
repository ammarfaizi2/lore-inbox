Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751667AbWBMJWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751667AbWBMJWf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 04:22:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751668AbWBMJWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 04:22:35 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:40484 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751666AbWBMJWe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 04:22:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=ueSf+viclyE7OEoZCFCilLsqaowHE5uFRmHgHTsKgkigAxVCXVp5a2ZuwA4GLbyopjQEGv+6rA1QbOH4JSIQtqAD6xTiLzTIRPZFTOqINjP8wCBmp7OYdZ3HTd0C/PfRv6ccpJZdL5CZ3YwCrwDbP5AgdUVYdMGV12XcrMw8Sjc=
Message-ID: <43F04FCE.9030309@gmail.com>
Date: Mon, 13 Feb 2006 10:22:22 +0100
From: Patrizio Bassi <patrizio.bassi@gmail.com>
Reply-To: patrizio.bassi@gmail.com
Organization: patrizio.bassi@gmail.com
User-Agent: Mozilla Thunderbird 1.5 (X11/20060112)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>,
       James Bottomley <James.Bottomley@steeleye.com>,
       "Brown, Len" <len.brown@intel.com>,
       "David S. Miller" <davem@davemloft.net>, Greg KH <greg@kroah.com>,
       linux-acpi@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       "Yu, Luming" <luming.yu@intel.com>, Ben Castricum <lk@bencastricum.nl>,
       sanjoy@mrao.cam.ac.uk, Helge Hafting <helgehaf@aitel.hist.no>,
       "Carlo E. Prelz" <fluido@fluido.as>,
       =?ISO-8859-1?Q?Gerrit_Bruchh=E4us?= =?ISO-8859-1?Q?er?= 
	<gbruchhaeuser@gmx.de>,
       Nicolas.Mailhot@LaPoste.net, Jaroslav Kysela <perex@suse.cz>,
       Takashi Iwai <tiwai@suse.de>,
       =?ISO-8859-1?Q?Bj=F6rn_Nilsson?= <bni.swe@gmail.com>,
       Andrey Borzenkov <arvidjaar@mail.ru>, "P. Christeas" <p_christ@hol.gr>,
       ghrt <ghrt@dial.kappa.ro>, jinhong hu <jinhong.hu@gmail.com>,
       Andrew Vasquez <andrew.vasquez@qlogic.com>, linux-scsi@vger.kernel.org,
       Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: Linux 2.6.16-rc3
References: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org> <20060212190520.244fcaec.akpm@osdl.org>
In-Reply-To: <20060212190520.244fcaec.akpm@osdl.org>
X-Enigmail-Version: 0.93.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton ha scritto:
> We still have some serious bugs, several of which are in 2.6.15 as well:
>
> - The scsi_cmd leak, which I don't think is fixed.
>
> - The some-x86_64-boxes-use-GFP_DMA-from-bio-layer bug, which causes
>   oom-killings.
>
> - The skbuff_head_cache leak, which has been around since at least
>   2.6.11.  Another box-killer, but is seems very hard to hit. 
>   (mki@mozone.net, "the dreaded oom-killer (reproducable in 2.6.11 -
>   2.6.16-rc1) :(")
>
> - http://bugzilla.kernel.org/show_bug.cgi?id=6060: an apparent ACPI
>   regression.
>
> - Nathan's "sysfs-related oops during module unload", which Greg seems to
>   have under control.
>
> - http://bugzilla.kernel.org/show_bug.cgi?id=6049 - another acpi
>   regression.  We have the actual offending commit here.
>
> - A couple of random tty-related oopses reported by Jesper Juhl.  We
>   don't know why these happened - they appear to not be related to the tty
>   buffering changes.
>
> - http://bugzilla.kernel.org/show_bug.cgi?id=6038, another box-killing
>   acpi regression.
>
> - Various reports similar to
>   http://bugzilla.kernel.org/show_bug.cgi?id=6011, seemingly related to USB
>   PCI quirk handling.
>
> - "Ben Castricum" <lk@bencastricum.nl> reports that ppp has started
>   exhibiting mysterious failures (again).
>
> - Nasty warnings from scsi about kobject-layer things being called from
>   irq context.  James has a push-it-to-process-context patch which sadly
>   assumes kmalloc() is immortal, but no other fix seems to have offered
>   itself.
>
> - In http://bugzilla.kernel.org/show_bug.cgi?id=5989, Sanjoy Mahajan has
>   another regression, but he's off collecting more info.
>
> - Helge Hafting reports a usb printer regression - I don't know if that's
>   still live?
>
> - "Carlo E.  Prelz" <fluido@fluido.as> has another USB/ehci regression
>   ("ATI RS480-based motherboard: stuck while booting with kernel >= 2.6.15
>   rc1").
>
> - Gerrit Bruchhuser <gbruchhaeuser@gmx.de> seems to have an aic7xxx
>   regression ("AHA-7850 doesn't detect scanner anymore") but he doesn't say
>   which kernel got it right.
>
> - http://bugzilla.kernel.org/show_bug.cgi?id=5914 - a sata bug (which is
>   quite unremarkable :(), but this one is reported to eat filesystems.
>
> - Patrizio Bassi <patrizio.bassi@gmail.com> has an alsa suspend
>   regression ("alsa suspend/resume continues to fail for ens1370")
>
> - Bjorn Nilsson <bni.swe@gmail.com> has an sk99lin regression ("3COM
>   3C940, does not work anymore after upgrade to 2.6.15")
>
> - Andrey Borzenkov <arvidjaar@mail.ru> has an acpi-cpufreq regression
>   ("cannot unload acpi-cpufreq")
>
> - "P.  Christeas" <p_christ@hol.gr> had an autofs regression ("Regression
>   in Autofs, 2.6.15-git"), whic might be fixed now?
>
> - ghrt <ghrt@dial.kappa.ro> reports an alsa regression ("PROBLEM: SB
>   Live!  5.1 (emu10k1, rev.  0a) doesn't work with 2.6.15")
>
> - jinhong hu <jinhong.hu@gmail.com> reports what appears to be a qlogic
>   regression ("kernel 2.6.15 scsi problem")
>
> - Benjamin LaHaise <bcrl@kvack.org> had an NFS problem ("NFS processes
>   gettting stuck in D with currrent git").
>
>
>
> These are clear regressions, reported in the last month by people who are
> willing to test patches.  They're almost all in subsystems which have
> active and professional maintainers.
>
>   
Really sad to say, but my Alsa ens1370 regression due to suspend problem
is still there.
Only fix is reboot actually. Ready to patch :)

PS.

i have a bug similar to:
http://bugzilla.kernel.org/show_bug.cgi?id=6038 (marked as blocking by
Andrew)
on my laptop.

but my dma expiry problem only happens during suspend.
I have a Sis 630 chipset with a 2.5" hitachi drive.
Been there...for ages..i can say: always...never got a working 2.6 kernel.
However in my poor opinion it's not blocking on my system, just boring.


Patrizio
