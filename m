Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbWACEqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbWACEqr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 23:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbWACEqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 23:46:47 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:707 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751114AbWACEqq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 23:46:46 -0500
Date: Tue, 3 Jan 2006 10:16:32 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Andi Kleen <ak@muc.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Morton Andrew Morton <akpm@osdl.org>
Subject: Inclusion of x86_64 memorize ioapic at bootup patch
Message-ID: <20060103044632.GA4969@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

Can you please include the following patch. This patch has already been pushed
by Andrew.

http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc5/2.6.15-rc5-mm3/broken-out/x86_64-io_apicc-memorize-at-bootup-where-the-i8259-is.patch

This patch is regarding remembering at boot up time where i8259 is connected
and restore the APIC settings back during kexec boot or kdump boot. This
enables getting timer interrupts in new kernel in legacy mode.

This patch is needed to make kexec and kdump work on some systems,
especially opteron boxes. Otherwise the second kernel does not receive
timer interrupts during early boot hence hangs.

I understand, that you are inclined towards remembering all the APIC states
and simply restore it back instead of putting hooks. This will work 
well for kexec but not for kdump because in kdump system can crash on 
non-boot cpu.

Restoring BIOS APIC state can make sure that BIOS designated boot cpu will 
always be able to see timer interrupts in legacy mode but same does not 
hold good if new kernel boots on some other cpu as is the case with kdump.

In case of kexec boot, we relocate to boot cpu but in case of kdump we
don't because it was suggested that in some extreme cases of crash, boot cpu
might not respond even to NMI and relocation to boot cpu will not be
possible.

Can you please re-consider this patch for inclusion.

Thanks
Vivek
