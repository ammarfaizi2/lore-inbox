Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030929AbWKOTYD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030929AbWKOTYD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 14:24:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030926AbWKOTYB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 14:24:01 -0500
Received: from mx1.suse.de ([195.135.220.2]:15043 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030922AbWKOTX7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 14:23:59 -0500
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [discuss] Re: 2.6.19-rc5: known regressions (v3)
Date: Wed, 15 Nov 2006 20:23:53 +0100
User-Agent: KMail/1.9.5
Cc: Andrew Morton <akpm@osdl.org>, discuss@x86-64.org,
       William Cohen <wcohen@redhat.com>, Eric Dumazet <dada1@cosmosbay.com>,
       Komuro <komurojun-mbn@nifty.com>, Ernst Herzberg <earny@net4u.de>,
       Andre Noll <maan@systemlinux.org>, oprofile-list@lists.sourceforge.net,
       Jens Axboe <jens.axboe@oracle.com>,
       linux-usb-devel@lists.sourceforge.net, phil.el@wanadoo.fr,
       Adrian Bunk <bunk@stusta.de>, Ingo Molnar <mingo@redhat.com>,
       Alan Stern <stern@rowland.harvard.edu>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       Stephen Hemminger <shemminger@osdl.org>,
       Prakash Punnoor <prakash@punnoor.de>, Len Brown <len.brown@intel.com>,
       Alex Romosan <romosan@sycorax.lbl.gov>, gregkh@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Andrey Borzenkov <arvidjaar@mail.ru>
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org> <200611151945.31535.ak@suse.de> <Pine.LNX.4.64.0611151105560.3349@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0611151105560.3349@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611152023.53960.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The fact is, it used to work, and the kernel changed interfaces, so now it 
> doesn't. 

No, it didn't work. oprofile may have done something, but it 
just silently killed the NMI watchdog in the process.
That was never acceptable.

Now we do proper accounting of NMI sources and also proper allocation
of performance counters.

 
> Yes, "oprofile" should be fixed to not depend on that, but the kernel 
> shouldn't change the interfaces, and we should add back the zero entry.

That would break the nmi watchdog again.

Anyways, there is a sysctl to disable the nmi watchdog if someone
is desperate.

But I think it is clearly oprofile who did wrong here and needs
to be fixed.

-Andi
