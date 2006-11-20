Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966531AbWKTWPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966531AbWKTWPl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 17:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966606AbWKTWPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 17:15:40 -0500
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:25942 "HELO
	smtp109.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S966531AbWKTWPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 17:15:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=HRkvoub9zgFHs6UtMpCPTomL6U7fTShcoNL1BPJqxCg78eC48xpe9Oiy33nGQpmAPS9DJ2d6okRDB5+PrZVwjrwYNs62axfzkcZ2SBMmXLuzTly5SqEWEDjW1keyIKuF0wwC92zJt5DQwWMHiC05x/B/ip5vhg6LMlrsq7PpMBY=  ;
X-YMail-OSG: ea.T9TQVM1lRZ8_dU0na5EvLD04lkbsKIrnqHuADfKEIKPWVsIAirv_FJ0gxrYDidok6VfHrD5H4SgUTMBoZ7w3YCyACPLZ0D3SEY2cluAVk6V3eMT0.lKSYoMD71nRbTSVgvkc5UpJBlh6ZItYifa2dD84mdnEgr_Q-
From: David Brownell <david-b@pacbell.net>
To: Alessandro Zummo <alessandro.zummo@towertech.it>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [patch 2.6.19-rc6 0/6] more rtc framework/driver updates
Date: Mon, 20 Nov 2006 10:14:41 -0800
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611201014.41980.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are more RTC framework updates, basically for the 2.6.20 queue:

 - /proc/driver/rtc update ... display the 'struct rtc_wkalrm' status
   bits more sensibly (though the EFI "irq pending" flag is nonsense
   with an OS running)

 - rtc-sa1100 update ... wasn't reporting "alarm enabled", and its
   extra procfs info duplicated information already found there

 - X86_PC updates ... create an rtc_cmos platform device when PNPACPI
   isn't available do make one through PNP.  (Non-PC platforms can do
   similar things if they have a "cmos" RTC.)

 - Export ACPI RTC extensions through platform_data to the PNP device
   or the platform device, as appropriate.

 - New "rtc-cmos" driver, for the RTC on most PCs.  For most folk this
   seems like it should be able to replace drivers/char/rtc.c ...

 - Newish "rtc-omap" driver, for the RTC on OMAP1 processors.  No point
   in having this just live in the OMAP tree.

Folk wanting to try "rtc-cmos" will likely be wanting to tweak their
/dev/rtc node to become a symlink to /dev/rtc0, at least until the
new version of util-linux comes out (with updated "hwclock" knowing
about the new RTC class devices).

- Dave

