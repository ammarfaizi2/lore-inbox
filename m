Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261456AbVBRTNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261456AbVBRTNF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 14:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261461AbVBRTNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 14:13:04 -0500
Received: from fire.osdl.org ([65.172.181.4]:28045 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261453AbVBRTMo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 14:12:44 -0500
Message-ID: <42163E2D.8050106@osdl.org>
Date: Fri, 18 Feb 2005 11:12:45 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: joern@wohnheim.fh-wedel.de, lkml <linux-kernel@vger.kernel.org>
Subject: checkstack.pl <large_number>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In checkstack.pl, do you recall the reason for this code snippet:

		if ($size > 0x80000000) {
			$size = - $size;
			$size += 0x80000000;
			$size += 0x80000000;
		}

There is one (unusual:) case where it fails.  Is it needed?

For arch/i386/kernel/efi_stub.S, checkstack reports:

0xc0116f5d efi_call_phys:				1073741824
which is 0x4000_0000 (_ added for readability only), however the
actual change in %esp there is __PAGE_OFFSET (0xc000_0000 on ia32),

so if I alter the "if" test above to check for > 0xf000_0000,
checkstack reports the correct value:
0xc0116f5d efi_call_phys:				3221225472
which is 0xc000_0000.


from objdump of efi_stub.o:
    5:	81 ea 00 00 00 c0    	sub    $0xc0000000,%edx

or I can just ignore it, like I've been doing for awhile...

-- 
~Randy
