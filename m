Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261326AbVCTXGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbVCTXGO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 18:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbVCTXGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 18:06:13 -0500
Received: from ns3.dataphone.se ([212.37.0.170]:22483 "EHLO
	mail-slave.dataphone.se") by vger.kernel.org with ESMTP
	id S261326AbVCTXGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 18:06:07 -0500
From: Magnus Damm <damm@opensource.se>
To: linux-kernel@vger.kernel.org
Cc: Magnus Damm <damm@opensource.se>
Message-Id: <20050320223814.25305.52695.65404@clementine.local>
Subject: [PATCH 0/5] autoparam
Date: Mon, 21 Mar 2005 00:06:06 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are a set of patches that makes it possible to autogenerate kernel command
line documentation from the source code. The approach is rather straightforward
- the parameter name, the type and the description are stored in a section 
called __param_strings. After vmlinux is built this section is extracted using
objcopy and a script is used to generate a primitive - but up to date - 
document.

Right now the section is left in the kernel binary. The document is currently
not generated from the Makefile, so the curious user should perform:

$ objcopy -j __param_strings vmlinux -O binary foo
$ chmod a+x scripts/section2text.rb
$ cat foo | ./scripts/section2text.rb

And yeah, you need to install ruby to run the script.

The ruby script section2text.rb does some checks to see if MODULE_PARM_DESC()
is used without module_param(). You will find interesting typos.

Future work that extends this idea could include replacing __setup(name) with 
__setup(name, descr). And storing the documentation somewhere to make it easy
for the end user to look up the generated parameter list from the boot loader.

/ magnus

