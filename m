Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263086AbTEBSoL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 14:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263091AbTEBSoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 14:44:11 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:64760 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S263086AbTEBSoJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 14:44:09 -0400
Date: Fri, 2 May 2003 11:54:08 -0700
From: Greg KH <greg@kroah.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: [BK PATCH] PCI Hotplug fixes for 2.4.21-rc1
Message-ID: <20030502185406.GA14728@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are three PCI Hotplug fixes for 2.4.21-rc1.  Two of them are for
the IBM PCI Hotplug driver, fixing a bug that Arjan van de Ven pointed
out in the last fix for this driver that was accepted, and another fix
for some memory leaks that happen on the error paths.  Both of these
patches have been in the 2.5 tree for some time.

The other patch fixes the Compaq PCI Hotplug driver to work properly on
machines with faster PCI busses (PCI-X).

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/marcelo-2.4

The raw patches will follow.

thanks,

greg k-h


 drivers/hotplug/cpqphp.h      |  194 +++++++++++++++++++++++++++++++++++
 drivers/hotplug/cpqphp_core.c |   59 +++++++++-
 drivers/hotplug/cpqphp_ctrl.c |  147 ++++++++++++++-------------
 drivers/hotplug/ibmphp_ebda.c |  228 +++++++++++++-----------------------------
 4 files changed, 394 insertions(+), 234 deletions(-)
-----

ChangeSet@1.1144, 2003-05-02 11:35:50-07:00, greg@kroah.com
  [PATCH] IBM PCI Hotplug: fix up a number of memory leaks on the error path

 drivers/hotplug/ibmphp_ebda.c |  144 ++++++++++++++++++------------------------
 1 files changed, 65 insertions(+), 79 deletions(-)
------

ChangeSet@1.1143, 2003-05-02 11:35:34-07:00, greg@kroah.com
  [PATCH] IBM PCI Hotplug: fix up a lot of memory allocations and leaks just to figure out a slot name.

 drivers/hotplug/ibmphp_ebda.c |   84 +++---------------------------------------
 1 files changed, 6 insertions(+), 78 deletions(-)
------

ChangeSet@1.1142, 2003-05-02 11:35:06-07:00, torben.mathiasen@hp.com
  [PATCH] PCI Hotplug: cpqphp 66/100/133MHz PCI-X support

Push file://home/greg/linux/BK/gregkh-2.4 -> file://home/greg/linux/BK/bleed-2.4
 drivers/hotplug/cpqphp.h      |  194 +++++++++++++++++++++++++++++++++++++++++-
 drivers/hotplug/cpqphp_core.c |   59 +++++++++++-
 drivers/hotplug/cpqphp_ctrl.c |  147 +++++++++++++++++--------------
 3 files changed, 323 insertions(+), 77 deletions(-)
------

