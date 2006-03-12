Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751381AbWCLK2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbWCLK2N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 05:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbWCLK2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 05:28:13 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:59816 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751381AbWCLK2N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 05:28:13 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.16-rc5-mm3: spinlock bad magic on CPU#0 on AMD64
Date: Sun, 12 Mar 2006 11:27:28 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org, ak@suse.de
References: <200603120024.04938.rjw@sisk.pl> <20060311153618.2e4b113d.akpm@osdl.org>
In-Reply-To: <20060311153618.2e4b113d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603121127.28657.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 12 March 2006 00:36, Andrew Morton wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > With the 2.6.16-rc5-mm3 kernel w/ the patch
> > 
> > revert-x86_64-mm-i386-early-alignment.patch
> > 
> > applied I'm able to hang my box (Asus L5D, 1 CPU, x86-64 kernel) solid
> > by running OpenOffice.org from under KDE (100% of the time but on one
> > user account only).  Before it hangs I get something like this on the serial console:
> > 
> > BUG: spinlock bad magic on CPU#0, soffice.bin/5293
> >  lock: ffff81005e174e28, .magic: 000001ff, .owner: .5).@4).06)./0, .owner_cpu: -2141827648
> > BUG: spinlock lockup on CPU#0, soffice.bin/5293, ffff81005e174e28
> > 
> 
> Is it a !CONFIG_SMP kernel?

Yes.

> There's no stack trace?

Well, probably there was one but it didn't appear on the serial console because
the console loglevel was too low.  I'll try to increase console_loglevel in
spin_bug() and see what happens.

[BTW, looking at the relevant code, in my case .owner_cpu appears to have only
the most significant bit set (??).]
