Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbWDXNIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbWDXNIw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 09:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbWDXNIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 09:08:52 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:64452 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750766AbWDXNIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 09:08:51 -0400
Subject: Re: Problems with EDAC coexisting with BIOS
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Gross, Mark" <mark.gross@intel.com>
Cc: bluesmoke-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>,
       "Carbonari, Steven" <steven.carbonari@intel.com>,
       "Ong, Soo Keong" <soo.keong.ong@intel.com>,
       "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>
In-Reply-To: <5389061B65D50446B1783B97DFDB392D998732@orsmsx411.amr.corp.intel.com>
References: <5389061B65D50446B1783B97DFDB392D998732@orsmsx411.amr.corp.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 24 Apr 2006 14:19:07 +0100
Message-Id: <1145884747.29648.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2006-04-21 at 09:01 -0700, Gross, Mark wrote:
> 1) The default AMI BIOS behavior on SMI is to check the chipset error
> registers (Dev0:Fun1) and re-hide them.

The words "bad design" come to mind (followed by a large number of more
accurate phrases that are inappropriate for a public list)

> Basically if device 0 : function 1 is hidden by the platform at boot
> time un-hiding and using the device and function is a risky thing to do,

Intel provided patches that do exactly this for some of the chip
workarounds. Are you saying the Intel chip work around also needs
fixing ?

> The driver should never get loaded by default or automatically.  If the
> user knows enough about there BIOS to trust that the SMI behavior will
> coexist with the driver then its OK to load otherwise using this driver
> is not a safe thing to do.

So Intel and/or the BIOS vendors also forgot to put in any kind of
indicator ? How do they expect end users to know this, or OS vendors ?
Is there a technote that covers this mess ?

> I think the best thing to do is to have the driver error out in its init
> or probe code if the dev0:fun1 is hidden at boot time.
> 
> Comments?

Why did Intel bother implementing this functionality and then screwing
it up so that OS vendors can't use it ? It seems so bogus.

At the very least we should print a warning advising the user that the
BIOS is incompatible and to ask the BIOS vendor for an update so that
they can enable error detection and management support. 

Is only the AMI BIOS this braindamaged, should we just blacklist AMI
bioses in EDAC or is this shared Intel supplied code that may be found
in other vendors systems.

Alan

