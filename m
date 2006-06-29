Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbWF2Oci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbWF2Oci (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 10:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbWF2Oci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 10:32:38 -0400
Received: from ra.tuxdriver.com ([70.61.120.52]:13582 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1750757AbWF2Och (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 10:32:37 -0400
Date: Thu, 29 Jun 2006 10:26:48 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Denis Vlasenko <vda@ilport.com.ua>, Carlos Martin <carlos@cmartin.tk>,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       acx100-devel@lists.sourceforge.net, acx100-users@lists.sourceforge.net,
       Arjan van de Ven <arjan@infradead.org>, Adrian Bunk <bunk@stusta.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>, Jeff Garzik <jeff@garzik.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: ACX100 (softmac-based) driver ready to merge, but is it legal? -- Re: wireless (was Re: 2.6.18 -mm merge plans)
Message-ID: <20060629142643.GA24463@tuxdriver.com>
References: <20060604135011.decdc7c9.akpm@osdl.org> <20060605010636.GB17361@havoc.gtf.org> <20060605085451.GA26766@infradead.org> <20060605132732.GA23350@tuxdriver.com> <1149524691.30554.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149524691.30554.23.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2006 at 05:24:51PM +0100, Alan Cox wrote:
> Ar Llu, 2006-06-05 am 09:27 -0400, ysgrifennodd John W. Linville:
> > Does not the Signed-off-by: line on a patch submission give us some
> > level of "good faith" protection?
> > 
> > I'm tempted to take contributors at their word, that they have produced
> > their own work and not copied from others.  What else do we need?
> 
> To keep an eye out for problems. Given the questions raised the tiacx
> people need to clarify their position and someone needs to look into it.
> Until that is done it certainly isn't "good faith" any more.

I apologize for the long copy list.  I have tried to include all
known interested parties.

This is a follow-up to a thread started by Andrew a few weeks ago
about what should be merged for 2.6.18.  One of the topics he cited
was the ACX100 driver which he has carried in -mm for quite some time.
I have a slightly different (softmac based) version of that driver
in wireless-2.6 which I think is worth merging now.

In the aforementioned thread, some questions were raised about the
legality of the ACX100 driver (i.e. tiacx) code base, but no one
had any specific points other than that it is not 100% "clean room"
derived.  Others point-out that this is not strictly a requirement.
The matter dropped without a strong defense from the tiacx team.

I hereby invite the tiacx team to defend their work by making public,
affirmative statements indicating a) how they produced their code; and,
b) that they have the legal right to license it as part of the Linux
kernel under the GPL.  As an incentive to this, I have already made
the necessary preparations for this driver to be merged immediately.

This is the softmac-based tiacx that has been in wireless-2.6 for
some time, with the addition of a few patches that akpm had in -mm
which I did not previously have.  For easy review, a tarball with
the full driver is available here:

	http://www.kernel.org/pub/linux/kernel/people/linville/tiacx.tar.gz

A git pull request follows.  I am confident that if the legal status
of this code can be confirmed, it will be merged upstream ASAP.

Comments welcome!

Thanks,

John

---

The following changes since commit 70a332b048e4d90635dfa47fc5d91cf87b5cc3a5:
  John W. Linville:
        softmac: fix build-break from 881ee6999d66c8fc903b429b73bbe6045b38c549

are found in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-2.6.git tiacx

Andreas Mohr:
      tiacx: implement much more flexible firmware statistics parsing

Andrew Morton:
      tiacx: pci build fix

Carlos Martin:
      tiacx: fix breakage of "Get rid of circular list of adev's"
      tiacx: split module into acx-common + acx-pci + acx-usb

Denis Vlasenko:
      acxsm: merge from acx 0.3.32
      tiacx: revert "neither PCI nor USB is selected" change
      tiacx: Change acx_ioctl_{get,set}_encode to use kernel 80211 stack
      fix tiacx on alpha
      tiacx: fix attribute packed warnings

John W. Linville:
      wireless: add acx driver
      tiacx: Let only ACX_PCI/ACX_USB be user-visible
      tiacx: support ia64

 drivers/net/wireless/Kconfig             |    1 
 drivers/net/wireless/Makefile            |    2 
 drivers/net/wireless/tiacx/Changelog     |  114 
 drivers/net/wireless/tiacx/Kconfig       |   65 
 drivers/net/wireless/tiacx/Makefile      |    6 
 drivers/net/wireless/tiacx/README        |   61 
 drivers/net/wireless/tiacx/acx.h         |   11 
 drivers/net/wireless/tiacx/acx_config.h  |   40 
 drivers/net/wireless/tiacx/acx_func.h    |  598 ++
 drivers/net/wireless/tiacx/acx_struct.h  | 2048 ++++++++
 drivers/net/wireless/tiacx/common.c      | 7542 ++++++++++++++++++++++++++++++
 drivers/net/wireless/tiacx/ioctl.c       | 2738 +++++++++++
 drivers/net/wireless/tiacx/pci.c         | 4243 +++++++++++++++++
 drivers/net/wireless/tiacx/setrate.c     |  213 +
 drivers/net/wireless/tiacx/usb.c         | 1954 ++++++++
 drivers/net/wireless/tiacx/wlan.c        |  422 ++
 drivers/net/wireless/tiacx/wlan_compat.h |  267 +
 drivers/net/wireless/tiacx/wlan_hdr.h    |  497 ++
 drivers/net/wireless/tiacx/wlan_mgmt.h   |  582 ++
 19 files changed, 21404 insertions(+), 0 deletions(-)
 create mode 100644 drivers/net/wireless/tiacx/Changelog
 create mode 100644 drivers/net/wireless/tiacx/Kconfig
 create mode 100644 drivers/net/wireless/tiacx/Makefile
 create mode 100644 drivers/net/wireless/tiacx/README
 create mode 100644 drivers/net/wireless/tiacx/acx.h
 create mode 100644 drivers/net/wireless/tiacx/acx_config.h
 create mode 100644 drivers/net/wireless/tiacx/acx_func.h
 create mode 100644 drivers/net/wireless/tiacx/acx_struct.h
 create mode 100644 drivers/net/wireless/tiacx/common.c
 create mode 100644 drivers/net/wireless/tiacx/ioctl.c
 create mode 100644 drivers/net/wireless/tiacx/pci.c
 create mode 100644 drivers/net/wireless/tiacx/setrate.c
 create mode 100644 drivers/net/wireless/tiacx/usb.c
 create mode 100644 drivers/net/wireless/tiacx/wlan.c
 create mode 100644 drivers/net/wireless/tiacx/wlan_compat.h
 create mode 100644 drivers/net/wireless/tiacx/wlan_hdr.h
 create mode 100644 drivers/net/wireless/tiacx/wlan_mgmt.h

The complete (history-free) is available here:

	http://www.kernel.org/pub/linux/kernel/people/linville/tiacx.patch.gz

-- 
John W. Linville
linville@tuxdriver.com
