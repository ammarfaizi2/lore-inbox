Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270832AbTHFS0g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 14:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270819AbTHFS0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 14:26:36 -0400
Received: from main.gmane.org ([80.91.224.249]:1409 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S270832AbTHFS0f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 14:26:35 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Pasi Savolainen <psavo@iki.fi>
Subject: Re: 2.4.22-rc1 + ACPI patch: amd76x_pm do not work any longer
Date: Wed, 6 Aug 2003 18:26:10 +0000 (UTC)
Message-ID: <bgrh82$3sp$1@main.gmane.org>
References: <200308060621.06216.d.nuetzel@wearabrain.de> <20030806100815.GH16091@fs.tum.de> <200308061849.01416.d.nuetzel@wearabrain.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@main.gmane.org
User-Agent: slrn/0.9.7.4 (Linux)
Cc: acpi-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Dieter Nützel <d.nuetzel@wearabrain.de>:
> Am Mittwoch, 6. August 2003 12:08 schrieb Adrian Bunk:
>> On Wed, Aug 06, 2003 at 06:21:06AM +0200, Dieter Nützel wrote:
>> > Hello,
>>
>> Hi Dieter,
>>
>> > I had it running very well on my dual Athlon MP 1900+ for several months
>> > before. Latest Kernel was 2.4.22-pre5+ACPI patch.
>> >
>> > Any changes?
>> > I changed lm_sensors from 2.7.0 (?) to 2.8.0
> 
> This one is the culprit.
> Reverting to 2.7.0 cure my problems.

It's most probably because somebody (temp. monitoring) is already using
the south bridge, so just plain grabbing of it doesn't work. I faced
this with port to 2.6 and it's handled thus:


+       /* Find southbridge */
+       pdev_sb = NULL;
+       while((pdev_sb = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pdev_sb)) != NULL) {
+               if(pci_match_device(amd_sb_tbl, pdev_sb) != NULL)
+                       goto found_sb;
+       }
+       printk(KERN_ERR "amd76x_pm: Could not find southbridge\n");
+       return -ENODEV;


It could work in 2.4 too.


-- 
   Psi -- <http://www.iki.fi/pasi.savolainen>
Vivake -- Virtuaalinen valokuvauskerho <http://members.lycos.co.uk/vivake/>

