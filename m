Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270926AbUJVETo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270926AbUJVETo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 00:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270940AbUJVEQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 00:16:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:27885 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270899AbUJVELX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 00:11:23 -0400
Message-ID: <41788761.8020508@osdl.org>
Date: Thu, 21 Oct 2004 21:06:57 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: pavel@suse.cz, linux-kernel@vger.kernel.org
Subject: __init & __initdata during resume
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

'make buildcheck' reports:
Error: ./arch/x86_64/ia32/syscall32.o .text refers to 0000000000000002
R_X86_64_PC32     .init.data+0x000000000000152b
Error: ./arch/x86_64/ia32/syscall32.o .text refers to 0000000000000017
R_X86_64_PC32     .init.data+0x000000000000152c


I'm looking at a recent (2 weeks) changeset:
[PATCH] Fix random crashes in x86-64 swsusp

http://linux.bkbits.net:8080/linux-2.5/cset@4166a52aYzzfOE3F63Kkb966K2Qz3g?nav=index.html|src/|src/arch|src/arch/x86_64|src/arch/x86_64/ia32|related/arch/x86_64/ia32/syscall32.c

in which this change was made:

-void __init syscall32_cpu_init(void)
+/* May not be __init: called during resume */
+void syscall32_cpu_init(void)

but syscall32_cpu_init() uses <use_sysenter>, which is:
static int use_sysenter __initdata = -1;

so the question is:  does that "__initdata" need to removed also?

--
~Randy

