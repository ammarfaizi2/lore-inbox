Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261941AbVGSEga@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261941AbVGSEga (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 00:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbVGSEga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 00:36:30 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:23648 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S261941AbVGSEg3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 00:36:29 -0400
Date: Tue, 19 Jul 2005 06:36:22 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-kernel@vger.kernel.org, rth@twiddle.net, dhowells@redhat.com,
       kumar.gala@freescale.com, davem@davemloft.net, mhw@wittsend.com,
       support@comtrol.com, R.E.Wolff@BitWizard.nl, nils@kernelconcepts.de,
       cjtsai@ali.com.tw, Lionel.Bouton@inet6.fr, benh@kernel.crashing.org,
       mchehab@brturbo.com.br, laredo@gnu.org, rbultje@ronald.bitfreak.net,
       middelin@polyware.nl, philb@gnu.org, tim@cyberelk.net,
       campbell@torque.net, andrea@suse.de, linux@advansys.com,
       lnz@dandelion.com, chirag.kantharia@hp.com, mike@i-Connect.Net,
       mulix@mulix.org
Subject: Re: [PATCH] pci_find_device --> pci_get_device
Message-ID: <20050719043621.GA14657@bitwizard.nl>
References: <42DC4873.2080807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42DC4873.2080807@gmail.com>
Organization: BitWizard.nl
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2005 at 02:25:23AM +0200, Jiri Slaby wrote:
> The patch is for mixed files from all over the tree.
> 
> Kernel version: 2.6.13-rc3-git4
> 
> * This patch removes from kernel tree pci_find_device and changes
> it with pci_get_device. Next, it adds pci_dev_put, to decrease reference
> count of the variable.
> * Next, there are some (about 10 or so) gcc warning problems (i. e.
> variable may be unitialized) solutions, which were around code with old
> pci_find_device.
> * Some code was unpretty, or ugly, so the patch provides more readable
> code, in some cases.
> * Marks the function as deprecated in pci.h

Hi Jiri, 

The patch grabs reference counts to pdev structures, but almost never
decreases the reference counts. 

If you are working in a team, and want others to be able to continue
where you left off, you should add a comment, even if it is repetitive
to state what needs to be done. 

As far as I can see, you grab a reference to the "pdev" on 
initialization, and never release it. Or you only release it in 
certain error conditions. Would this make the driver unable to 
be unloaded and reloaded? That would not be good. 

	Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
Q: It doesn't work. A: Look buddy, doesn't work is an ambiguous statement. 
Does it sit on the couch all day? Is it unemployed? Please be specific! 
Define 'it' and what it isn't doing. --------- Adapted from lxrbot FAQ
