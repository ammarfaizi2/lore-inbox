Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270208AbTHBTDR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 15:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270210AbTHBTDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 15:03:17 -0400
Received: from fw.osdl.org ([65.172.181.6]:9377 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270208AbTHBTDP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 15:03:15 -0400
Date: Sat, 2 Aug 2003 12:04:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2-mm2
Message-Id: <20030802120418.02785fda.akpm@osdl.org>
In-Reply-To: <20030802151905.GA5344@suse.de>
References: <20030730223810.613755b4.akpm@osdl.org>
	<20030802151905.GA5344@suse.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@codemonkey.org.uk> wrote:
>
> On Wed, Jul 30, 2003 at 10:38:10PM -0700, Andrew Morton wrote:
> 
>  > +intel-agp-oops-fix.patch
>  >  another oops fix
> 
> patch is correct, but I'm wondering what managed to iterate that
> far, do you have any hw info on the box that oopsed ?

Nah, that patch is bogus:

 	.subdevice	= PCI_ANY_ID,
 	},
-	{ }
+	{ 0, },

These two things are equivalent: it is a no-op.

The bug was actually the __devinitdata problem.

>  > +pci_device_id-devinitdata.patch
>  >  Move lots of PCI device_id tables out of __initdata
> 
> How embarressing. Russell King noticed a similar problem
> in agpgart a while back, and I overlooked the adjacent struct.
> Likewise, I goofed in cpufreq. Oops.  Thanks for fixing them up.

Greg did a tree-wide sweep and removed __devinitdata and __initdata from a
large number of pci_device_id tables.  Linus merged that yesterday.

