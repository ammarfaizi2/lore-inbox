Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932332AbWDLWKN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbWDLWKN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 18:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932339AbWDLWKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 18:10:13 -0400
Received: from mga01.intel.com ([192.55.52.88]:9364 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S932332AbWDLWKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 18:10:11 -0400
X-IronPort-AV: i="4.04,115,1144047600"; 
   d="scan'208"; a="23277020:sNHT768196688"
Subject: [patch 0/3] Redesigned Dock Patches
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: len.brown@intel.com, greg@kroah.com
Cc: linux-acpi@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, mochel@linux.intel.com,
       arjan@linux.intel.com, muneda.takahiro@jp.fujitsu.com, pavel@ucw.cz,
       temnota@kmv.ru
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 12 Apr 2006 15:18:38 -0700
Message-Id: <1144880318.11215.42.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-OriginalArrivalTime: 12 Apr 2006 22:10:09.0760 (UTC) FILETIME=[DCF4EE00:01C65E7D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After getting more laptop/dock combos tested, it's apparent to me that
I need to redesign the dock patches to not exclusively use acpiphp to
handle dock events.  This is because there are dock stations with no
pci on them at all, and it doesn't make sense for the apci pci hotplug
driver to handle the dock event in this case.  So, I moved the dock
event handling to the acpi directory, in a separate driver called "dock".
The acpiphp driver will still handle hotplugging any new pci devices
(including dock bridges) that will be need to be inserted after a dock
event.

To use these driver, you will need to select CONFIG_ACPI_DOCK in the
.config file, and make sure if you are using an IBM laptop that you have
NOT selected the option to allow ibm_acpi to handle the docking events.  Then,
you modprobe dock as well as acpiphp.

Please take a look at these patches and test them if you can.  Every time
another person tests the dock patches I find another combination I didn't
think of :).  Thanks for your feedback, and thanks to all the testers who
are helping make the dock patches work for as many systems as we can.

Kristen

--
