Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbVABDqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbVABDqO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jan 2005 22:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVABDqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jan 2005 22:46:13 -0500
Received: from orb.pobox.com ([207.8.226.5]:49868 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261239AbVABDqM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jan 2005 22:46:12 -0500
Date: Sat, 1 Jan 2005 19:46:06 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Cc: John M Flinchbaugh <john@hjsoft.com>, linux-kernel@vger.kernel.org,
       pavel@ucw.cz
Subject: Re: 2.6.10: e100 network broken after swsusp/resume
Message-ID: <20050102034606.GA7406@ip68-4-98-123.oc.oc.cox.net>
References: <20041228144741.GA2969@butterfly.hjsoft.com> <20050101172344.GA1355@elf.ucw.cz> <20050101172344.GA1355@elf.ucw.cz> <20050101221722.GA28045@butterfly.hjsoft.com> <E1CksSX-0003Ki-00@chiark.greenend.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CksSX-0003Ki-00@chiark.greenend.org.uk>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 01, 2005 at 11:14:57PM +0000, Matthew Garrett wrote:
> Does pci=routeirq make any difference?

I'm not the original poster, and I haven't read this whole thread yet,
but I may have some useful input...

I think I'm seeing this problem (with the same symptoms) with both e100
and 8139too, on two different machines. It started with 2.6.10-rc1-bk24;
bk23 works fine.

I haven't tested my e100 system (laptop) as thoroughly as my 8139too system
(desktop), but this is what I'm seeing with 8139too:

Adding pci=routeirq makes the problem go away. Using acpi=off *instead* of
pci=routeirq also makes the problem go away. If I use "noapic" instead
of acpi=off or pci=routeirq, I get a different variant of the problem:
Almost immediately after resume, there's a kernel log message that the
NIC's interrupt has been disabled (I forget the exact wording). Checking
/proc/interrupts shows that the NIC's interrupt (which is not shared
with any other devices) has shot up to 100000 interrupts. (This
phenomenon does not happen if I do not specify noapic.)

Now I'll go and read the rest of this thread. If there's any more
information I need to provide or anything else I need to try, let me
know.

-Barry K. Nathan <barryn@pobox.com>

