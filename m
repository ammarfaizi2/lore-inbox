Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262465AbVA0BTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262465AbVA0BTu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 20:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262420AbVA0AEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 19:04:51 -0500
Received: from ppsw-4.csi.cam.ac.uk ([131.111.8.134]:62337 "EHLO
	ppsw-4.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S262421AbVAZVES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 16:04:18 -0500
From: Mark Williamson <maw48@cl.cam.ac.uk>
To: Rik van Riel <riel@redhat.com>
Subject: Re: [Xen-devel] Re: [XEN] using shmfs for swapspace
Date: Wed, 26 Jan 2005 20:56:50 +0000
User-Agent: KMail/1.7.1
Cc: Arnd Bergmann <arnd@arndb.de>,
       Mark Williamson <Mark.Williamson@cl.cam.ac.uk>,
       xen-devel@lists.sourceforge.net, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050102162652.GA12268@lkcl.net> <200501050111.59072.arnd@arndb.de> <Pine.LNX.4.61.0501211634380.15744@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.61.0501211634380.15744@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501262056.50981.maw48@cl.cam.ac.uk>
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > - Pseudo faults:
>
> These are a problem, because they turn what would be a single
> pageout into a pageout, a pagein, and another pageout, in
> effect tripling the amount of IO that needs to be done.

The Disco VMM tackled this by detecting attempts to double-page using a 
special virtual swap disk.  Perhaps it would be possible to find some cleaner 
way to avoid wasteful double-paging by adding some more hooks for virtualised 
architectures...

In any case, for now Xen guests are not swapped onto disk storage at runtime - 
they retain their physical memory reservation unless they alter it using the 
balloon driver.

> Xen already has this.  I wonder if it makes sense to
> consolidate the various balloon approaches into a single
> driver, and keep the amount of ballooned memory into
> account when reporting statistics in /proc/meminfo.

If multiple platforms want to do this, we could refactor the code so that the 
core of the balloon driver can be used in multiple archs.  We could have an 
arch_release/request_memory() that the core balloon driver can call into to 
actually return memory to the VMM.

> > When you want to introduce some interface in Xen, you probably want
> > something more powerful than these,
>
> Xen has a nice balloon driver, that can also be
> controlled from outside the guest domain.

The Xen control interface made this fairly trivial to implement.  Again, the 
balloon driver core could be plumbed into whatever the preferred virtual 
machine control interface for the platform is (I don't know if / how other 
platforms tackle this).

Cheers,
Mark
