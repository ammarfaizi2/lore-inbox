Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262632AbUDDTPX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 15:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262635AbUDDTPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 15:15:23 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:12463
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262632AbUDDTPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 15:15:18 -0400
Date: Sun, 4 Apr 2004 21:15:20 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Marcello Barnaba <l.barnaba@openssl.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-aa1: Badness in __remove_from_page_cache at mm/filemap.c:104 && page_remove_rmap at mm/objrmap.c:379
Message-ID: <20040404191520.GA482@dualathlon.random>
References: <1081103153.13362.21.camel@nowhere.openssl.softmedia.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1081103153.13362.21.camel@nowhere.openssl.softmedia.lan>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 04, 2004 at 08:25:53PM +0200, Marcello Barnaba wrote:
> Hi Andrea,
> 
> I've just installed 2.6.5-aa1, and after some hours of uptime and
> testing, with everything working properly, I experienced some WARN_ON()
> triggered (my syslog became quite big :).
> 
> I've got both the nvidia and vmware modules installed.
> 
> The bug is fully reproducible, you just have to suspend a virtual
> machine from the vmware GUI, vmware-vmx starts using 100%CPU (just one
> in my 2-way SMP system), and the syslog is completely _filled_ with call
> traces:
> 
> vjt@nowhere:~$ grep Badness.in.page.remove.rmap /var/log/syslog | wc -l
> 8859
> vjt@nowhere:~$ grep Badness.in.__remove_from_pa /var/log/syslog | wc -l
> 8767
> 
> And here there are two of them (they are all identical).
> First occur the 8700 __remove_from_page_cache() warnings, and then the
> page_remove_rmap() ones.

that's an xfs bug found by Andrew, it started to be visible in -aa
because of the objrmap hardness checks from Dave. You can safely ignore
it, the xfs folks are already testing a fix. I didn't delete the WARN_ON
because it's a race condition we want to trap, but you can go ahead and
delete by hand mm/filemap.c:104 and mm/objrmap.c:379 if you're annoyed
by these warning messages. Kernel will work as stable as mainline
despite of the warnings.
