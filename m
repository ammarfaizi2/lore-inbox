Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263770AbUHSIGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263770AbUHSIGT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 04:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbUHSIGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 04:06:18 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:16274 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S263770AbUHSIFt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 04:05:49 -0400
Message-ID: <41245F59.4080608@free.fr>
Date: Thu, 19 Aug 2004 10:05:45 +0200
From: Eric Valette <eric.valette@free.fr>
Reply-To: eric.valette@free.fr
Organization: HOME
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: "Li, Shaohua" <shaohua.li@intel.com>
Cc: Karol Kozimor <sziwan@hell.org.pl>, "Brown, Len" <len.brown@intel.com>,
       "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>, linux@brodo.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8.1-mm1 and Asus L3C : problematic change found, can be reverted.
 Real fix still missing
References: <B44D37711ED29844BEA67908EAF36F039A1877@pdsmsx401.ccr.corp.intel.com>
In-Reply-To: <B44D37711ED29844BEA67908EAF36F039A1877@pdsmsx401.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Li, Shaohua wrote:
> Eric,
> The patch for bug 3049 has been in 2.6.8.1 and should fix the IO port
> problem. If the Asus quirk is just because of IO port problem, I'd like
> to remove it. Note PNP driver also reserves the IO port for the SMBus
> and lets SMBus driver to use it. ACPI motherboard driver behaves the
> same as PNP driver.

Unfortunately, as I understand it, the fix is done to "unhide" the SMBus 
that otherwyse is not seen but it has unexpected side effect of messing 
ioports allocation/reservation. I guess lspci with and without the fix 
could help to understand the problem. Here is the comment on top of the 
function :

/*
  * On ASUS P4B boards, the SMBus PCI Device within the ICH2/4 southbridge
  * is not activated. The myth is that Asus said that they do not want the
  * users to be irritated by just another PCI Device in the Win98 device
  * manager. (see the file prog/hotplug/README.p4b in the lm_sensors
  * package 2.7.0 for details)
  *
  * The SMBus PCI Device can be activated by setting a bit in the ICH LPC
  * bridge. Unfortunately, this device has no subvendor/subdevice ID. So it
  * becomes necessary to do this tweak in two steps -- I've chosen the Host
  * bridge as trigger.
  */

BTW, maybe we should change the comment because it is on many ASUS 
boards if not all ...

-- eric


