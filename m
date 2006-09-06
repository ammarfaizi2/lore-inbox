Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751341AbWIFPMl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbWIFPMl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 11:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWIFPMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 11:12:41 -0400
Received: from www.rapidforum.com ([80.237.244.2]:12264 "HELO rapidforum.com")
	by vger.kernel.org with SMTP id S1751341AbWIFPMk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 11:12:40 -0400
Message-ID: <44FEE554.5050903@rapidforum.com>
Date: Wed, 06 Sep 2006 17:12:20 +0200
From: Christian Schmid <webmaster@rapidforum.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050920
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Large Block Devices not supported in 64 bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I run kernel 2.6.17.11 vanilla in 64 bit mode with 32 bit emulation.

Unfortunately there is no support for file-systems bigger than 2 TB in 64 bit mode.

erikm in #kernelnewbies told me to report it here:

<Dragony> statfs("/MD2", 0xff8deca4)              = -1 EOVERFLOW (Value too large for defined data type)
<erikm> Dragony: prolly no LBD support
<erikm> Dragony: ah wait, you probably do have support for large block devices, but the 32 bit 
portability syscall forgot to support it
<erikm> Dragony: see block/Kconfig
<Dragony> #XXX - it makes sense to enable this only for 32-bit subarch's, not for x86_64
<Dragony> #for instance.
<Dragony> config LBD
<Dragony>         bool "Support for Large Block Devices"
<Dragony>         depends on X86 || (MIPS && 32BIT) || PPC32 || (S390 && !64BIT) || SUPERH || UML
<Dragony> yes but this option only appears in 32 bit mode not in 64 bit mode
<erikm> Dragony: hence my comment
<Dragony> actually /MD2 is mounted and i can access the files, but not any stats
<erikm> Dragony: it *IS* supported, but not properly backported to the 32 bit compatibility layer
<Dragony> hmm what can i do?
<erikm> Dragony: post to lkml

Can someone help me?

Regards,
Chris
