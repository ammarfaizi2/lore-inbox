Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbTILLTg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 07:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbTILLTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 07:19:36 -0400
Received: from thor.itep.ru ([194.85.69.254]:42676 "EHLO thor.itep.ru")
	by vger.kernel.org with ESMTP id S261306AbTILLTb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 07:19:31 -0400
Date: Fri, 12 Sep 2003 15:19:28 +0400
From: Roman Kagan <Roman.Kagan@itep.ru>
To: linux-kernel@vger.kernel.org
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Subject: Re: Problem: IDE data corruption with VIA chipsets on2.4.20-19.8+others
Message-ID: <20030912111928.GA5641@panda.itep.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 12, 2003 at 04:14:54AM +0000, Rogier Wolff wrote:
> Anyway, speaking about SMART, some "smartd" was interfering with
> normal operation on one of our systems and we saw similar "nasty"
> stuff on that system until I removed "smartd". 
> 
> Aug 10 06:54:25 falbala kernel: hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
> Aug 10 06:54:25 falbala kernel: hda: drive_cmd: error=0x04 { DriveStatusError }
> Aug 10 06:54:25 falbala kernel: hdb: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
> Aug 10 06:54:25 falbala kernel: hdb: drive_cmd: error=0x04 { DriveStatusError }
> Aug 10 07:24:25 falbala kernel: hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
> Aug 10 07:24:25 falbala kernel: hda: drive_cmd: error=0x04 { DriveStatusError }
> Aug 10 07:24:25 falbala kernel: hdb: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
> Aug 10 07:24:25 falbala kernel: hdb: drive_cmd: error=0x04 { DriveStatusError }
> Aug 10 08:24:25 falbala kernel: hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
> Aug 10 08:24:25 falbala kernel: hda: drive_cmd: error=0x04 { DriveStatusError }
> Aug 10 08:24:25 falbala kernel: hdb: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
> Aug 10 08:24:25 falbala kernel: hdb: drive_cmd: error=0x04 { DriveStatusError }

You probably have SMART disabled on those drives by BIOS, and smartd is
not smart enough to enable it before trying to use it so the drives
complain.  I had the same problem on my GigaByte mobo where the BIOS
setup didn't even provide an option to turn SMART on (like earlier Award
BIOSes did).

Check with smartctl -i /dev/hdX.  Enable with smartctl -e /dev/hdX
_before_ starting smartd.

Sorry for OT.

  Roman.
