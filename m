Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266512AbUJRNvo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266512AbUJRNvo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 09:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266517AbUJRNvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 09:51:44 -0400
Received: from lists.us.dell.com ([143.166.224.162]:63452 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S266512AbUJRNvl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 09:51:41 -0400
Date: Mon, 18 Oct 2004 08:50:02 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: David Balazic <david.balazic@hermes.si>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, alan@redhat.com,
       jgarzik@pobox.com
Subject: Re: [PATCH 2.6.9-rc3-mm2] EDD: use EXTENDED READ command, add CON FIG_EDD_SKIP_MBR
Message-ID: <20041018135001.GA2721@lists.us.dell.com>
References: <0C3E356FC19C134F8061D1A69D1F92D90B833F@piramida.hermes.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0C3E356FC19C134F8061D1A69D1F92D90B833F@piramida.hermes.si>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2004 at 08:16:40AM +0200, David Balazic wrote:
>    Does not help at all on my system ( Gigabyte GA-7VAXP Ultra , BIOS version
>    F7 ).

Crud.

>    Only if I select the CONFIG_EDD_SKIP_MBR option, otherwise the
>    delay is still there.

Glad that worked.  So the problem area is still in reading the first
sector.  Jeff's was too, but his BIOS was reporting having disks
present which weren't really there, so the sector read would
eventually time out.

On http://linux.dell.com/dkms/results.html is this simple script
below.  This will report whatever is in the /sys/firmware/edd tree.
Also include with this a brief hardware description of your system
(how many disks are actually present, and attached to which
controllers, as you can determine by looking at the cables).

#!/bin/sh
tree /sys
find /sys/firmware/edd -type f -not -name raw_data -print -exec cat
\{\} \;
find /sys/firmware/edd -type f -name raw_data -print -exec hexdump -C
\{\} \;
lspci -vv
lsmod
[ -e /proc/scsi/scsi ] && cat /proc/scsi/scsi
dmidecode

If there's a way to know at runtime if a system has a BIOS that
misrepresents the number of disks present, I'd like to put in such a
quirk.  However, this is really really early in system startup, and
I'd prefer not to have to read the DMI tables to do it...  Thoughts?

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
