Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271206AbTG2CEe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 22:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271224AbTG2CEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 22:04:34 -0400
Received: from CPE-65-29-19-166.mn.rr.com ([65.29.19.166]:34689 "EHLO
	www.enodev.com") by vger.kernel.org with ESMTP id S271206AbTG2CEc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 22:04:32 -0400
Subject: Re: 2.6.0-test2-mm1: Can't mount root
From: Shawn <core@enodev.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20030728150245.42f57f89.akpm@osdl.org>
References: <1059428584.6146.9.camel@localhost>
	 <20030728144704.49c433bc.akpm@osdl.org>
	 <1059430015.6146.15.camel@localhost>
	 <20030728150245.42f57f89.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1059444271.4786.25.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 28 Jul 2003 21:04:31 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, mucho more info (no wonder root=/dev/hde5 no worky):
        VP_IDE: (ide_setup_pci_device:) Could not enable device

Found out my on board via pci ide was not getting initialized under
-test2-mm1, so I went looking for driver/ide/pci/via82cxxx in the diffs.
I found this in the -test2 diff:
-                                    (((u >> i) & 7) < 8))) {
+                                    (((u >> i) & 7) < 6))) {
...and reversing it did not change anything.

The only other diff I could think might matter to 
drivers/ide/setup-pci.c
-static unsigned long __init ide_get_or_set_dma_base (ide_hwif_t *hwif)
+static unsigned long ide_get_or_set_dma_base (ide_hwif_t *hwif)
...which does not look like it should kill my via ide...

I am now totally at my wit's end. Can I be helped now that I got off my
fat arse?

Info about my system:
http://www.enodev.com/lspci.txt
http://www.enodev.com/dmesg
http://www.enodev.com/proc-ioports
http://www.enodev.com/proc-interrupts
http://www.enodev.com/proc-iomem
http://www.enodev.com/proc_sex.html

On Mon, 2003-07-28 at 17:02, Andrew Morton wrote:
> Shawn <core@enodev.com> wrote:
> >
> > Thank you, I didn't look very closely at the patch (really at all). 
> > 
> > The one thing making me think I had it right with "2105" was that the
> > kernel did seem to grok it as (33,5).
> 
> I don't understand.  Are you saying that you now have it working?
> If so, how?

