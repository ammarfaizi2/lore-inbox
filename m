Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262028AbVCNWS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262028AbVCNWS7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 17:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262025AbVCNWPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 17:15:09 -0500
Received: from isilmar.linta.de ([213.239.214.66]:458 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S262029AbVCNWO1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 17:14:27 -0500
Date: Mon, 14 Mar 2005 23:14:21 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: inconsistent kallsyms data [2.6.11-mm2]
Message-ID: <20050314221421.GA13378@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Paulo Marques <pmarques@grupopie.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050308033846.0c4f8245.akpm@osdl.org> <20050308192900.GA16882@isilmar.linta.de> <20050308123554.669dd725.akpm@osdl.org> <20050308204521.GA17969@isilmar.linta.de> <422EF2B0.7070304@grupopie.com> <422F59A3.9010209@grupopie.com> <423039A6.5010301@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <423039A6.5010301@grupopie.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2005 at 12:12:22PM +0000, Paulo Marques wrote:
> Paulo Marques wrote:
> >[...]
> >A simple and robust way is to do the sampling on a list of symbols 
> >sorted by symbol name. This way, even if the symbol positions that are 
> >given to scripts/kallsyms change, the symbols sampled will be the same.
> >
> >I'll do the patch to do this and send it ASAP.
> 
> Ok, here it is.
> 
> Dominik can you try the attached patch and see if it solves the problem?

It does not solve the problem: 

 ~/local/kernel/linux-2.6.11-mm2 $ patch -p1 < ~/kallpatch 
patching file scripts/kallsyms.c
 ~/local/kernel/linux-2.6.11-mm2 $ make
  CHK     include/linux/version.h
  HOSTCC  scripts/kallsyms
make[1]: »arch/i386/kernel/asm-offsets.s« ist bereits aktualisiert.
  CHK     include/linux/compile.h
  CHK     usr/initramfs_list
  CC [M]  arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.o
  KSYM    .tmp_kallsyms1.S
  AS      .tmp_kallsyms1.o
  LD      .tmp_vmlinux2
  KSYM    .tmp_kallsyms2.S
  AS      .tmp_kallsyms2.o
  LD      vmlinux
  SYSMAP  System.map
  SYSMAP  .tmp_System.map
Inconsistent kallsyms data
Try setting CONFIG_KALLSYMS_EXTRA_PASS
make: *** [vmlinux] Fehler 1


Will test the other patch floating around in just a moment.

Thanks,
	Dominik
