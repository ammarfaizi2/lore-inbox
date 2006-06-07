Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751399AbWFGAYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbWFGAYc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 20:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWFGAYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 20:24:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20675 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751399AbWFGAYb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 20:24:31 -0400
Date: Tue, 6 Jun 2006 17:24:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: jeremy@goop.org, dzickus@redhat.com, ak@suse.de, shaohua.li@intel.com,
       miles.lane@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6.17-rc5-mm2] crash when doing second suspend: BUG in
 arch/i386/kernel/nmi.c:174
Message-Id: <20060606172410.b901950e.akpm@osdl.org>
In-Reply-To: <200606071013.53490.ncunningham@linuxmail.org>
References: <4480C102.3060400@goop.org>
	<200606070938.34927.ncunningham@linuxmail.org>
	<44861899.1040506@goop.org>
	<200606071013.53490.ncunningham@linuxmail.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jun 2006 10:13:49 +1000
Nigel Cunningham <ncunningham@linuxmail.org> wrote:

> > the new CPU to get the same state as the old one just because it ends up
> > with the same logical CPU number?  Perhaps, but what if it doesn't even
> > have the same capabilities?  (Do we support heterogeneous CPUs anyway?)
> 
> Indeed. I'm also not sure that there's necessarily a guarantee that cpus will 
> be hotplugged in the same order. Perhaps those with more knowledge can 
> clarify there.

It all depends on what we mean by "per-cpu state".  If we were to remember
that "CPU 7 needs 0x1234 in register 44" then that would be wrong.  But
remembering some high-level functional thing like "CPU 7 needs to run the
NMI watchdog" is fine.  The CPU bringup code can work out whether that is
possible, and how to do it.


