Return-Path: <linux-kernel-owner+w=401wt.eu-S1751916AbXAVEqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751916AbXAVEqF (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 23:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751927AbXAVEqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 23:46:04 -0500
Received: from mga01.intel.com ([192.55.52.88]:15240 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751916AbXAVEqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 23:46:03 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.13,218,1167638400"; 
   d="scan'208"; a="190614211:sNHT20276893"
Date: Mon, 22 Jan 2007 12:45:19 +0800
From: Wang Zhenyu <zhenyu.z.wang@intel.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: andi@lisas.de, davej@codemonkey.org.uk,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: intel-agp PM experiences (was: 2.6.20-rc5: usb mouse breaks suspend to ram)
Message-ID: <20070122044519.GA24398@zhen-devel.sh.intel.com>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>, andi@lisas.de,
	davej@codemonkey.org.uk, kernel list <linux-kernel@vger.kernel.org>
References: <20070116135727.GA2831@elf.ucw.cz> <d120d5000701160608t73db4405n5d157db43899776a@mail.gmail.com> <20070116142432.GA6171@elf.ucw.cz> <d120d5000701161325h112a9299w944763b7f1032a61@mail.gmail.com> <20070117004012.GA11140@rhlx01.hs-esslingen.de> <20070117005755.GB6270@elf.ucw.cz> <20070118115105.GA28233@rhlx01.hs-esslingen.de> <20070118231650.GA5352@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070118231650.GA5352@ucw.cz>
User-Agent: Mutt/1.4.2.1i
X-Mailer: mutt
X-Operating-System: Linux 2.6.15-1.2054_FC5smp i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2007.01.18 23:16:51 +0000, Pavel Machek wrote:
> Hi!
> 
> > > > Especially the PCI video_state trick finally got me a working resume on
> > > > 2.6.19-ck2 r128 Rage Mobility M4 AGP *WITH*(!) fully enabled and working
> > > > (and keeping working!) DRI (3D).
> > > 
> > > Can we get whitelist entry for suspend.sf.net? s2ram from there can do
> > > all the tricks you described, one letter per trick :-). We even got
> > > PCI saving lately.
> > 
> > Whitelist? Let me blacklist it all the way to Timbuktu instead!
> 
> > I've been doing more testing, and X never managed to come back to working
> > state without some of my couple intel-agp changes:
> > - a proper suspend method, doing a proper pci_save_state()
> >   or improved equivalent
> > - a missing resume check for my i815 chipset
> > - global cache flush in _configure
> > - restoring AGP bridge PCI config space
> 
> Can you post a patch?

I've post a patch which trys to resolve pci config restore issue, see
http://lkml.org/lkml/2007/1/16/297. It resolves s3 issue with my 965G machine,
that my X can come back to live after s3, but I wasn't aware of the issues Andreas
has noted. It'll be good if more people could try this out. 

> Whitelist entry would still be welcome.
> 
> > All in all intel-agp code semi-shattered my universe.
> > I didn't expect to find all these issues in rather important core code
> ...
> > Given the myriads of resume issues we experience in general,
> > it may be wise to do something as simple as a code review of *all*
> 
> Any volunteers?
> 							Pavel
