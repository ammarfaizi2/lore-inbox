Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262900AbVAFQgH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262900AbVAFQgH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 11:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262903AbVAFQgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 11:36:07 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:52608 "EHLO vana")
	by vger.kernel.org with ESMTP id S262900AbVAFQgA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 11:36:00 -0500
Date: Thu, 6 Jan 2005 17:35:59 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Christoph Hellwig <hch@infradead.org>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Andrew Morton <akpm@osdl.org>, Takashi Iwai <tiwai@suse.de>, ak@suse.de,
       mingo@elte.hu, rlrevell@joe-job.com, linux-kernel@vger.kernel.org,
       pavel@suse.cz, discuss@x86-64.org, gordon.jin@intel.com,
       alsa-devel@lists.sourceforge.net, greg@kroah.com
Subject: Re: [PATCH] macros to detect existance of unlocked_ioctl and ioctl_compat
Message-ID: <20050106163559.GG5772@vana.vc.cvut.cz>
References: <20041215065650.GM27225@wotan.suse.de> <20041217014345.GA11926@mellanox.co.il> <20050103011113.6f6c8f44.akpm@osdl.org> <20050105144043.GB19434@mellanox.co.il> <s5hd5wjybt8.wl@alsa2.suse.de> <20050105133448.59345b04.akpm@osdl.org> <20050106140636.GE25629@mellanox.co.il> <20050106145356.GA18725@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050106145356.GA18725@infradead.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 02:53:56PM +0000, Christoph Hellwig wrote:
> On Thu, Jan 06, 2005 at 04:06:36PM +0200, Michael S. Tsirkin wrote:
> > > It should be, unless there's some problem.  In maybe a week or so.
> > 
> > To make life bearable for out-of kernel modules, the following patch
> > adds 2 macros so that existance of unlocked_ioctl and ioctl_compat
> > can be easily detected.
> 
> That's not the way we're making additions.  Get your code merged and
> there won't be any need to detect the feature.

When Greg made sysfs GPL only, I've asked whether it is possible to merge
vmmon/vmnet in (and changing its license, of course).  Answer on LKML was 
quite clear: no, you are not interested in having vmmon/vmnet in Linux 
kernel as you do not believe that they are usable for anything else than VMware.  

So please tell me what I can do to satisfy you?  You do not want our modules
in kernel tree, and you do not want to allow us to detect kernel interface
easily.  Of course we can use autoconf-like scripts we are using for
example to detect pml4/pgd vs. pgd/pud vs. pgd/pmd/pte vs. pmd/pte only,
but each time you can detect feature by looking at flags and not by trying
to build one source after another detection is simpler and more reliable.

BTW, vmmon will still require register_ioctl32_conversion as we are using
(abusing) it to be able to issue 64bit ioctls from 32bit application.  I
assume that there is no supported way how to issue 64bit ioctls from 32bit
aplication anymore after you disallow system-wide translations to be registered
by modules.

						Best regards,
							Petr Vandrovec
