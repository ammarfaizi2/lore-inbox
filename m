Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264203AbTF0Lmn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 07:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264208AbTF0Lmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 07:42:43 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:41405 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id S264203AbTF0Lml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 07:42:41 -0400
Date: Fri, 27 Jun 2003 12:58:17 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: "Brown, Len" <len.brown@intel.com>
cc: "'Arjan van de Ven'" <arjanv@redhat.com>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       Andrew Morton <akpm@digeo.com>, <torvalds@transmeta.com>,
       <acpi-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: RE: [BK PATCH] acpismp=force fix
In-Reply-To: <A5974D8E5F98D511BB910002A50A66470B981205@hdsmsx103.hd.intel.com>
Message-ID: <Pine.LNX.4.44.0306271221110.1197-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jun 2003, Brown, Len wrote:
> 
> I think there should be a boot-option to use ACPI for boot-time
> configuration tables, but to not load the driver for run-time event
> handling.  This is useful for enabling HT on systems with broken ACPI
> run-time BIOS.

I may be wrong, I think it was Arjan persuaded AndrewG to allow the
acpitable.c code into 2.5 for this case.  At present it's enabled by
config option instead of boot option, in both 2.5 (where the config
option didn't actually work, patch posted for that a couple of days ago)
and in 2.4.22-pre (which thus diverges from 2.4.21).  That surprises me,
but I'd definitely defer to Arjan's preference.

> UnitedLinux uses "acpi=oldboot" for this.  While 'old' will become ambiguous
> when today's "new" becomes tomorrow's "old";-), I do like "acpi={something}"
> rather than complicating matters with non "acpi=" syntax.

I agree with you.

> Re: "acpismp=force"
> I wouldn't miss it.  Sounds unanimous.

It did have some point before, recent changes have rendered it pointless,
and even if those changes get revised, there'll be a better way than the
confusing "acpismp=force".

> Re: "noht"
> To disable HT on a uni-processor, wouldn't it be preferable to simply run
> the UP kernel rather than the SMP kernel with HT disabled?

Yes, though wouldn't BIOS be able to disable it on those too?

> That leaves SMP
> systems, where either the BIOS could disable it (it is a BIOS bug if it
> can't), or as a last resort CONFIG_X86_HT (2.5) could be config'd out of the
> kernel.  I guess I've talked myself into not missing "noht" also.

I fathered "noht", so feel some responsibility for it.  In its present
state it's simply buggered in both 2.5 and 2.4.22-pre, and I'd much rather
kill it off than leave it around in that misery.  If we can always switch
off in BIOS instead, I guess it's redundant and should go.  Arjan remarked
that it's no problem to honor it codewise in 2.4: up to 2.4.21 it was easy,
but now beyond what I can safely mess with - I'm hoping someone (perhaps
beginning with A?) might reprieve it, but if not I'll send patches to
remove it from 2.4 and 2.5 in a few weeks time.

Hugh

