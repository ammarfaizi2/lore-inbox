Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757020AbWKVVIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757020AbWKVVIs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 16:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757021AbWKVVIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 16:08:48 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:15624 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1756986AbWKVVIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 16:08:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=s9Z1yb5uLb2EuYFUvwro+klQaWYrBCHwwKYLuWINx6imeHt2PA499c3ZnLQab2U0WItF0WYcsm6gn6vtM1aijHJJjnFsIbdfUCFSr2SPvtizB+bwrR5CYpfwS6o1Ns9wLcKAGpBckah3QwnKAsvzGvG/QISfnPJM75JQR3JGQd0=
Date: Wed, 22 Nov 2006 22:07:07 +0100
From: Diego Calleja <diegocg@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [script] Human-readable of supported pci hardware
Message-Id: <20061122220707.ee78fc7d.diegocg@gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.10.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've written a small (python) script that takes that info from
/lib/modules/`uname -r`/modules.pcimap, looks up the PCIIDs in the pciid
database (placed in /usr/share/misc/pci.ids in ubuntu, change the path if
your system is different) and generates a list of human-readable hardware
that each module supports (obviously the in-kernel stuff isn't included
in the list). I've never seen a util that does this, and I though people
may be interested in this crappy script

This only gives a list of supported "pci devices". It's easy to extend
it to print also usb devices, and it'd be also possible for ieee1394
or isapnp cards if there were a "id" database available.

It be possible to dump the data in a database and do queries like "what
sound cards does linux support?" But right now pretty much every driver
except a few ones doesn't seem to set the pci_device_id.class field.

The script is at: http://www.terra.es/personal/diegocg/list-kernel-hardware.py


Obligatory screenshot:

Driver: snd-ymfpci
        Device: YMF-724 (deviceid 0004); made by Yamaha Corporation (vendorid 1073)
        Device: YMF-724F [DS-1 Audio Controller] (deviceid 000d); made by Yamaha Corporation (vendorid 1073)
        Device: DS1L Audio (deviceid 000a); made by Yamaha Corporation (vendorid 1073)
        Device: YMF-740C [DS-1L Audio Controller] (deviceid 000c); made by Yamaha Corporation (vendorid 1073)
        Device: YMF-744B [DS-1S Audio Controller] (deviceid 0010); made by Yamaha Corporation (vendorid 1073)
        Device: YMF-754 [DS-1E Audio Controller] (deviceid 0012); made by Yamaha Corporation (vendorid 1073)


A full list for a default ubuntu kernel can be found at:
http://www.terra.es/personal/diegocg/list.txt
(obviously, to get a list of all the pci hardware supported by the
kernel you'd need to compile a "allmodconfig" kernel)
