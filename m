Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268875AbTCCX3K>; Mon, 3 Mar 2003 18:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268879AbTCCX3K>; Mon, 3 Mar 2003 18:29:10 -0500
Received: from mail3.bluewin.ch ([195.186.1.75]:30399 "EHLO mail3.bluewin.ch")
	by vger.kernel.org with ESMTP id <S268875AbTCCX3I>;
	Mon, 3 Mar 2003 18:29:08 -0500
Date: Tue, 4 Mar 2003 00:39:23 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Troels Haugboelle <troels_h@astro.ku.dk>, Pavel Machek <pavel@suse.cz>,
       bert hubert <ahu@ds9a.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] Re: S4bios support for 2.5.63
Message-ID: <20030303233923.GA2234@k3.hellgate.ch>
Mail-Followup-To: Nigel Cunningham <ncunningham@clear.net.nz>,
	Troels Haugboelle <troels_h@astro.ku.dk>,
	Pavel Machek <pavel@suse.cz>, bert hubert <ahu@ds9a.nl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030302202118.GA2201@outpost.ds9a.nl> <20030303003940.GA13036@k3.hellgate.ch> <1046657290.8668.33.camel@laptop-linux.cunninghams> <20030303113153.GA18563@outpost.ds9a.nl> <20030303122325.GA20929@atrey.karlin.mff.cuni.cz> <20030303123551.GA19859@outpost.ds9a.nl> <20030303124133.GH20929@atrey.karlin.mff.cuni.cz> <1046700474.3782.197.camel@localhost> <20030303143006.GA1289@k3.hellgate.ch> <1046729210.1850.8.camel@laptop-linux.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1046729210.1850.8.camel@laptop-linux.cunninghams>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.5.63 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Mar 2003 11:06:50 +1300, Nigel Cunningham wrote:
> On Tue, 2003-03-04 at 03:30, Roger Luethi wrote:
> > Not sure I follow all of your story but I can confirm that hdparm -u1
> > successfully gets me to the kernel panic due to highmem support still
> > lacking -- i.e. way beyond the BUG_ON() I've been hitting. So it looks
> > like you found a good work-around.
> 
> You were hitting the BUG_ON before swsusp was even trying to write the
> image?!! That is interesting! Since count_and_copy is first called post
> driver suspend in the current version, perhaps they are somehow related.
> (This is before swsusp tries to write any of the image to disk).

Huh? After a glance at the code I agree that drivers_suspend happens before
count_and_copy_data_pages, but that means hitting the BUG_ON in
idedisk_suspend before the panic in count_and_copy_data_pages is what I'd
expect. How is that remarkable? ... My current kernel has HIGHMEM enabled,
but previous ones that failed the same way didn't.

Anyway, a few more tests showed that hdparm -u1 helps if I have lots of
memory used (say for fs caches). In two out of two tests, I saw Pavel's
request to send him 1 GB RAM via email.

Suspending directly from a clean boot (after issuing the same hdparm -u1
commands for both disks) I hit the BUG_ON in idedisk_suspend (two out of
two tests, too).

Roger
