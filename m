Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932140AbWDFOdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbWDFOdi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 10:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbWDFOdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 10:33:38 -0400
Received: from cirse.extra.cea.fr ([132.166.172.102]:13184 "EHLO
	cirse.extra.cea.fr") by vger.kernel.org with ESMTP id S932140AbWDFOdh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 10:33:37 -0400
Message-ID: <443526B6.6090709@cea.fr>
Date: Thu, 06 Apr 2006 16:33:26 +0200
From: Aurelien Degremont <aurelien.degremont@cea.fr>
User-Agent: Mozilla Thunderbird 1.0.6-1.4.1 (X11/20050719)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Serge Noiraud <serge.noiraud@bull.net>
CC: Ingo Molnar <mingo@elte.hu>, "" <linux-kernel@vger.kernel.org>
Subject: Re: PREEMPT_RT : 2.6.16-rt12 and boot : BUG ?
References: <200604061416.00741.Serge.Noiraud@bull.net>
In-Reply-To: <200604061416.00741.Serge.Noiraud@bull.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serge Noiraud wrote:
> I get symbol resolution error when I try to load my scsi modules in the initrd.

I've got quite the same issue concerning initrd and scsi modules since 
the change in MPT FUSION drivers which happened in 2.6.10, and that you 
seem to use also. (No RT code is involved here)
I tested many different configurations and the only solution I found 
consist in setting some sleep calls in the 'init' script of the initrd, 
between each 'insmod' call. Let me know if this change something for you.

ie:

echo "Loading scsi_mod.ko module"
insmod /lib/scsi_mod.ko
sleep 1
echo "Loading sd_mod.ko module"
insmod /lib/sd_mod.ko
sleep 1
echo "Loading mptbase.ko module"
insmod /lib/mptbase.ko
sleep 1
echo "Loading mptscsih.ko module"
insmod /lib/mptscsih.ko
sleep 1
echo "Loading jbd.ko module"
insmod /lib/jbd.ko
sleep 1
echo "Loading ext3.ko module"
insmod /lib/ext3.ko
sleep 1


-- 
Aurelien Degremont
