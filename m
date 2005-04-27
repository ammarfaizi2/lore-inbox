Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261719AbVD0Gzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbVD0Gzn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 02:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261749AbVD0Gzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 02:55:43 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:46719 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261719AbVD0Gzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 02:55:35 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/6] I8K and Toshiba legacy driver cleanup
Date: Wed, 27 Apr 2005 01:49:13 -0500
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 1942
Message-Id: <200504270149.13450.dtor_core@ameritech.net>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

I have several patches cleaning up Toshiba and I8K drivers a bit and I
was wondering if you could add them to -mm. I8K patches have been sent
to LKML earlier and were tested (although I have dropped sysfs export
patch, there were some objections from Greg).

01-toshiba-cleanup
  Toshiba legacy driver cleanup:
  - use module_init/module_exit for initialization instead of using
    #ifdef MODULE and calling tosh_init manually from drivers/char/misc.c
  - do not explicitly initialize static variables
  - some whitespace and formatting cleanups

02-i8k-lindent.patch
  - pass through Lindent to change 4 spaces identation to TABs

03-i8k-use-dmi.patch
  - Change to use stock dmi infrastructure instead of homegrown
    parsing code. The driver now requires box's DMI data to match
    list of supported models so driver can be safely compiled-in
    by default without fear of it poking into random SMM BIOS
    code. DMI checks can be ignored with i8k.ignore_dmi option.

04-i8k-seqfile.patch
  - Change proc code to use seq_file.

05-i8k-cleanup.patch
  - use module_{init|exit} instead of old style #ifdef MODULE
    code, some formatting changes 

06-i8k-new-signatures.patch
  - add BIOS signatures of a newer Dell laptops, also there can be
    more than one temperature sensor reported by BIOS.

Thanks!

-- 
Dmitry
