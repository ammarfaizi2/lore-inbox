Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266721AbSKWCNR>; Fri, 22 Nov 2002 21:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266797AbSKWCNQ>; Fri, 22 Nov 2002 21:13:16 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:12556 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S266721AbSKWCNQ>;
	Fri, 22 Nov 2002 21:13:16 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: New module loader makes kernel debugging much harder
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 23 Nov 2002 13:20:10 +1100
Message-ID: <13542.1038018010@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The new module loader makes kernel debugging much harder.

There is no section information available, which means ...

* ksymoops cannot decode oops in modules.  Without section data, there
  is no way to reliably determine where module symbols were loaded.

* kgdb cannot debug modules.  gdb needs to know which modules are
  loaded and where each section of each module starts.

* kdb cannot display the section for a symbol.  Which means the user
  cannot do
    objdump -j <section_name> --adjust-vma=<start_address> module
  to map the code to the original object and source.

The complete lack of kernel and module symbols (no /proc/ksyms) means
that ksymoops is now useless on 2.5 kernels.  If you get an oops in a
kernel built without kksymoops, there is no way to decode the oops.

Big step backwards, Rusty.

