Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264471AbTFEDP6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 23:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264472AbTFEDP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 23:15:58 -0400
Received: from smtp-out.comcast.net ([24.153.64.116]:25797 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S264471AbTFEDPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 23:15:51 -0400
Date: Wed, 04 Jun 2003 23:21:43 -0400
From: Albert Cahalan <albert@users.sf.net>
Subject: /proc/bus/pci
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: davem@redhat.com, torvalds@transmeta.com, bcollins@debian.org,
       wli@holomorphy.com, tom_gall@vnet.ibm.com, anton@samba.org
Message-id: <1054783303.22104.5569.camel@cube>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.4
Content-type: text/plain
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I notice that /proc/bus/pci doesn't offer a sane
interface for multiple PCI domains and choice of BAR.
What do people think of this?

bus/pci/00/00.0 -> ../hose0/bus0/dev0/fn0/config-space
bus/pci/hose0/bus0/dev0/fn0/config-space
bus/pci/hose0/bus0/dev0/fn0/bar0
bus/pci/hose0/bus0/dev0/fn0/bar1
bus/pci/hose0/bus0/dev0/fn0/bar2
bus/pci/hose0/bus0/dev0/fn0/status

Then with some mmap flags, the nasty ioctl() stuff
won't be needed anymore. It can die during 2.7.xx
development. If MAP_MMIO isn't generally acceptable,
then it could be via filename suffixes. (eeew, IMHO)

One remaining problem is permission. Any complaints
about implementing chmod() for those? Since this
does bypass capabilities, a mount option might be
used to enable it.

As alternatives to /proc changes, a distinct filesystem
could be developed or sysfs could be abused.


