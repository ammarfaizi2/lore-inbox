Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbWBZQbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWBZQbx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 11:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbWBZQbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 11:31:52 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:16683 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750751AbWBZQbv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 11:31:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rgv6cwMit87axePdZVdtnelqbFqqS8DK/bW3BPR808cMM0abyqw6W60zvXdJDiFuDTOKy4VHGyrWan+G3ILl4Jy7W/loqWTJwisYMh9hi7NUCBcmXWNbABfiSFPS4bN56G4C7RcY7LNDtNzBnA1s4MClF/9QwKspWo4Oz9m8nio=
Message-ID: <9a8748490602260831l3338f03ew60f99648848aa177@mail.gmail.com>
Date: Sun, 26 Feb 2006 17:31:49 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Building 100 kernels; we suck at dependencies and drown in warnings
In-Reply-To: <200602261721.17373.jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200602261721.17373.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
>
> Hi everyone,
>
> I just sat down and build 100 kernels (2.6.16-rc4-mm2 kernels to be exact)
>
>         95 kernels were build with 'make randconfig'.
>         1 kernel was build with the config I normally use for my own box.
>         1 kernel was build from 'make defconfig'.
>         1 kernel was build from 'make allmodconfig'.
>         1 kernel was build from 'make allnoconfig'.
>         1 kernel was build from 'make allyesconfig'.
>
> That was an interresting experience.
>
> First of all not very many of the kernels actually build correctly and
> secondly, if I grep the build logs for warnings I'm swamped.
>
> Out of 100 kernels 82 failed to build - that's an 18% success rate people,
> not very impressive.
>
> Some of the failed builds are due to things like CONFIG_STANDALONE that
> will break the build if not set to Y (unless you have the firmware
> available ofcourse), but looking at the config files I find that only 26
> kernels have CONFIG_STANDALONE unset, so that only accounts for a quarter
> of the kernels.
>
> A lot of failed builds are due to invalid combinations of some stuff
> being build-in and some stuff being build as modules.
> This, as far as I'm concerned, is something that the dependencies in
> Kconfig should make impossible - hence my conclusion that we suck at deps.
>
> From 100 kernel builds there was a total of 16152 warnings and 645 of those
> are unique warnings, the rest are duplicates.
>
> We are drowning in warnings people. Sure, many of the warnings are due to
> gcc getting something wrong and shouldn't really be emitted, but a lot of
> them point to actual problems or deficiencies (I obviously haven't looked
> at them all in detail yet, so take that with a grain of salt please).
>
> In any case, it looks to me like we have some serious clean-up work to do.
>
> Unfortunately I don't have anywhere to put all the configs and logs online,
> but I can send them on request, or if someone can point at a space to
> upload them to I'll gladly make them available.
>
> That's it for now, I'll get to work trying to clean up some of the breakage
> I've seen, if anyone wants to join in feel free :)
>
>

For the interrested parties, here's a list of the unique warnings :

 warning: #warning "MCA legacy - please move your driver to the new sysfs api"
 warning: #warning sisfb will not work!
aicasm_gram.y: warning: 1 useless nonterminal and 6 useless rules
aicasm_gram.y:1314.9-37: warning: useless rule: f4_opcode: T_OR16
aicasm_gram.y:1315.9-38: warning: useless rule:   CC [M] 
drivers/scsi/aacraid/comminit.o
aicasm_gram.y:1315.9-38: warning: useless rule: f4_opcode: T_AND16
aicasm_gram.y:1316.9-38: warning: useless rule: f4_opcode: T_XOR16
aicasm_gram.y:1317.9-38: warning: useless rule: f4_opcode: T_ADD16
aicasm_gram.y:1318.9-38: warning: useless rule: f4_opcode: T_ADC16
aicasm_gram.y:1319.9-38: warning: useless rule: f4_opcode: T_MVI16
aicasm_gram.y:216.46-54: warning: useless nonterminal: f4_opcode
arch/i386/kernel/acpi/boot.c:85:2: warning: #warning ACPI uses
CMPXCHG, i486 and later hardware
arch/i386/kernel/apic.c:840: warning: implicit declaration of function
`GET_APIC_ID'
arch/i386/kernel/apm.c:1193: warning: `pm_send_all' is deprecated
(declared at include/linux/pm_legacy.h:26)
arch/i386/kernel/apm.c:1247: warning: `pm_send_all' is deprecated
(declared at include/linux/pm_legacy.h:26)
arch/i386/kernel/apm.c:1368: warning: `pm_send_all' is deprecated
(declared at include/linux/pm_legacy.h:26)
arch/i386/kernel/cpu/centaur.c:33: warning: implicit declaration of
function `mtrr_centaur_report_mcr'
arch/i386/kernel/cpu/common.c:296: warning: implicit declaration of
function `phys_pkg_id'
arch/i386/kernel/cpu/intel_cacheinfo.c:365: warning:
'cache_remove_shared_cpu_map' defined but not used
arch/i386/kernel/cpu/intel_cacheinfo.c:377: warning:
'cache_remove_shared_cpu_map' defined but not used
arch/i386/kernel/cpu/intel_cacheinfo.c:387: warning:
'detect_cache_attributes' defined but not used
arch/i386/kernel/io_apic.c:1722: warning: implicit declaration of
function `GET_APIC_ID'
arch/i386/kernel/kgdb_stub.c:1180: warning: implicit declaration of
function `ack_APIC_irq'
arch/i386/kernel/kprobes.c:135: warning: passing arg 1 of `down' from
incompatible pointer type
arch/i386/kernel/kprobes.c:137: warning: passing arg 1 of `up' from
incompatible pointer type
arch/i386/kernel/mpparse.c:847: warning: implicit declaration of
function `GET_APIC_ID'
arch/i386/mach-voyager/voyager_basic.c:55: warning:
'sysrq_voyager_dump_op' defined but not used
arch/i386/mach-voyager/voyager_cat.c:681: warning: comparison is
always false due to limited range of data type
arch/i386/mach-voyager/voyager_cat.c:751: warning: comparison is
always false due to limited range of data type
arch/i386/math-emu/fpu_entry.c:745: warning: ignoring return value of
`__copy_to_user', declared with attribute warn_unused_result
arch/i386/math-emu/reg_ld_str.c:1339: warning: ignoring return value
of `__copy_to_user', declared with attribute warn_unused_result
arch/i386/math-emu/reg_ld_str.c:1362: warning: ignoring return value
of `__copy_to_user', declared with attribute warn_unused_result
arch/i386/math-emu/reg_ld_str.c:1364: warning: ignoring return value
of `__copy_to_user', declared with attribute warn_unused_result
arch/i386/math-emu/reg_ld_str.c:247: warning: ignoring return value of
`copy_from_user', declared with attribute warn_unused_result
arch/i386/math-emu/reg_ld_str.c:910: warning: ignoring return value of
`copy_to_user', declared with attribute warn_unused_result
drivers/atm/iphase.c:961: warning: 'tcnter' defined but not used
drivers/atm/iphase.c:963: warning: 'xdump' defined but not used
drivers/block/cciss.c:2733: warning: label `default_int_mode' defined
but not used
drivers/cdrom/cm206.c:1398: warning: `sti' is deprecated (declared at
include/linux/interrupt.h:75)
drivers/cdrom/cm206.c:473: warning: `cli' is deprecated (declared at
include/linux/interrupt.h:71)
drivers/cdrom/cm206.c:490: warning: `cli' is deprecated (declared at
include/linux/interrupt.h:71)
drivers/cdrom/cm206.c:494: warning: `sti' is deprecated (declared at
include/linux/interrupt.h:75)
drivers/cdrom/mcdx.h:180:2: warning: #warning You have not edited mcdx.h
drivers/cdrom/mcdx.h:181:2: warning: #warning Perhaps irq and i/o
settings are wrong.
drivers/cdrom/sbpcd.c:1350: warning: `cli' is deprecated (declared at
include/linux/interrupt.h:71)
drivers/cdrom/sbpcd.c:1350: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/cdrom/sbpcd.c:1352: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/cdrom/sbpcd.c:1486: warning: `cli' is deprecated (declared at
include/linux/interrupt.h:71)
drivers/cdrom/sbpcd.c:1486: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/cdrom/sbpcd.c:1488: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/cdrom/sbpcd.c:5647: warning: `sti' is deprecated (declared at
include/linux/interrupt.h:75)
drivers/cdrom/sbpcd.c:5676: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:124)
drivers/cdrom/sbpcd.c:835: warning: `sti' is deprecated (declared at
include/linux/interrupt.h:75)
drivers/cdrom/sbpcd.c:837: warning: `sti' is deprecated (declared at
include/linux/interrupt.h:75)
drivers/char/./ip2/i2ellis.c:108: warning: 'iiEllisCleanup' defined but not used
drivers/char/agp/amd64-agp.c:754: warning: unused variable `amd64nb'
drivers/char/applicom.c:68: warning: 'applicom_pci_tbl' defined but not used
drivers/char/cs5535_gpio.c:42: warning: 'divil_pci' defined but not used
drivers/char/cyclades.c:1074: warning: 'cyy_interrupt' defined but not used
drivers/char/cyclades.c:1819: warning: 'cyz_interrupt' defined but not used
drivers/char/cyclades.c:4460: warning: 'cyy_init_card' defined but not used
drivers/char/cyclades.c:4652: warning: 'plx_init' defined but not used
drivers/char/drm/mga_dma.c:939: warning: unused variable `err'
drivers/char/drm/sis_mm.c:113: warning: long int format, __u32 arg (arg 4)
drivers/char/ftape/lowlevel/fdc-io.c:217: warning: `restore_flags' is
deprecated (declared at include/linux/interrupt.h:84)
drivers/char/ftape/lowlevel/fdc-io.c:885: warning: `restore_flags' is
deprecated (declared at include/linux/interrupt.h:84)
drivers/char/ftape/lowlevel/fdc-isr.c:1094: warning: `sti' is
deprecated (declared at include/linux/interrupt.h:75)
drivers/char/ftape/lowlevel/ftape-format.c:135: warning:
`restore_flags' is deprecated (declared at
include/linux/interrupt.h:84)
drivers/char/ftape/lowlevel/ftape-io.c:106: warning: `restore_flags'
is deprecated (declared at include/linux/interrupt.h:84)
drivers/char/ftape/lowlevel/ftape-io.c:98: warning: `save_flags' is
deprecated (declared at include/linux/interrupt.h:79)
drivers/char/ftape/lowlevel/ftape-io.c:99: warning: `sti' is
deprecated (declared at include/linux/interrupt.h:75)
drivers/char/ip2main.c:509: warning: unused variable `status'
drivers/char/ipmi/ipmi_msghandler.c:1533: warning:
'ipmb_file_read_proc' defined but not used
drivers/char/ipmi/ipmi_msghandler.c:1549: warning:
'version_file_read_proc' defined but not used
drivers/char/ipmi/ipmi_msghandler.c:1559: warning:
'stat_file_read_proc' defined but not used
drivers/char/ipmi/ipmi_poweroff.c:622: warning: label `out_err'
defined but not used
drivers/char/istallion.c:1125: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/istallion.c:1125: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)  LD     
arch/i386/pci/built-in.o
drivers/char/istallion.c:1126: warning: `cli' is deprecated (declared
at include/linux/interrupt.h:71)
drivers/char/istallion.c:1128: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/istallion.c:1134: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/istallion.c:1182: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/istallion.c:1263: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/istallion.c:1264: warning: `cli' is deprecated (declared
at include/linux/interrupt.h:71)
drivers/char/istallion.c:1275: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/istallion.c:1295: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/istallion.c:1309: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/istallion.c:1337: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/istallion.c:1338: warning: `cli' is deprecated (declared
at include/linux/interrupt.h:71)
drivers/char/istallion.c:1348: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/istallion.c:1368: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/istallion.c:1381: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/istallion.c:1407: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/istallion.c:1408: warning: `cli' is deprecated (declared
at include/linux/interrupt.h:71)
drivers/char/istallion.c:1412: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/istallion.c:1421: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/istallion.c:1424: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/istallion.c:1484: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/istallion.c:1485: warning: `cli' is deprecated (declared
at include/linux/interrupt.h:71)
drivers/char/istallion.c:1517: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/istallion.c:1564: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/istallion.c:1565: warning: `cli' is deprecated (declared
at include/linux/interrupt.h:71)
drivers/char/istallion.c:1611: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/istallion.c:1693: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/istallion.c:1694: warning: `cli' is deprecated (declared
at include/linux/interrupt.h:71)
drivers/char/istallion.c:1743: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/istallion.c:1778: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/istallion.c:1779: warning: `cli' is deprecated (declared
at include/linux/interrupt.h:71)
drivers/char/istallion.c:1789: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/istallion.c:1833: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/istallion.c:1834: warning: `cli' is deprecated (declared
at include/linux/interrupt.h:71)
drivers/char/istallion.c:1845: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/istallion.c:2290: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/istallion.c:2291: warning: `cli' is deprecated (declared
at include/linux/interrupt.h:71)
drivers/char/istallion.c:2305: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/istallion.c:2346: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/istallion.c:2347: warning: `cli' is deprecated (declared
at include/linux/interrupt.h:71)
drivers/char/istallion.c:2364: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/istallion.c:2640: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/istallion.c:2641: warning: `cli' is deprecated (declared
at include/linux/interrupt.h:71)
drivers/char/istallion.c:2646: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/istallion.c:2667: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/istallion.c:4174: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/istallion.c:4175: warning: `cli' is deprecated (declared
at include/linux/interrupt.h:71)
drivers/char/istallion.c:421: warning: 'istallion_pci_tbl' defined but not used
drivers/char/istallion.c:4252: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/istallion.c:4754: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/istallion.c:4755: warning: `cli' is deprecated (declared
at include/linux/interrupt.h:71)
drivers/char/istallion.c:4770: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/istallion.c:4810: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/istallion.c:4811: warning: `cli' is deprecated (declared
at include/linux/interrupt.h:71)
drivers/char/istallion.c:4826: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/istallion.c:4929: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/istallion.c:4930: warning: `cli' is deprecated (declared
at include/linux/interrupt.h:71)
drivers/char/istallion.c:4943: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/istallion.c:809: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/istallion.c:810: warning: `cli' is deprecated (declared
at include/linux/interrupt.h:71)
drivers/char/istallion.c:812: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/istallion.c:833: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/istallion.c:834: warning: `cli' is deprecated (declared
at include/linux/interrupt.h:71)
drivers/char/istallion.c:849: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/istallion.c:885: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/mxser.c:391: warning: 'mxser_get_PCI_conf' declared
`static' but never defined
drivers/char/mxser.c:432: warning: 'CheckIsMoxaMust' defined but not used
drivers/char/mxser.c:695: warning: unused variable `n'
drivers/char/mxser.c:696: warning: unused variable `pdev'
drivers/char/mxser.c:697: warning: unused variable `index'
drivers/char/mxser.c:698: warning: unused variable `busnum'
drivers/char/mxser.c:698: warning: unused variable `devnum'
drivers/char/rio/rio_linux.c:976: warning: passing arg 1 of `readl'
makes pointer from integer without a cast
drivers/char/rio/rio_linux.c:979: warning: passing arg 2 of `writel'
makes pointer from integer without a cast
drivers/char/rio/riotable.c:424: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/rio/riotable.c:457: warning: `restore_flags' is
deprecated (declared at include/linux/interrupt.h:84)
drivers/char/rio/riotable.c:797: warning: assignment discards
qualifiers from pointer target type
drivers/char/rio/riotable.c:798: warning: assignment discards
qualifiers from pointer target type
drivers/char/rio/riotable.c:799: warning: assignment discards
qualifiers from pointer target type
drivers/char/rio/riotable.c:800: warning: assignment discards
qualifiers from pointer target type
drivers/char/rio/riotable.c:801: warning: assignment discards
qualifiers from pointer target type
drivers/char/rio/riotable.c:802: warning: assignment discards
qualifiers from pointer target type
drivers/char/riscom8.c:1058: warning: `cli' is deprecated (declared at
include/linux/interrupt.h:71)
drivers/char/riscom8.c:1058: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/riscom8.c:1125: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/riscom8.c:1144: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/riscom8.c:1146: warning: `cli' is deprecated (declared at
include/linux/interrupt.h:71)
drivers/char/riscom8.c:1150: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/riscom8.c:1157: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/riscom8.c:1164: warning: `cli' is deprecated (declared at
include/linux/interrupt.h:71)
drivers/char/riscom8.c:1171: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/riscom8.c:1187: warning: `cli' is deprecated (declared at
include/linux/interrupt.h:71)
drivers/char/riscom8.c:1187: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/riscom8.c:1195: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/riscom8.c:1210: warning: `cli' is deprecated (declared at
include/linux/interrupt.h:71)
drivers/char/riscom8.c:1210: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/riscom8.c:1214: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/riscom8.c:1249: warning: `cli' is deprecated (declared at
include/linux/interrupt.h:71)
drivers/char/riscom8.c:1249: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/riscom8.c:1251: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/riscom8.c:1269: warning: `cli' is deprecated (declared at
include/linux/interrupt.h:71)
drivers/char/riscom8.c:1269: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/riscom8.c:1273: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/riscom8.c:1294: warning: `cli' is deprecated (declared at
include/linux/interrupt.h:71)
drivers/char/riscom8.c:1294: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/riscom8.c:1308: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/riscom8.c:1317: warning: `cli' is deprecated (declared at
include/linux/interrupt.h:71)
drivers/char/riscom8.c:1317: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/riscom8.c:1327: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/riscom8.c:1370: warning: `cli' is deprecated (declared at
include/linux/interrupt.h:71)
drivers/char/riscom8.c:1370: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/riscom8.c:1372: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/riscom8.c:1453: warning: `cli' is deprecated (declared at
include/linux/interrupt.h:71)
drivers/char/riscom8.c:1453: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/riscom8.c:1462: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/riscom8.c:1476: warning: `cli' is deprecated (declared at
include/linux/interrupt.h:71)
drivers/char/riscom8.c:1476: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/riscom8.c:1485: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/riscom8.c:1499: warning: `cli' is deprecated (declared at
include/linux/interrupt.h:71)
drivers/char/riscom8.c:1499: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/riscom8.c:1503: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/riscom8.c:1517: warning: `cli' is deprecated (declared at
include/linux/interrupt.h:71)
drivers/char/riscom8.c:1517: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/riscom8.c:1523: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/riscom8.c:1575: warning: `cli' is deprecated (declared at
include/linux/interrupt.h:71)
drivers/char/riscom8.c:1575: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/riscom8.c:1577: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/riscom8.c:1673: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/riscom8.c:1674: warning: `cli' is deprecated (declared at
include/linux/interrupt.h:71)
drivers/char/riscom8.c:1678: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/riscom8.c:235: warning: `cli' is deprecated (declared at
include/linux/interrupt.h:71)
drivers/char/riscom8.c:235: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/riscom8.c:239: warning: `sti' is deprecated (declared at
include/linux/interrupt.h:75)
drivers/char/riscom8.c:241: warning: `cli' is deprecated (declared at
include/linux/interrupt.h:71)
drivers/char/riscom8.c:252: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/riscom8.c:850: warning: `cli' is deprecated (declared at
include/linux/interrupt.h:71)
drivers/char/riscom8.c:850: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/riscom8.c:862: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/riscom8.c:973: warning: `cli' is deprecated (declared at
include/linux/interrupt.h:71)
drivers/char/riscom8.c:976: warning: `sti' is deprecated (declared at
include/linux/interrupt.h:75)
drivers/char/riscom8.c:979: warning: `cli' is deprecated (declared at
include/linux/interrupt.h:71)
drivers/char/riscom8.c:985: warning: `sti' is deprecated (declared at
include/linux/interrupt.h:75)
drivers/char/rocket.c:2736: warning: 'sPCIInitController' defined but not used
drivers/char/rocket.c:3273: warning: 'rmSpeakerReset' defined but not used
drivers/char/stallion.c:1085: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/stallion.c:1086: warning: `cli' is deprecated (declared
at include/linux/interrupt.h:71)
drivers/char/stallion.c:1115: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/stallion.c:1135: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/stallion.c:1136: warning: `cli' is deprecated (declared
at include/linux/interrupt.h:71)
drivers/char/stallion.c:1138: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/stallion.c:1144: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/stallion.c:1189: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/stallion.c:2898: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/stallion.c:2899: warning: `cli' is deprecated (declared
at include/linux/interrupt.h:71)
drivers/char/stallion.c:2913: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/stallion.c:3447: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/stallion.c:3448: warning: `cli' is deprecated (declared
at include/linux/interrupt.h:71)
drivers/char/stallion.c:3485: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/stallion.c:3511: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/stallion.c:3512: warning: `cli' is deprecated (declared
at include/linux/interrupt.h:71)
drivers/char/stallion.c:3520: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/stallion.c:3539: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/stallion.c:3540: warning: `cli' is deprecated (declared
at include/linux/interrupt.h:71)
drivers/char/stallion.c:3546: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/stallion.c:3588: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/stallion.c:3589: warning: `cli' is deprecated (declared
at include/linux/interrupt.h:71)
drivers/char/stallion.c:3596: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/stallion.c:3628: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/stallion.c:3629: warning: `cli' is deprecated (declared
at include/linux/interrupt.h:71)
drivers/char/stallion.c:3637: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/stallion.c:3653: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/stallion.c:3654: warning: `cli' is deprecated (declared
at include/linux/interrupt.h:71)
drivers/char/stallion.c:3659: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/stallion.c:3672: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/stallion.c:3673: warning: `cli' is deprecated (declared
at include/linux/interrupt.h:71)
drivers/char/stallion.c:3683: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/stallion.c:3707: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/stallion.c:3708: warning: `cli' is deprecated (declared
at include/linux/interrupt.h:71)
drivers/char/stallion.c:3748: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/stallion.c:3772: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/stallion.c:3773: warning: `cli' is deprecated (declared
at include/linux/interrupt.h:71)
drivers/char/stallion.c:3788: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/stallion.c:3804: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/stallion.c:3805: warning: `cli' is deprecated (declared
at include/linux/interrupt.h:71)
drivers/char/stallion.c:3813: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/stallion.c:4452: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/stallion.c:4453: warning: `cli' is deprecated (declared
at include/linux/interrupt.h:71)
drivers/char/stallion.c:4480: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/stallion.c:4510: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/stallion.c:4511: warning: `cli' is deprecated (declared
at include/linux/interrupt.h:71)
drivers/char/stallion.c:4516: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/stallion.c:4535: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/stallion.c:4536: warning: `cli' is deprecated (declared
at include/linux/interrupt.h:71)
drivers/char/stallion.c:4540: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/stallion.c:4577: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/stallion.c:4578: warning: `cli' is deprecated (declared
at include/linux/interrupt.h:71)
drivers/char/stallion.c:4583: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/stallion.c:4612: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/stallion.c:4613: warning: `cli' is deprecated (declared
at include/linux/interrupt.h:71)
drivers/char/stallion.c:4620: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/stallion.c:4637: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/stallion.c:4638: warning: `cli' is deprecated (declared
at include/linux/interrupt.h:71)
drivers/char/stallion.c:4643: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/stallion.c:4656: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/stallion.c:4657: warning: `cli' is deprecated (declared
at include/linux/interrupt.h:71)
drivers/char/stallion.c:4666: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/stallion.c:4691: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/stallion.c:4692: warning: `cli' is deprecated (declared
at include/linux/interrupt.h:71)
drivers/char/stallion.c:4738: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/stallion.c:4763: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/stallion.c:4764: warning: `cli' is deprecated (declared
at include/linux/interrupt.h:71)
drivers/char/stallion.c:4784: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/stallion.c:4800: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/stallion.c:4801: warning: `cli' is deprecated (declared
at include/linux/interrupt.h:71)
drivers/char/stallion.c:4807: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/stallion.c:4834: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/stallion.c:4835: warning: `cli' is deprecated (declared
at include/linux/interrupt.h:71)
drivers/char/stallion.c:4839: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/stallion.c:735: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/stallion.c:736: warning: `cli' is deprecated (declared at
include/linux/interrupt.h:71)
drivers/char/stallion.c:738: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/stallion.c:760: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/char/stallion.c:761: warning: `cli' is deprecated (declared at
include/linux/interrupt.h:71)
drivers/char/stallion.c:774: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/stallion.c:819: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/char/sx.c:255: warning: 'sx_pci_tbl' defined but not used
drivers/char/tpm/tpm.c:597: warning: assignment from incompatible pointer type
drivers/char/tpm/tpm.c:597: warning: assignment from incompatible
pointer type  CC      fs/nls/nls_iso8859-9.o
drivers/char/watchdog/alim1535_wdt.c:314: warning: 'ali_pci_tbl'
defined but not used
drivers/hwmon/lm75.c:36: warning: 'id' defined but not used
drivers/ide/ide-tape.c:2663: warning: ignoring return value of
`copy_from_user', declared with attribute warn_unused_result
drivers/ide/ide-tape.c:2690: warning: ignoring return value of
`copy_to_user', declared with attribute warn_unused_result
drivers/ide/pci/generic.c:45: warning: 'ide_generic_all_on' defined but not used
drivers/ide/setup-pci.c:511:2: warning: #warning
CONFIG_IDEDMA_PCI_AUTO=n support is obsolete, and will be removed
soon.
drivers/isdn/capi/capidrv.c:2108:3: warning: #warning FIXME: maybe a
race condition the card should be removed here from global list /kkeil
drivers/isdn/divert/divert_procfs.c:108: warning: 'isdn_divert_write'
defined but not used
drivers/isdn/divert/divert_procfs.c:118: warning: 'isdn_divert_poll'
defined but not used
drivers/isdn/divert/divert_procfs.c:134: warning: 'isdn_divert_open'
defined but not used
drivers/isdn/divert/divert_procfs.c:153: warning: 'isdn_divert_close'
defined but not used
drivers/isdn/divert/divert_procfs.c:180: warning: 'isdn_divert_ioctl'
defined but not used
drivers/isdn/divert/divert_procfs.c:80: warning: 'isdn_divert_read'
defined but not used
drivers/isdn/hisax/config.c:1879: warning: 'hisax_pci_tbl' defined but not used
drivers/isdn/hisax/config.c:635: warning: ignoring return value of
`copy_to_user', declared with attribute warn_unused_result
drivers/isdn/hisax/config.c:646: warning: ignoring return value of
`copy_to_user', declared with attribute warn_unused_result
drivers/isdn/hisax/diva.c:1104: warning: label `ready' defined but not used
drivers/isdn/hisax/elsa.c:836: warning: 'dev_qs1000' defined but not used
drivers/isdn/hisax/elsa.c:837: warning: 'dev_qs3000' defined but not used
drivers/isdn/hisax/niccy.c:236: warning: 'niccy_dev' defined but not used
drivers/isdn/hisax/sedlbauer.c:681: warning: label `ready' defined but not used
drivers/isdn/hysdn/boardergo.c:116: warning: `cli' is deprecated
(declared at include/linux/interrupt.h:71)
drivers/isdn/hysdn/boardergo.c:124: warning: `restore_flags' is
deprecated (declared at include/linux/interrupt.h:84)
drivers/isdn/hysdn/boardergo.c:141: warning: `save_flags' is
deprecated (declared at include/linux/interrupt.h:79)
drivers/isdn/hysdn/boardergo.c:142: warning: `cli' is deprecated
(declared at include/linux/interrupt.h:71)
drivers/isdn/hysdn/boardergo.c:151: warning: `restore_flags' is
deprecated (declared at include/linux/interrupt.h:84)
drivers/isdn/hysdn/boardergo.c:166: warning: `save_flags' is
deprecated (declared at include/linux/interrupt.h:79)
drivers/isdn/hysdn/boardergo.c:167: warning: `cli' is deprecated
(declared at include/linux/interrupt.h:71)
drivers/isdn/hysdn/boardergo.c:171: warning: `restore_flags' is
deprecated (declared at include/linux/interrupt.h:84)
drivers/isdn/hysdn/boardergo.c:179: warning: `restore_flags' is
deprecated (declared at include/linux/interrupt.h:84)
drivers/isdn/hysdn/boardergo.c:249: warning: `sti' is deprecated
(declared at include/linux/interrupt.h:75)
drivers/isdn/hysdn/boardergo.c:283: warning: `sti' is deprecated
(declared at include/linux/interrupt.h:75)
drivers/isdn/hysdn/boardergo.c:359: warning: `save_flags' is
deprecated (declared at include/linux/interrupt.h:79)
drivers/isdn/hysdn/boardergo.c:360: warning: `cli' is deprecated
(declared at include/linux/interrupt.h:71)
drivers/isdn/hysdn/boardergo.c:373: warning: `restore_flags' is
deprecated (declared at include/linux/interrupt.h:84)
drivers/isdn/hysdn/boardergo.c:388: warning: `sti' is deprecated
(declared at include/linux/interrupt.h:75)
drivers/isdn/hysdn/boardergo.c:49: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/isdn/hysdn/boardergo.c:50: warning: `cli' is deprecated
(declared at include/linux/interrupt.h:71)
drivers/isdn/hysdn/boardergo.c:53: warning: `restore_flags' is
deprecated (declared at include/linux/interrupt.h:84)
drivers/isdn/hysdn/boardergo.c:65: warning: `restore_flags' is
deprecated (declared at include/linux/interrupt.h:84)
drivers/isdn/hysdn/boardergo.c:87: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/isdn/hysdn/boardergo.c:88: warning: `cli' is deprecated
(declared at include/linux/interrupt.h:71)
drivers/isdn/hysdn/boardergo.c:90: warning: `restore_flags' is
deprecated (declared at include/linux/interrupt.h:84)
drivers/isdn/hysdn/boardergo.c:96: warning: `sti' is deprecated
(declared at include/linux/interrupt.h:75)
drivers/isdn/hysdn/hysdn_proclog.c:119: warning: `save_flags' is
deprecated (declared at include/linux/interrupt.h:79)
drivers/isdn/hysdn/hysdn_proclog.c:120: warning: `cli' is deprecated
(declared at include/linux/interrupt.h:71)
drivers/isdn/hysdn/hysdn_proclog.c:128: warning: `restore_flags' is
deprecated (declared at include/linux/interrupt.h:84)
drivers/isdn/hysdn/hysdn_proclog.c:273: warning: `save_flags' is
deprecated (declared at include/linux/interrupt.h:79)
drivers/isdn/hysdn/hysdn_proclog.c:274: warning: `cli' is deprecated
(declared at include/linux/interrupt.h:71)
drivers/isdn/hysdn/hysdn_proclog.c:280: warning: `restore_flags' is
deprecated (declared at include/linux/interrupt.h:84)
drivers/isdn/hysdn/hysdn_proclog.c:314: warning: `save_flags' is
deprecated (declared at include/linux/interrupt.h:79)
drivers/isdn/hysdn/hysdn_proclog.c:315: warning: `cli' is deprecated
(declared at include/linux/interrupt.h:71)
drivers/isdn/hysdn/hysdn_proclog.c:338: warning: `restore_flags' is
deprecated (declared at include/linux/interrupt.h:84)
drivers/isdn/hysdn/hysdn_sched.c:156: warning: `save_flags' is
deprecated (declared at include/linux/interrupt.h:79)
drivers/isdn/hysdn/hysdn_sched.c:157: warning: `cli' is deprecated
(declared at include/linux/interrupt.h:71)
drivers/isdn/hysdn/hysdn_sched.c:159: warning: `sti' is deprecated
(declared at include/linux/interrupt.h:75)
drivers/isdn/hysdn/hysdn_sched.c:166: warning: `restore_flags' is
deprecated (declared at include/linux/interrupt.h:84)
drivers/isdn/hysdn/hysdn_sched.c:169: warning: `cli' is deprecated
(declared at include/linux/interrupt.h:71)
drivers/isdn/hysdn/hysdn_sched.c:179: warning: `sti' is deprecated
(declared at include/linux/interrupt.h:75)
drivers/isdn/hysdn/hysdn_sched.c:185: warning: `cli' is deprecated
(declared at include/linux/interrupt.h:71)
drivers/isdn/hysdn/hysdn_sched.c:188: warning: `sti' is deprecated
(declared at include/linux/interrupt.h:75)
drivers/isdn/hysdn/hysdn_sched.c:195: warning: `restore_flags' is
deprecated (declared at include/linux/interrupt.h:84)
drivers/isdn/hysdn/hysdn_sched.c:198: warning: `cli' is deprecated
(declared at include/linux/interrupt.h:71)
drivers/isdn/hysdn/hysdn_sched.c:201: warning: `restore_flags' is
deprecated (declared at include/linux/interrupt.h:84)
drivers/isdn/i4l/isdn_common.c:1268: warning: unused variable `s'
drivers/isdn/i4l/isdn_common.c:1956: warning: ignoring return value of
`copy_from_user', declared with attribute warn_unused_result
drivers/isdn/i4l/isdn_ppp.c:434: warning: 'get_filter' defined but not used
drivers/isdn/icn/icn.c:719:4: warning: #warning TODO test headroom or
use skb->nb to flag ACK
drivers/isdn/isdnloop/isdnloop.c:1031: warning: `save_flags' is
deprecated (declared at include/linux/interrupt.h:79)
drivers/isdn/isdnloop/isdnloop.c:1032: warning: `cli' is deprecated
(declared at include/linux/interrupt.h:71)
drivers/isdn/isdnloop/isdnloop.c:1043: warning: `restore_flags' is
deprecated (declared at include/linux/interrupt.h:84)
drivers/isdn/isdnloop/isdnloop.c:104: warning: `save_flags' is
deprecated (declared at include/linux/interrupt.h:79)
drivers/isdn/isdnloop/isdnloop.c:105: warning: `cli' is deprecated
(declared at include/linux/interrupt.h:71)
drivers/isdn/isdnloop/isdnloop.c:1082: warning: `save_flags' is
deprecated (declared at include/linux/interrupt.h:79)
drivers/isdn/isdnloop/isdnloop.c:1083: warning: `cli' is deprecated
(declared at include/linux/interrupt.h:71)
drivers/isdn/isdnloop/isdnloop.c:1088: warning: `restore_flags' is
deprecated (declared at include/linux/interrupt.h:84)
drivers/isdn/isdnloop/isdnloop.c:1093: warning: `restore_flags' is
deprecated (declared at include/linux/interrupt.h:84)
drivers/isdn/isdnloop/isdnloop.c:109: warning: `restore_flags' is
deprecated (declared at include/linux/interrupt.h:84)
drivers/isdn/isdnloop/isdnloop.c:1102: warning: `restore_flags' is
deprecated (declared at include/linux/interrupt.h:84)
drivers/isdn/isdnloop/isdnloop.c:1107: warning: `restore_flags' is
deprecated (declared at include/linux/interrupt.h:84)
drivers/isdn/isdnloop/isdnloop.c:1115: warning: `restore_flags' is
deprecated (declared at include/linux/interrupt.h:84)
drivers/isdn/isdnloop/isdnloop.c:1126: warning: `restore_flags' is
deprecated (declared at include/linux/interrupt.h:84)
drivers/isdn/isdnloop/isdnloop.c:285: warning: `save_flags' is
deprecated (declared at include/linux/interrupt.h:79)
drivers/isdn/isdnloop/isdnloop.c:286: warning: `cli' is deprecated
(declared at include/linux/interrupt.h:71)
drivers/isdn/isdnloop/isdnloop.c:294: warning: `restore_flags' is
deprecated (declared at include/linux/interrupt.h:84)
drivers/isdn/isdnloop/isdnloop.c:376: warning: `save_flags' is
deprecated (declared at include/linux/interrupt.h:79)
drivers/isdn/isdnloop/isdnloop.c:377: warning: `cli' is deprecated
(declared at include/linux/interrupt.h:71)
drivers/isdn/isdnloop/isdnloop.c:383: warning: `restore_flags' is
deprecated (declared at include/linux/interrupt.h:84)
drivers/isdn/isdnloop/isdnloop.c:386: warning: `save_flags' is
deprecated (declared at include/linux/interrupt.h:79)
drivers/isdn/isdnloop/isdnloop.c:387: warning: `cli' is deprecated
(declared at include/linux/interrupt.h:71)
drivers/isdn/isdnloop/isdnloop.c:390: warning: `restore_flags' is
deprecated (declared at include/linux/interrupt.h:84)
drivers/isdn/isdnloop/isdnloop.c:420: warning: `save_flags' is
deprecated (declared at include/linux/interrupt.h:79)
drivers/isdn/isdnloop/isdnloop.c:421: warning: `cli' is deprecated
(declared at include/linux/interrupt.h:71)
drivers/isdn/isdnloop/isdnloop.c:430: warning: `restore_flags' is
deprecated (declared at include/linux/interrupt.h:84)
drivers/isdn/isdnloop/isdnloop.c:580: warning: `save_flags' is
deprecated (declared at include/linux/interrupt.h:79)
drivers/isdn/isdnloop/isdnloop.c:581: warning: `cli' is deprecated
(declared at include/linux/interrupt.h:71)
drivers/isdn/isdnloop/isdnloop.c:591: warning: `restore_flags' is
deprecated (declared at include/linux/interrupt.h:84)
drivers/isdn/isdnloop/isdnloop.c:626: warning: `save_flags' is
deprecated (declared at include/linux/interrupt.h:79)
drivers/isdn/isdnloop/isdnloop.c:627: warning: `cli' is deprecated
(declared at include/linux/interrupt.h:71)
drivers/isdn/isdnloop/isdnloop.c:636: warning: `restore_flags' is
deprecated (declared at include/linux/interrupt.h:84)
drivers/isdn/isdnloop/isdnloop.c:651: warning: `save_flags' is
deprecated (declared at include/linux/interrupt.h:79)
drivers/isdn/isdnloop/isdnloop.c:652: warning: `cli' is deprecated
(declared at include/linux/interrupt.h:71)
drivers/isdn/isdnloop/isdnloop.c:654: warning: `restore_flags' is
deprecated (declared at include/linux/interrupt.h:84)
drivers/isdn/isdnloop/isdnloop.c:710: warning: `save_flags' is
deprecated (declared at include/linux/interrupt.h:79)
drivers/isdn/isdnloop/isdnloop.c:711: warning: `cli' is deprecated
(declared at include/linux/interrupt.h:71)
drivers/isdn/isdnloop/isdnloop.c:716: warning: `restore_flags' is
deprecated (declared at include/linux/interrupt.h:84)
drivers/isdn/isdnloop/isdnloop.c:724: warning: `restore_flags' is
deprecated (declared at include/linux/interrupt.h:84)
drivers/isdn/isdnloop/isdnloop.c:727: warning: `restore_flags' is
deprecated (declared at include/linux/interrupt.h:84)
drivers/isdn/pcbit/drv.c:728: warning: ignoring return value of
`copy_to_user', declared with attribute warn_unused_result
drivers/isdn/pcbit/drv.c:735: warning: ignoring return value of
`copy_to_user', declared with attribute warn_unused_result
drivers/isdn/pcbit/drv.c:737: warning: ignoring return value of
`copy_to_user', declared with attribute warn_unused_result
drivers/isdn/pcbit/drv.c:744: warning: ignoring return value of
`copy_to_user', declared with attribute warn_unused_result
drivers/isdn/sc/init.c:492: warning: passing arg 1 of `readl' makes
pointer from integer without a cast
drivers/isdn/sc/init.c:502: warning: passing arg 1 of `readl' makes
pointer from integer without a cast
drivers/isdn/sc/init.c:512: warning: passing arg 1 of `readl' makes
pointer from integer without a cast
drivers/isdn/sc/shmem.c:60: warning: passing arg 1 of `memcpy_toio'
makes pointer from integer without a cast
drivers/media/video/video-buf.c:351: warning: cast from pointer to
integer of different size
drivers/media/video/zoran_card.c:150: warning: 'zr36067_pci_tbl'
defined but not used
drivers/mtd/chips/cfi_cmdset_0001.c:2454: warning:
`inter_module_register' is deprecated (declared at
include/linux/module.h:562)
drivers/mtd/chips/cfi_cmdset_0001.c:2455: warning:
`inter_module_register' is deprecated (declared at
include/linux/module.h:562)
drivers/mtd/chips/cfi_cmdset_0001.c:2456: warning:
`inter_module_register' is deprecated (declared at
include/linux/module.h:562)
drivers/mtd/chips/cfi_cmdset_0001.c:2462: warning:
`inter_module_unregister' is deprecated (declared at
include/linux/module.h:563)
drivers/mtd/chips/cfi_cmdset_0001.c:2463: warning:
`inter_module_unregister' is deprecated (declared at
include/linux/module.h:563)
drivers/mtd/chips/cfi_cmdset_0001.c:2464: warning:
`inter_module_unregister' is deprecated (declared at
include/linux/module.h:563)
drivers/mtd/chips/cfi_cmdset_0002.c:1766: warning:
`inter_module_register' is deprecated (declared at
include/linux/module.h:562)
drivers/mtd/chips/cfi_cmdset_0002.c:1773: warning:
`inter_module_unregister' is deprecated (declared at
include/linux/module.h:563)
drivers/mtd/chips/cfi_cmdset_0020.c:1417: warning:
`inter_module_register' is deprecated (declared at
include/linux/module.h:562)
drivers/mtd/chips/cfi_cmdset_0020.c:1423: warning:
`inter_module_unregister' is deprecated (declared at
include/linux/module.h:563)
drivers/mtd/chips/gen_probe.c:210: warning: `inter_module_put' is
deprecated (declared at include/linux/module.h:566)
drivers/mtd/devices/doc2000.c:1282: warning: `inter_module_register'
is deprecated (declared at include/linux/module.h:562)
drivers/mtd/devices/doc2000.c:1301: warning: `inter_module_unregister'
is deprecated (declared at include/linux/module.h:563)
drivers/mtd/devices/doc2001.c:861: warning: `inter_module_register' is
deprecated (declared at include/linux/module.h:562)
drivers/mtd/devices/doc2001.c:880: warning: `inter_module_unregister'
is deprecated (declared at include/linux/module.h:563)
drivers/mtd/devices/doc2001plus.c:1127: warning:
`inter_module_register' is deprecated (declared at
include/linux/module.h:562)
drivers/mtd/devices/doc2001plus.c:1146: warning:
`inter_module_unregister' is deprecated (declared at
include/linux/module.h:563)
drivers/mtd/devices/docprobe.c:315: warning: `inter_module_put' is
deprecated (declared at include/linux/module.h:566)
drivers/mtd/maps/nettel.c:418: warning: implicit declaration of function `MKDEV'
drivers/net/3c523.c:555: warning: 'cleanup_card' defined but not used
drivers/net/cs89x0.c:199: warning: 'netcard_portlist' defined but not used
drivers/net/e1000/e1000_main.c:4555: warning: 'e1000_suspend' defined
but not used
drivers/net/hamradio/bpqether.c:462: warning: 'bpq_info_fops' defined
but not used
drivers/net/hamradio/dmascc.c:1096: warning: `save_flags' is
deprecated (declared at include/linux/interrupt.h:79)
drivers/net/hamradio/dmascc.c:1097: warning: `cli' is deprecated
(declared at include/linux/interrupt.h:71)
drivers/net/hamradio/dmascc.c:1104: warning: `restore_flags' is
deprecated (declared at include/linux/interrupt.h:84)
drivers/net/hp100.c:2822: warning: 'cleanup_dev' defined but not used
drivers/net/hp100.c:3044: warning: label `out3' defined but not used
drivers/net/hp100.c:374: warning: 'hp100_isa_probe' defined but not used
drivers/net/ibmlana.c:875: warning: 'ibmlana_probe' defined but not used
drivers/net/irda/ali-ircc.c:232: warning: `pm_unregister_all' is
deprecated (declared at include/linux/pm_legacy.h:21)
drivers/net/irda/ali-ircc.c:361: warning: `pm_register' is deprecated
(declared at include/linux/pm_legacy.h:16)
drivers/net/r8169.c:2138: warning: 'txd' might be used uninitialized
in this function
drivers/net/tg3.c:8113: warning: 'rx_idx' might be used uninitialized
in this function
drivers/net/tg3.c:8113: warning: 'tx_idx' might be used uninitialized
in this function
drivers/net/wan/farsync.c:1339: warning: cast to pointer from integer
of different size
drivers/net/wan/farsync.c:1437: warning: cast to pointer from integer
of different size
drivers/net/wan/syncppp.c:765: warning: unused variable `in_dev'
drivers/net/wan/syncppp.c:766: warning: unused variable `ifa'
drivers/net/wireless/ipw2100.c:2874: warning: cast to pointer from
integer of different size
drivers/net/wireless/ray_cs.c:296: warning: 'rcsid' defined but not used
drivers/pci/pcie/portdrv_pci.c:34: warning: 'pcie_portdrv_save_config'
defined but not used
drivers/pci/pcie/portdrv_pci.c:39: warning:
'pcie_portdrv_restore_config' defined but not used
drivers/scsi/BusLogic.c:2302: warning: ignoring return value of
`scsi_add_host', declared with attribute warn_unused_result
drivers/scsi/BusLogic.c:2963: warning: 'BusLogic_AbortCommand' defined
but not used
drivers/scsi/BusLogic.c:585: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:124)
drivers/scsi/BusLogic.c:587: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:124)
drivers/scsi/BusLogic.c:589: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:124)
drivers/scsi/BusLogic.c:591: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:124)
drivers/scsi/BusLogic.c:593: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:124)
drivers/scsi/BusLogic.c:595: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:124)
drivers/scsi/BusLogic.c:801: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:124)
drivers/scsi/BusLogic.c:811: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:124)
drivers/scsi/BusLogic.c:813: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:124)
drivers/scsi/BusLogic.c:815: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:124)
drivers/scsi/BusLogic.c:817: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:124)
drivers/scsi/BusLogic.c:819: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:124)
drivers/scsi/NCR5380.c:360: warning: 'phases' defined but not used
drivers/scsi/NCR5380.c:580: warning: 'NCR5380_probe_irq' defined but not used
drivers/scsi/NCR5380.c:634: warning: 'NCR5380_print_options' defined
but not used
drivers/scsi/NCR5380.c:709: warning: 'NCR5380_proc_info' defined but not used
drivers/scsi/NCR5380.c:709: warning: 'notyet_generic_proc_info'
defined but not used
drivers/scsi/NCR53c406a.c:610: warning: 'NCR53c406a_setup' defined but not used
drivers/scsi/aha1740.c:645: warning: ignoring return value of
`scsi_add_host', declared with attribute warn_unused_result
drivers/scsi/aic7xxx_old.c:8917: warning: 'aic7xxx_configure_bugs'
defined but not used
drivers/scsi/dc395x.c:4292: warning: 'ptr' might be used uninitialized
in this function
drivers/scsi/dpt_i2o.c:171: warning: 'dptids' defined but not used
drivers/scsi/dtc.c:183: warning: 'dtc_setup' defined but not used
drivers/scsi/fd_mcs.c:298: warning: 'fd_mcs_setup' defined but not used
drivers/scsi/fdomain.c:425: warning: 'ports' defined but not used
drivers/scsi/fdomain.c:469: warning: 'signatures' defined but not used
drivers/scsi/fdomain.c:652: warning: 'fdomain_get_irq' defined but not used
drivers/scsi/g_NCR5380.c:562:5: warning:   CC     
drivers/usb/gadget/file_storage.o
drivers/scsi/g_NCR5380.c:562:5: warning: "NCR53C400_PSEUDO_DMA" is not defined
drivers/scsi/g_NCR5380.c:945: warning: 'id_table' defined but not used
drivers/scsi/ibmmca.c:1895: warning: cast to pointer from integer of
different size
drivers/scsi/ips.c:7043: warning: ignoring return value of
`scsi_add_host', declared with attribute warn_unused_result
drivers/scsi/mca_53c9x.c:345: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/scsi/mca_53c9x.c:346: warning: `cli' is deprecated (declared
at include/linux/interrupt.h:71)
drivers/scsi/mca_53c9x.c:355: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/scsi/mca_53c9x.c:363: warning: `save_flags' is deprecated
(declared at include/linux/interrupt.h:79)
drivers/scsi/mca_53c9x.c:364: warning: `cli' is deprecated (declared
at include/linux/interrupt.h:71)
drivers/scsi/mca_53c9x.c:373: warning: `restore_flags' is deprecated
(declared at include/linux/interrupt.h:84)
drivers/scsi/megaraid.c:1153: warning: passing arg 2 of `writel' makes
pointer from integer without a cast
drivers/scsi/megaraid.c:1216: warning: passing arg 2 of `writel' makes
pointer from integer without a cast
drivers/scsi/megaraid.c:1229: warning: passing arg 2 of `writel' makes
pointer from integer without a cast
drivers/scsi/megaraid.c:1231: warning: passing arg 1 of `readl' makes
pointer from integer without a cast
drivers/scsi/megaraid.c:1361: warning: passing arg 1 of `readl' makes
pointer from integer without a cast
drivers/scsi/megaraid.c:1368: warning: passing arg 2 of `writel' makes
pointer from integer without a cast
drivers/scsi/megaraid.c:1387: warning: passing arg 2 of `writel' makes
pointer from integer without a cast
drivers/scsi/megaraid.c:1391: warning: passing arg 1 of `readl' makes
pointer from integer without a cast
drivers/scsi/megaraid.c:3665: warning: ignoring return value of
`copy_to_user', declared with attribute warn_unused_result
drivers/scsi/megaraid.c:4363: warning: 'mega_adapinq' defined but not used
drivers/scsi/megaraid.c:4398: warning: 'mega_internal_dev_inquiry'
defined but not used
drivers/scsi/megaraid.c:4972: warning: unused variable `buf'
drivers/scsi/megaraid.h:1004: warning: 'mega_print_inquiry' declared
`static' but never defined
drivers/scsi/ncr53c8xx.c:8326: warning: 'ncr53c8xx_setup' defined but not used
drivers/scsi/nsp32.c:2889: warning: ignoring return value of
`scsi_add_host', declared with attribute warn_unused_result
drivers/scsi/sata_svw.c:113: warning: passing arg 2 of `writeb' makes
pointer from integer without a cast
drivers/scsi/sata_svw.c:118: warning: passing arg 2 of `writew' makes
pointer from integer without a cast
drivers/scsi/sata_svw.c:119: warning: passing arg 2 of `writew' makes
pointer from integer without a cast
drivers/scsi/sata_svw.c:120: warning: passing arg 2 of `writew' makes
pointer from integer without a cast
drivers/scsi/sata_svw.c:121: warning: passing arg 2 of `writew' makes
pointer from integer without a cast
drivers/scsi/sata_svw.c:122: warning: passing arg 2 of `writew' makes
pointer from integer without a cast
drivers/scsi/sata_svw.c:124: warning: passing arg 2 of `writew' makes
pointer from integer without a cast
drivers/scsi/sata_svw.c:125: warning: passing arg 2 of `writew' makes
pointer from integer without a cast
drivers/scsi/sata_svw.c:126: warning: passing arg 2 of `writew' makes
pointer from integer without a cast
drivers/scsi/sata_svw.c:127: warning: passing arg 2 of `writew' makes
pointer from integer without a cast
drivers/scsi/sata_svw.c:128: warning: passing arg 2 of `writew' makes
pointer from integer without a cast
drivers/scsi/sata_svw.c:132: warning: passing arg 2 of `writeb' makes
pointer from integer without a cast
drivers/scsi/sata_svw.c:144: warning: passing arg 1 of `readw' makes
pointer from integer without a cast
drivers/scsi/sata_svw.c:145: warning: passing arg 1 of `readw' makes
pointer from integer without a cast
drivers/scsi/sata_svw.c:146: warning: passing arg 1 of `readw' makes
pointer from integer without a cast
drivers/scsi/sata_svw.c:147: warning: passing arg 1 of `readw' makes
pointer from integer without a cast
drivers/scsi/sata_svw.c:148: warning: passing arg 1 of `readw' makes
pointer from integer without a cast
drivers/scsi/sata_svw.c:149: warning: passing arg 1 of `readw' makes
pointer from integer without a cast
drivers/scsi/sata_vsc.c:146: warning: passing arg 2 of `writew' makes
pointer from integer without a cast
drivers/scsi/sata_vsc.c:147: warning: passing arg 2 of `writew' makes
pointer from integer without a cast
drivers/scsi/sata_vsc.c:148: warning: passing arg 2 of `writew' makes
pointer from integer without a cast
drivers/scsi/sata_vsc.c:149: warning: passing arg 2 of `writew' makes
pointer from integer without a cast
drivers/scsi/sata_vsc.c:150: warning: passing arg 2 of `writew' makes
pointer from integer without a cast
drivers/scsi/sata_vsc.c:152: warning: passing arg 2 of `writew' makes
pointer from integer without a cast
drivers/scsi/sata_vsc.c:153: warning: passing arg 2 of `writew' makes
pointer from integer without a cast
drivers/scsi/sata_vsc.c:154: warning: passing arg 2 of `writew' makes
pointer from integer without a cast
drivers/scsi/sata_vsc.c:155: warning: passing arg 2 of `writew' makes
pointer from integer without a cast
drivers/scsi/sata_vsc.c:156: warning: passing arg 2 of `writew' makes
pointer from integer without a cast
drivers/scsi/sata_vsc.c:160: warning: passing arg 2 of `writeb' makes
pointer from integer without a cast
drivers/scsi/sata_vsc.c:172: warning: passing arg 1 of `readw' makes
pointer from integer without a cast
drivers/scsi/sata_vsc.c:173: warning: passing arg 1 of `readw' makes
pointer from integer without a cast
drivers/scsi/sata_vsc.c:174: warning: passing arg 1 of `readw' makes
pointer from integer without a cast
drivers/scsi/sata_vsc.c:175: warning: passing arg 1 of `readw' makes
pointer from integer without a cast
drivers/scsi/sata_vsc.c:176: warning: passing arg 1 of `readw' makes
pointer from integer without a cast
drivers/scsi/sata_vsc.c:177: warning: passing arg 1 of `readw' makes
pointer from integer without a cast
drivers/scsi/sata_vsc.c:310: warning: passing arg 2 of `writel' makes
pointer from integer without a cast
drivers/scsi/sata_vsc.c:311: warning: passing arg 2 of `writel' makes
pointer from integer without a cast
drivers/scsi/scsi_scan.c:445: warning: 'result' might be used
uninitialized in this function
drivers/scsi/ultrastor.c:302: warning: matching constraint does not
allow a register
drivers/usb/gadget/dummy_hcd.c:521: warning: cast from pointer to
integer of different size
drivers/usb/usbfs2/inode.c:348: warning: unused variable `ep_obj'
drivers/usb/usbfs2/inode.c:356: warning: unused variable `ep_obj'
drivers/video/aty/atyfb_base.c:2223: warning: unused variable `pll_ref_div'
drivers/video/aty/atyfb_base.c:531: warning: 'ram_dram' defined but not used
drivers/video/aty/atyfb_base.c:532: warning: 'ram_resv' defined but not used
drivers/video/radeonfb.c:670: warning: 'nomtrr' defined but not used
drivers/video/sis/osdef.h:111:2: warning: #warning Neither
CONFIG_FB_SIS_300 nor CONFIG_FB_SIS_315 is set
drivers/video/sis/osdef.h:112:2: warning: #warning sisfb will not work!
drivers/video/sis/sis_main.c:4296: warning: 'sisfb_post_map_vram'
defined but not used
drivers/w1/w1_netlink.c:78:2: warning: #warning Netlink support is
disabled. Please compile with NET support enabled.
fs/coda/sysctl.c:151: warning: 'coda_cache_inv_stats_get_info' defined
but not used
fs/coda/sysctl.c:196: warning: 'fs_table' defined but not used
fs/coda/sysctl.c:34: warning: 'fs_table_header' defined but not used
fs/coda/sysctl.c:90: warning: 'coda_vfs_stats_get_info' defined but not used
fs/nfsd/nfs4callback.c:475: warning: unused variable `addr'
fs/ocfs2/dlmglue.c:2036: warning: passing arg 5 of
`debugfs_create_file' discards qualifiers from pointer target type
fs/partitions/acorn.c:122: warning: 'linux_partition' defined but not used
fs/partitions/acorn.c:32: warning: 'adfs_partition' defined but not used
fs/partitions/acorn.c:72: warning: 'riscix_partition' defined but not used
include/asm-generic/bitops/hweight.h:6: warning: 'hweight32' declared
inline after being called
include/asm-generic/bitops/hweight.h:6: warning: previous declaration
of 'hweight32' was here
include/asm-i386/mach-default/mach_apic.h:26: warning: function
declaration isn't a prototype
include/asm-i386/mach-default/mach_apic.h:27: warning: implicit
declaration of function `physid_isset'
include/asm-i386/mach-default/mach_apic.h:46: warning: implicit
declaration of function `apic_write_around'
include/asm-i386/mach-default/mach_apic.h:47: warning: implicit
declaration of function `apic_read'
include/asm-i386/mach-default/mach_apic.h:48: warning: implicit
declaration of function `SET_APIC_LOGICAL_ID'
include/asm-i386/mach-default/mach_apic.h:53: warning: function
declaration isn't a prototype
include/asm-i386/mach-default/mach_apic.h:53: warning: return type
defaults to `int'
include/asm-i386/mach-default/mach_apic.h:81: warning: implicit
declaration of function `get_physical_broadcast'
include/asm-i386/mach-default/mach_apic.h:88: warning: return type
defaults to `int'
include/asm-i386/mach-default/mach_apic.h:89: warning: implicit
declaration of function `physid_mask_of_physid'
include/asm-i386/mach-default/mach_apic.h:93: warning: "struct
mpc_config_processor" declared inside parameter list
include/asm-i386/mach-default/mach_apic.h:93: warning: "struct
mpc_config_translation" declared inside parameter list
include/asm-i386/mach-default/mach_apic.h:93: warning: its scope is
only this definition or declaration, which is probably not what you
want
include/linux/mca-legacy.h:12:2: warning: #warning "MCA legacy -
please move your driver to the new sysfs api"
include/linux/memory_hotplug.h:53: warning: "struct page" declared
inside parameter list
include/linux/memory_hotplug.h:53: warning: "struct page" declared
inside parameter list  CC      drivers/net/ixgb/ixgb_main.o
include/linux/memory_hotplug.h:53: warning: "struct page" declared
inside parameter listIn file included from include/linux/mmzone.h:324,
include/linux/memory_hotplug.h:53: warning: its scope is only this
definition or declaration, which is probably not what you want
include/linux/memory_hotplug.h:53: warning: its scope is only this
definition or declaration, which is probably not what you wantIn file
included from include/linux/mmzone.h:324,
include/linux/memory_hotplug.h:55: warning: "struct page" declared
inside parameter list
include/linux/memory_hotplug.h:55: warning: "struct page" declared
inside parameter list  CC [M]  drivers/usb/serial/kl5kusb105.o
include/linux/memory_hotplug.h:55: warning: "struct page" declared
inside parameter listIn file included from include/linux/mmzone.h:324,
kernel/intermodule.c:178: warning: `inter_module_register' is
deprecated (declared at kernel/intermodule.c:38)
kernel/intermodule.c:179: warning: `inter_module_unregister' is
deprecated (declared at kernel/intermodule.c:78)
kernel/intermodule.c:181: warning: `inter_module_put' is deprecated
(declared at kernel/intermodule.c:159)
kernel/power/pm.c:241: warning: `pm_register' is deprecated (declared
at kernel/power/pm.c:64)
kernel/power/pm.c:242: warning: `pm_unregister_all' is deprecated
(declared at kernel/power/pm.c:97)
kernel/power/pm.c:243: warning: `pm_send_all' is deprecated (declared
at kernel/power/pm.c:216)
kernel/profile.c:223: warning: 'profile_flip_buffers' defined but not used
kernel/profile.c:246: warning: 'profile_discard_flip_buffers' defined
but not used
kernel/profile.c:304: warning: 'profile_cpu_callback' defined but not used
mm/page_alloc.c:2077: warning: unused variable `pgdat'
mm/shmem.c:879: warning: 'shmem_parse_mpol' defined but not used
mm/vmscan.c:392: warning: unused variable `swap'
net/802/fc.c:87: warning: unused variable `fch'
net/ipv4/ipconfig.c:145: warning: 'ic_nameservers' defined but not used
net/ipv6/netfilter/ip6_queue.c:624: warning: 'ipq_get_info' defined but not used
net/ipv6/route.c:2243: warning: unused variable `p'
net/ipv6/tcp_ipv6.c:1392: warning: 'get_openreq6' defined but not used
net/ipv6/tcp_ipv6.c:1422: warning: 'get_tcp6_sock' defined but not used
net/ipv6/tcp_ipv6.c:1477: warning: 'get_timewait6_sock' defined but not used
net/irda/ircomm/ircomm_tty.c:1250: warning: 'ircomm_tty_line_info'
defined but not used
net/irda/irlan/irlan_eth.c:303: warning: unused variable `in_dev'
net/rose/rose_dev.c:60: warning: unused variable `stats'
net/rose/rose_dev.c:61: warning: unused variable `bp'
net/rose/rose_dev.c:62: warning: unused variable `skbn'
net/rxrpc/main.c:83: warning: label `error_proc' defined but not used
net/sched/sch_api.c:1154: warning: 'psched_us_per_tick' defined but not used
net/sched/sch_api.c:1155: warning: 'psched_tick_per_us' defined but not used
sound/isa/wavefront/wavefront.c:43: warning: 'isapnp' defined but not used
sound/oss/ad1848.c:2866: warning: 'id_table' defined but not used
sound/oss/cmpci.c:3044: warning: unused variable `timeout'
sound/oss/cmpci.c:3045: warning: unused variable `ports'
sound/oss/emu10k1/cardwi.c:310: warning: ignoring return value of
`__copy_to_user', declared with attribute warn_unused_result
sound/oss/emu10k1/cardwi.c:319: warning: ignoring return value of
`__copy_to_user', declared with attribute warn_unused_result
sound/oss/emu10k1/passthrough.c:165: warning: ignoring return value of
`copy_from_user', declared with attribute warn_unused_result
sound/oss/emu10k1/passthrough.c:170: warning: ignoring return value of
`copy_from_user', declared with attribute warn_unused_result
sound/oss/emu10k1/passthrough.c:181: warning: ignoring return value of
`copy_from_user', declared with attribute warn_unused_result
sound/oss/emu10k1/passthrough.c:196: warning: ignoring return value of
`copy_from_user', declared with attribute warn_unused_result
sound/oss/esssolo1.c:236:5: warning: "SUPPORT_JOYSTICK" is not defined
sound/oss/pss.c:681: warning: `check_region' is deprecated (declared
at include/linux/ioport.h:124)
sound/oss/sonicvibes.c:421: warning: static declaration of 'hweight32'
follows non-static declaration
sound/pci/pcxhr/pcxhr.c:460: warning: cast to pointer from integer of
different size


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
