Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261641AbSKCFKs>; Sun, 3 Nov 2002 00:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261642AbSKCFKs>; Sun, 3 Nov 2002 00:10:48 -0500
Received: from 653277hfc248.tampabay.rr.com ([65.32.77.248]:55055 "EHLO
	bender.davehollis.com") by vger.kernel.org with ESMTP
	id <S261641AbSKCFKr>; Sun, 3 Nov 2002 00:10:47 -0500
Message-ID: <3DC4B158.5070504@davehollis.com>
Date: Sun, 03 Nov 2002 00:17:12 -0500
From: David T Hollis <dhollis@davehollis.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: APIC Lockups upon bootup
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am attempting to install RedHat 8.0 onto an Athlon XP1600 system 
(Amptron/PCChips motherboard K7-825LM 8/12/2002 BIOS) but I consistently 
die at bootup at "ESR value before enabling vector: 00000002".  I have 
tried using 'noapic' and 'nosmp' to no avail.  In looking at the code, I 
must be dying just a few lines after it gives me the above output:



        if (APIC_INTEGRATED(ver) && !esr_disable) {             /* 
!82489DX */
                maxlvt = get_maxlvt();
                if (maxlvt > 3)         /* Due to the Pentium erratum 
3AP. */
                        apic_write(APIC_ESR, 0);
                value = apic_read(APIC_ESR);
                printk("ESR value before enabling vector: %08lx\n", value);

=====  I die somewhere in this code ?!?!?! ================
                value = ERROR_APIC_VECTOR;      // enables sending errors
                apic_write_around(APIC_LVTERR, value);
                /*
                 * spec says clear errors after enabling vector.
                 */
                if (maxlvt > 3)
                        apic_write(APIC_ESR, 0);
                value = apic_read(APIC_ESR);
                printk("ESR value after enabling vector: %08lx\n", value);


Anyone have any ideas?  I've never seen anything like this anywhere. 
 Google searches have turned up empty as well.

