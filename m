Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbWBCOc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbWBCOc7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 09:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbWBCOc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 09:32:59 -0500
Received: from uproxy.gmail.com ([66.249.92.200]:46249 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750797AbWBCOc6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 09:32:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jZgS/5vYn+Bf2B/7ckS4mTg/k8rtwjAEYNswC7rQ/bQFdfm/sfrvOFH+SXxoSb6GTYustYVNYIOfLtxUJXNPyLW1Q0AuaZwgap8oXdQ5UlbaAx1Qxx9UwvQpqmdGj65ryy6/KGqksKeKCI4Umg4cz9BVvCE1oOaTkgmvrFuRQoE=
Message-ID: <58cb370e0602030632p2168fbeaga2a1089b1eea8dfc@mail.gmail.com>
Date: Fri, 3 Feb 2006 15:32:55 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Subject: Re: [ 00/10] [Suspend2] Modules support.
Cc: Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       nigel@suspend2.net, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>, Shaohua Li <shaohua.li@intel.com>
In-Reply-To: <E1F51dd-0005cc-00@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060201113710.6320.68289.stgit@localhost.localdomain>
	 <20060202152316.GC8944@ucw.cz> <20060202132708.62881af6.akpm@osdl.org>
	 <1138916079.15691.130.camel@mindpipe>
	 <20060202142323.088a585c.akpm@osdl.org>
	 <20060203105100.GD2830@elf.ucw.cz>
	 <58cb370e0602030322u4c2c9f9bm21a38be6d35d2ea6@mail.gmail.com>
	 <20060203113543.GA3056@elf.ucw.cz>
	 <58cb370e0602030546q2ea4b70bq1dc66306d5ef1b12@mail.gmail.com>
	 <E1F51dd-0005cc-00@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/06, Matthew Garrett <mgarrett@chiark.greenend.org.uk> wrote:
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
>
> > This is untrue as Linux has support for setting IDE controller
> > and drives.  It was added by Benjamin Herrenschmidt in late
> > 2.5.x or early 2.6.x (I don't remember exact kernel version).
>
> In generic_ide_resume, rqpm.pm_step gets set to
> ide_pm_state_start_resume and ide_do_drive_cmd gets called. This ends up
> being passed through to start_request. start_request waits for the BSY
> bit to go away. On the affected hardware I've seen, this never happens
> unless the ACPI calls are made. As far as I can tell, there's nothing in
> the current driver code that does anything to make sure that the bus is
> in a state to accept commands at this point - the pci drivers don't (for
> the most part) seem to have any resume methods. Calling the ACPI _STM
> method before attempting to do this magically makes everything work.

I don't see anything that prevents addition of ->suspend and ->resume
for IDE PCI host drivers (not IDE core issue) if some special sequence
is needed.

I see that we may be doing PIO/DMA setup too late (IDE core issue)
for some controllers.

Could you fill a bug at kernel bugzilla with data as much data about
affected hardware as possible (dmesg, kernel config, lspci -vvv -xxx
before susped and if possible PCI configuration dumped from kernel
after suspend)?

What is the current state of IDE ACPI patches?
Were the issues raised on linux-ide addressed?

Thanks,
Bartlomiej
