Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265933AbUBRP4X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 10:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267601AbUBRP4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 10:56:23 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:38833 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S265933AbUBRP4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 10:56:04 -0500
Date: Wed, 18 Feb 2004 15:53:17 +0000
From: Dave Jones <davej@redhat.com>
To: Marc Zyngier <mzyngier@freesurf.fr>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: EISA & sysfs.
Message-ID: <20040218155317.GQ6242@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Marc Zyngier <mzyngier@freesurf.fr>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20040217235431.GF6242@redhat.com> <wrpfzd87mg6.fsf@panther.wild-wind.fr.eu.org> <20040218111612.GM6242@redhat.com> <wrp1xos5s2o.fsf@panther.wild-wind.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wrp1xos5s2o.fsf@panther.wild-wind.fr.eu.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 18, 2004 at 04:24:15PM +0100, Marc Zyngier wrote:

 > EISA-ID table terminator. What about changing it to :
 > 
 > static struct eisa_device_id hp100_eisa_tbl[] = {
 >         { "HWPF180" }, /* HP J2577 rev A */
 >         { "HWP1920" }, /* HP 27248B */
 >         { "HWP1940" }, /* HP J2577 */
 >         { "HWP1990" }, /* HP J2577 */
 >         { "CPX0301" }, /* ReadyLink ENET100-VG4 */
 >         { "CPX0401" }, /* FreedomLine 100/VG */
 >         { "" },        /* THIS ENTRY IS MANDATORY !!! */
 > };

ok, that stops it hanging at least, it now barfs a little failure
message, and a calltrace.  This seems awfully verbose for a failure
path that isn't unreasonable IMO.

kernel: kobject_register failed for hp100 (-17)
kernel: Call Trace:
kernel:  [<c01d3662>] kobject_register+0x31/0x39
kernel:  [<c0221d0c>] bus_add_driver+0x2e/0x83
kernel:  [<c01db6db>] pci_register_driver+0x6b/0x87
kernel:  [<c78078ad>] hp100_module_init+0x12/0x22 [hp100]
kernel:  [<c013c0fc>] sys_init_module+0x14e/0x25e
kernel:  [<c010b697>] syscall_call+0x7/0xb


Something also seems awry someplace else..

(15:54:51:root@mindphaser:linux-2.6.2)# cat /proc/modules  | grep hp100
(15:54:55:root@mindphaser:linux-2.6.2)# rmmod hp100
ERROR: Module hp100 does not exist in /proc/modules
(15:55:18:root@mindphaser:linux-2.6.2)# modprobe hp100
FATAL: Module hp100 already in kernel.
(15:55:25:root@mindphaser:linux-2.6.2)# cat /proc/modules | grep hp100
(15:55:33:root@mindphaser:linux-2.6.2)#

Odd.

	Dave


