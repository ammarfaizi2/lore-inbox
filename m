Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752821AbWKBKy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752821AbWKBKy7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 05:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752824AbWKBKy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 05:54:59 -0500
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:31105 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S1752821AbWKBKy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 05:54:57 -0500
Message-ID: <4549CE80.5080307@s5r6.in-berlin.de>
Date: Thu, 02 Nov 2006 11:54:56 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.5) Gecko/20060721 SeaMonkey/1.0.3
MIME-Version: 1.0
To: randy.dunlap@oracle.com
CC: akpm@osdl.org, mm-commits@vger.kernel.org, James.Bottomley@steeleye.com,
       zippel@linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: + revert-iscsi-build-failure-use-depends-instead-of.patch added
 to -mm tree
References: <200611020640.kA26edl0003496@shell0.pdx.osdl.net>
In-Reply-To: <200611020640.kA26edl0003496@shell0.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> Remove all (2) "select NET" instances from all kernel Kconfig files.  Use
> "depends on" for them instead.  As Roman Zippel commented, "please don't
> select NET, it's way too broad."
> 
> This affects all IEEE1394 drivers and some SCSI drivers.  Networking (NET)
> will have to be enabled before any IEEE1394 or a few SCSI drivers can be
> enabled.  In particular for SCSI, the QLogic ISP4xxx driver
> (SCSI_QLA_ISCSI) and any FiberChannel drivers are affected.
> 
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> Cc: James Bottomley <James.Bottomley@steeleye.com>
> Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>
> Cc: Roman Zippel <zippel@linux-m68k.org>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  drivers/ieee1394/Kconfig     |    5 ++++-
>  drivers/scsi/Kconfig         |   13 +++++++++----
>  drivers/scsi/qla4xxx/Kconfig |    8 ++++----
>  3 files changed, 17 insertions(+), 9 deletions(-)
[...]

I'm OK with that change. You could have submitted the IEEE 1394 part
separately though.

A comment on the patch description: Only the eth1394 driver and the
ieee1394 core driver depend directly on NET. (All other FireWire drivers
depend on ieee1394 of course.) ieee1394's dependency on NET is planned
to be removed by a minor change to its implementation but we don't have
a deadline for this, as usual...
-- 
Stefan Richter
-=====-=-==- =-== ---=-
http://arcgraph.de/sr/
