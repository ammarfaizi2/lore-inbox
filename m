Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318086AbSHZORs>; Mon, 26 Aug 2002 10:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318111AbSHZORs>; Mon, 26 Aug 2002 10:17:48 -0400
Received: from zamok.crans.org ([138.231.136.6]:65454 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id <S318086AbSHZORq>;
	Mon, 26 Aug 2002 10:17:46 -0400
Date: Mon, 26 Aug 2002 16:22:03 +0200
To: Mauricio Pretto <pretto@interage.com.br>
Cc: Lista Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-pre4-ac2
Message-ID: <20020826142203.GA30310@darwin.crans.org>
References: <3D6A1476.4080004@interage.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3D6A1476.4080004@interage.com.br>
User-Agent: Mutt/1.4i
X-Warning: Email may contain unsmilyfied humor and/or satire.
From: Vincent Hanquez <tab@tuxfamily.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2002 at 08:43:50AM -0300, Mauricio Pretto wrote:
> Error at make bzImage with pre4-ac2 patch :
> My .config goes attached
> 
> make -C ide
> make[2]: Entrando no diretório `/usr/src/linux-2.4.19/drivers/ide'
> make all_targets
> make[3]: Entrando no diretório `/usr/src/linux-2.4.19/drivers/ide'
> rm -f idedriver.o
> ld -m elf_i386  -r -o idedriver.o ide-probe.o ide-geometry.o ide-iops.o 
> ide-taskfile.o ide.o ide-lib.o ide-disk.o ide-cd.o ide-dma.o ide-proc.o 
> setup-pci.o pci/idedriver-pci.o legacy/idedriver-legacy.o 
> ppc/idedriver-ppc.o arm/idedriver-arm.o raid/idedriver-raid.o
> ld: cannot open pci/idedriver-pci.o: Arquivo ou diretório não encontrado
> make[3]: ** [idedriver.o] Erro 1
> make[3]: Saindo do diretório `/usr/src/linux-2.4.19/drivers/ide'
> make[2]: ** [first_rule] Erro 2
> make[2]: Saindo do diretório `/usr/src/linux-2.4.19/drivers/ide'
> make[1]: ** [_subdir_ide] Erro 2
> make[1]: Saindo do diretório `/usr/src/linux-2.4.19/drivers'
> make: ** [_dir_drivers] Erro 2

Here Alan Cox answer on this known problem.

-- 
Tab

--- drivers/ide/Makefile~       2002-08-26 13:06:26.000000000 +0100
+++ drivers/ide/Makefile        2002-08-26 13:06:26.000000000 +0100
@@ -19,6 +19,9 @@
 obj-m          :=
 ide-obj-y      :=

+subdir-$(CONFIG_BLK_DEV_IDEPCI)        += pci
+subdir-$(CONFIG_BLK_DEV_IDE) += legacy ppc arm raid
+
 obj-$(CONFIG_BLK_DEV_IDE)              += ide-probe.o ide-geometry.o ide-iops.o
+ide-taskfile.o ide.o ide-lib.o
 obj-$(CONFIG_BLK_DEV_IDEDISK)          += ide-disk.o
 obj-$(CONFIG_BLK_DEV_IDECD)            += ide-cd.o

