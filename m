Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310917AbSDITCC>; Tue, 9 Apr 2002 15:02:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310953AbSDITCB>; Tue, 9 Apr 2002 15:02:01 -0400
Received: from h218-19.afara.com ([63.113.218.19]:30761 "EHLO afara.com")
	by vger.kernel.org with ESMTP id <S310917AbSDITBz>;
	Tue, 9 Apr 2002 15:01:55 -0400
Subject: Re: [kbuild-devel] Re: Announce: Kernel Build for 2.5, Release 2.0
	is available
From: Thomas Duffy <Thomas.Duffy.99@alumni.brown.edu>
To: Keith Owens <kaos@ocs.com.au>
Cc: kbuild-devel@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <29447.1018357715@ocs3.intra.ocs.com.au>
Content-Type: multipart/mixed; boundary="=-GDybNkNxB4CHRzavqUfK"
X-Mailer: Ximian Evolution 1.0.3.99 
Date: 09 Apr 2002 12:00:55 -0700
Message-Id: <1018378855.6436.36.camel@tduffy-lnx.afara.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GDybNkNxB4CHRzavqUfK
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2002-04-09 at 06:08, Keith Owens wrote:

> Other architecture maintainers can use core-3 and common-2.4.18-2 as a
> starting point for porting this release of kbuild 2.5 to their
> architecture.  The existing arch patches from Release 1.12 are a good
> starting point, ia64 was almost unchanged from Release 1.12 to 2.0.
> 
> I have not tested any of the kbuild 2.5 code on big endian machines.
> It should work as is but it would be nice to have it confirmed.

Ok, with core-3, now kbuild 2.5 v2.0 works on sparc64.  There was one
typo in one sparc64 Makefile.in from 1.12.  Attached is the patch to fix
this.

Also attached is the full kbuild 2.0 patch for sparc64 2.4.18 tree.

-- 
He who receives an idea from me, receives instruction himself without
lessening mine; as he who lights his taper at mine, receives light
without darkening me.                      -- Thomas Jefferson

--=-GDybNkNxB4CHRzavqUfK
Content-Disposition: attachment; filename=kbuild-2.5-2.4.18-sparc64-fixes4.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=kbuild-2.5-2.4.18-sparc64-fixes4.patch;
	charset=ISO-8859-1

--- linux_kbuild/arch/sparc64/lib/Makefile.in
+++ linux_kbuild/arch/sparc64/lib/Makefile.in
@@ -13,4 +13,4 @@
 select(lib.a)
=20
 uses_asm_offsets(VISsave.o VIScopy.o VIScsum.o blockops.o checksum.o
-	U3copy_from_user.o U3copt_to_user.o U3copy_in_user.o U3memcpy.o)
+	U3copy_from_user.o U3copy_to_user.o U3copy_in_user.o U3memcpy.o)

--=-GDybNkNxB4CHRzavqUfK
Content-Disposition: attachment; filename=kbuild-2.5-sparc64-2.4.18-1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=kbuild-2.5-sparc64-2.4.18-1; charset=ISO-8859-1

diff -Nur linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/arch/sparc64/Makefi=
le.defs.config linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/arch=
/sparc64/Makefile.defs.config
--- linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/arch/sparc64/Makefile.def=
s.config	Wed Dec 31 16:00:00 1969
+++ linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/arch/sparc64/Ma=
kefile.defs.config	Tue Apr  9 11:33:35 2002
@@ -0,0 +1,19 @@
+#=20
+# arch/$(ARCH)/Makefile.defs.config
+#
+# This file is included by the global makefile so that you can add your ow=
n
+# architecture-specific flags.  It should only contain variable settings,
+# any dependencies should be in arch/$(ARCH)/Makefile.in
+#=20
+# This file contains only values that depend on the config.
+#
+# Do not use ifdef/ifndef, CONFIG_xxx can be defined as 'n'.
+# ifneq ($(subst n,,$(CONFIG_xxx)),) is equivalent to the old
+# ifdef CONFIG_xxx but is CML2 compatible.
+#
+
+# Uncomment this if you are doing kgdb source level debugging of the kerne=
l to
+# get the proper debugging information.
+# FIXME: There should be a config option to control this.  KAO
+
+#CFLAGS		+=3D -g
diff -Nur linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/arch/sparc64/Makefi=
le.defs.noconfig linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/ar=
ch/sparc64/Makefile.defs.noconfig
--- linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/arch/sparc64/Makefile.def=
s.noconfig	Wed Dec 31 16:00:00 1969
+++ linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/arch/sparc64/Ma=
kefile.defs.noconfig	Tue Apr  9 11:33:35 2002
@@ -0,0 +1,53 @@
+#
+# arch/$(ARCH)/Makefile.defs.noconfig.
+#
+# This file is included by the top level makefile so that you can add your=
 own
+# architecture-specific flags.  It should only contain variable settings,
+# any dependencies should be in arch/$(ARCH)/Makefile.in
+#
+# This file contains only values that do not depend on the config.
+#
+# Note: When this is included by the top level Makefile, not all CFLAGS ha=
ve been
+#       set.  Some CFLAGS cannot be set until after CROSS_COMPILE is stabl=
e, in
+#       particular CC still scans user space includes at this point.
+
+CFLAGS			+=3D -pipe -mno-fpu -ffixed-g4 -fcall-used-g5 -fcall-used-g7 -Wno=
-sign-compare
+boot_ldflags		:=3D $(filter-out -r,$(LDFLAGS))
+
+arch_linkflags		:=3D -T arch/$(ARCH)/vmlinux.lds.i
+arch_head		:=3D arch/$(ARCH)/kernel/head.o arch/$(ARCH)/kernel/init_task.o
+arch_libs		:=3D arch/$(ARCH)/lib arch/$(ARCH)/prom
+arch_drivers_subdirs	:=3D
+
+export boot_ldflags arch_linkflags arch_head arch_libs arch_drivers_subdir=
s
+
+# Generally, most sparc64 kernels are compiled with a special compiler
+# (egcs64), and not the userspace compiler.
+CC	:=3D $(shell if gcc -m64 -S -o /dev/null -xc /dev/null >/dev/null 2>&1;=
 then echo gcc; else echo sparc64-linux-gcc; fi )
+
+new_gcc		:=3D $(shell if $(CC) -m64 -mcmodel=3Dmedlow -S -o /dev/null -xc =
/dev/null >/dev/null 2>&1; then echo y; else echo n; fi; )
+new_gas		:=3D $(shell if $(LD) -V 2>&1 | grep 'elf64_sparc' > /dev/null; t=
hen echo y; else echo n; fi)
+undeclared_regs	:=3D $(shell if $(CC) -c -x assembler /dev/null -Wa,--help=
 | grep undeclared-regs > /dev/null; then echo y; else echo n; fi; )
+
+ifeq ($(new_gas),y)
+  AFLAGS	+=3D -Wa,-64
+  LDFLAGS	+=3D -m elf64_sparc
+else
+  AS		:=3D $(CROSS_COMPILE)sparc64-linux-as
+  LD		:=3D $(CROSS_COMPILE)sparc64-linux-ld
+  NM		:=3D $(CROSS_COMPILE)sparc64-linux-nm
+  AR		:=3D $(CROSS_COMPILE)sparc64-linux-ar
+  RANLIB	:=3D $(CROSS_COMPILE)sparc64-linux-ranlib
+endif
+
+ifeq ($(new_gcc),y)
+  CFLAGS	+=3D -m64 -mcpu=3Dultrasparc -mcmodel=3Dmedlow
+  AFLAGS	+=3D -m64 -mcpu=3Dultrasparc
+else
+  CFLAGS	+=3D -mtune=3Dultrasparc -mmedlow
+endif
+
+ifeq ($(undeclared_regs),y)
+  AFLAGS	+=3D -Wa,--undeclared-regs
+  CFLAGS	+=3D -Wa,--undeclared-regs
+endif
diff -Nur linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/arch/sparc64/Makefi=
le.in linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/arch/sparc64/=
Makefile.in
--- linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/arch/sparc64/Makefile.in	=
Wed Dec 31 16:00:00 1969
+++ linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/arch/sparc64/Ma=
kefile.in	Tue Apr  9 11:33:35 2002
@@ -0,0 +1,47 @@
+#
+# Architecture specific dependencies.
+#
+
+link_subdirs(kernel mm solaris math-emu boot)
+
+extra_aflags(vmlinux.lds.i -Usparc -U$(ARCH) -C -P)
+
+# Convert raw asm offsets into something that can be included as
+# assembler definitions.  It converts
+#   -> symbol $value source
+# into
+#   symbol =3D value /* 0xvalue source */
+
+user_command(tmp_asm-offsets.h
+	($(objfile asm-offsets.s))
+	(set -e;
+	  (echo "#ifndef __ASM_OFFSETS_H__";
+	   echo "#define __ASM_OFFSETS_H__";
+	   echo "/*";
+	   echo " * DO NOT MODIFY";
+	   echo " *";
+	   echo " * This file was generated by arch/$(ARCH)/Makefile.in.";
+	   echo " *";
+	   echo " */";
+	   echo "";
+	   awk "/^->\$$/{printf(\"\\n\");}
+	     /^-> /{
+	       sym =3D \$$2;
+	       val =3D \$$3;
+	       sub(/^\\\$$/, \"\", val);
+	       \$$1 =3D \"\";
+	       \$$2 =3D \"\";
+	       \$$3 =3D \"\";
+	       printf(\"#define %-24s 0x%04x\\t/* %s */\\n\",
+			sym, val, \$$0)
+	     }";
+	   echo "";
+	   echo "#endif";
+	  ) < $< > $@;
+	)
+	()
+	)
+
+update_if_changed(asm-offsets.h)
+
+CLEAN +=3D $(objfile asm-offsets.s)
diff -Nur linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/arch/sparc64/asm-of=
fsets.c linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/arch/sparc6=
4/asm-offsets.c
--- linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/arch/sparc64/asm-offsets.=
c	Wed Dec 31 16:00:00 1969
+++ linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/arch/sparc64/as=
m-offsets.c	Tue Apr  9 11:33:35 2002
@@ -0,0 +1,64 @@
+/*
+ * Generate definitions needed by assembly language modules.
+ * This code generates raw asm output which is post-processed to extract
+ * and format the required data.
+ */
+
+#include <linux/types.h>
+#include <linux/stddef.h>
+#include <linux/sched.h>
+
+/* Use marker if you need to separate the values later */
+
+#define DEFINE(sym, val, marker) \
+  asm volatile("\n-> " #sym " %0 " #val " " #marker : : "i" (val))
+
+#define BLANK() asm volatile("\n->" : : )
+
+int
+main(void)
+{
+  DEFINE(AOFF_mm_context,		offsetof(struct mm_struct, context),);
+  BLANK();
+
+  DEFINE(ASIZ_task,			sizeof(struct task_struct),);
+  DEFINE(AOFF_task_blocked,		offsetof(struct task_struct, blocked),);
+  DEFINE(AOFF_task_egid,		offsetof(struct task_struct, egid),);
+  DEFINE(ASIZ_task_egid,		sizeof(((struct task_struct *)NULL)->egid),);
+  DEFINE(AOFF_task_euid,		offsetof(struct task_struct, euid),);
+  DEFINE(ASIZ_task_euid,		sizeof(((struct task_struct *)NULL)->euid),);
+  DEFINE(AOFF_task_flags,		offsetof(struct task_struct, flags),);
+  DEFINE(AOFF_task_fpregs,		(sizeof(struct task_struct) + (64 - 1)) & ~(64=
 - 1),);
+  DEFINE(AOFF_task_gid,			offsetof(struct task_struct, gid),);
+  DEFINE(ASIZ_task_gid,			sizeof(((struct task_struct *)NULL)->gid),);
+  DEFINE(AOFF_task_need_resched,	offsetof(struct task_struct, need_resched=
),);
+  DEFINE(AOFF_task_personality,		offsetof(struct task_struct, personality)=
,);
+  DEFINE(ASIZ_task_personality,		sizeof(((struct task_struct *)NULL)->pers=
onality),);
+  DEFINE(AOFF_task_pid,			offsetof(struct task_struct, pid),);
+  DEFINE(AOFF_task_p_opptr,		offsetof(struct task_struct, p_opptr),);
+  DEFINE(AOFF_task_processor,		offsetof(struct task_struct, processor),);
+  DEFINE(AOFF_task_ptrace,		offsetof(struct task_struct, ptrace),);
+  DEFINE(AOFF_task_sigpending,		offsetof(struct task_struct, sigpending),)=
;
+  DEFINE(AOFF_task_thread,		offsetof(struct task_struct, thread),);
+  DEFINE(AOFF_task_uid,			offsetof(struct task_struct, uid),);
+  DEFINE(ASIZ_task_uid,			sizeof(((struct task_struct *)NULL)->uid),);
+  BLANK();
+
+  DEFINE(AOFF_thread_current_ds,	offsetof(struct thread_struct, current_ds=
),);
+  DEFINE(AOFF_thread_flags,		offsetof(struct thread_struct, flags),);
+  DEFINE(AOFF_thread_fault_address,	offsetof(struct thread_struct, fault_a=
ddress),);
+  DEFINE(AOFF_thread_fault_code,	offsetof(struct thread_struct, fault_code=
),);
+  DEFINE(AOFF_thread_fpdepth,		offsetof(struct thread_struct, fpdepth),);
+  DEFINE(AOFF_thread_fpsaved,		offsetof(struct thread_struct, fpsaved),);
+  DEFINE(AOFF_thread_gsr,		offsetof(struct thread_struct, gsr),);
+  DEFINE(AOFF_thread_xfsr,		offsetof(struct thread_struct, xfsr),);
+  DEFINE(AOFF_thread_pcr_reg,		offsetof(struct thread_struct, pcr_reg),);
+  DEFINE(AOFF_thread_kernel_cntd0,	offsetof(struct thread_struct, kernel_c=
ntd0),);
+  DEFINE(AOFF_thread_reg_window,	offsetof(struct thread_struct, reg_window=
),);
+  DEFINE(AOFF_thread_rwbuf_stkptrs,	offsetof(struct thread_struct, rwbuf_s=
tkptrs),);
+  DEFINE(AOFF_thread_use_blkcommit,	offsetof(struct thread_struct, use_blk=
commit),);
+  DEFINE(AOFF_thread_utraps,		offsetof(struct thread_struct, utraps),);
+  DEFINE(AOFF_thread_w_saved,		offsetof(struct thread_struct, w_saved),);
+
+  return 0;
+}
diff -Nur linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/arch/sparc64/boot/M=
akefile.in linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/arch/spa=
rc64/boot/Makefile.in
--- linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/arch/sparc64/boot/Makefil=
e.in	Wed Dec 31 16:00:00 1969
+++ linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/arch/sparc64/bo=
ot/Makefile.in	Tue Apr  9 11:33:35 2002
@@ -0,0 +1,13 @@
+#
+# Makefile for sparc64 boot.
+#
+# No tftp support yet, I want to keep the kbuild files as standard as poss=
ible.
+# Architecture special and user special build targets can be handled by AD=
Dn
+# rules, see Documentation/kbuild/kbuild-2.5.txt.  KAO
+#
+# If special targets become part of the Makefile.in files then everything =
must
+# be handled by config rules.  That includes the names of target files suc=
h as
+# root image (use CONFIG_TFTP_NAME), external utility names such as elftoa=
ut
+# (use CONFIG_ELFTOAOUT) etc.  A user must be able to copy a config from o=
ne
+# kernel to another, type 'make oldconfig install' with no other parameter=
s and
+# have the build do exactly the same as before.  KAO
diff -Nur linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/arch/sparc64/boot/c=
onfig.install-2.5 linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/a=
rch/sparc64/boot/config.install-2.5
--- linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/arch/sparc64/boot/config.=
install-2.5	Wed Dec 31 16:00:00 1969
+++ linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/arch/sparc64/bo=
ot/config.install-2.5	Tue Apr  9 11:33:35 2002
@@ -0,0 +1,43 @@
+mainmenu_name "Sparc64 Installation"
+
+choice 'Format to compile kernel in' \
+	"vmlinux	CONFIG_VMLINUX \
+	 vmlinuz	CONFIG_VMLINUZ" vmlinuz
+
+bool 'Use a prefix on install paths' CONFIG_INSTALL_PREFIX
+if [ "$CONFIG_INSTALL_PREFIX" =3D "y" ]; then
+  string '  Prefix for install paths' CONFIG_INSTALL_PREFIX_NAME ""
+fi
+string 'Where to install the kernel' CONFIG_INSTALL_KERNEL_NAME "/lib/modu=
les/KERNELRELEASE/vmlinuz"
+bool 'Install System.map' CONFIG_INSTALL_SYSTEM_MAP
+if [ "$CONFIG_INSTALL_SYSTEM_MAP" =3D "y" ]; then
+  string '  Where to install System.map' CONFIG_INSTALL_SYSTEM_MAP_NAME "/=
lib/modules/KERNELRELEASE/System.map"
+fi
+bool 'Install .config' CONFIG_INSTALL_CONFIG
+if [ "$CONFIG_INSTALL_CONFIG" =3D "y" ]; then
+  string '  Where to install .config' CONFIG_INSTALL_CONFIG_NAME "/lib/mod=
ules/KERNELRELEASE/.config"
+fi
+if [ "$CONFIG_VMLINUX" !=3D "y" ]; then
+  bool '  Install vmlinux for debugging' CONFIG_INSTALL_VMLINUX
+  if [ "$CONFIG_INSTALL_VMLINUX" =3D "y" ]; then
+    string '    Where to install vmlinux' CONFIG_INSTALL_VMLINUX_NAME "/li=
b/modules/KERNELRELEASE/vmlinux"
+  fi
+fi
+bool 'Run a post-install script or command' CONFIG_INSTALL_SCRIPT
+if [ "$CONFIG_INSTALL_SCRIPT" =3D "y" ]; then
+  string '  Post-install script or command name' CONFIG_INSTALL_SCRIPT_NAM=
E ""
+fi
+
+# FIXME: These critical config options should be in arch/$(ARCH)/config.in=
.  For
+# coexistence of kbuild 2.4 and 2.5 it is easier to put them here, move th=
em
+# later.  KAO
+
+# FIXME more: Update to sparc64 critical variables.  KAO
+
+#define_string CONFIG_KBUILD_CRITICAL_ARCH "CONFIG_M386 CONFIG_M486 \
+#	CONFIG_M586 CONFIG_M586TSC CONFIG_M586MMX CONFIG_M686 \
+#	CONFIG_MPENTIUMIII CONFIG_MPENTIUM4 \
+#	CONFIG_MK6 CONFIG_MK7 \
+#	CONFIG_MCRUSOE \
+#	CONFIG_MWINCHIPC6 CONFIG_MWINCHIP2 CONFIG_MWINCHIP3D \
+#	CONFIG_MCYRIXIII"
diff -Nur linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/arch/sparc64/boot/r=
ules-2.5.cml linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/arch/s=
parc64/boot/rules-2.5.cml
--- linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/arch/sparc64/boot/rules-2=
.5.cml	Wed Dec 31 16:00:00 1969
+++ linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/arch/sparc64/bo=
ot/rules-2.5.cml	Tue Apr  9 11:33:35 2002
@@ -0,0 +1,27 @@
+symbols
+kernel_format_sparc64	'The format used for the installed kernel' text
+All kernel builds create vmlinux as an ELF object.  vmlinux may not be
+suitable for loading, either because your bootloader cannot handle ELF
+or the object is too large.  This option selects the format for the
+installed kernel.  If unsure, use vmlinuz.
+.
+VMLINUX_SPARC64 'vmlinux' like VMLINUX_help
+VMLINUZ_SPARC64 'vmlinuz' like VMLINUZ_help
+
+private VMLINUX_SPARC64 VMLINUZ_SPARC64
+
+choices kernel_format_sparc64 # The format that the kernel is to be compil=
ed in
+	VMLINUX_SPARC64 VMLINUZ_SPARC64 default VMLINUZ_SPARC64
+
+# FIXME: These critical config options should be in arch/$(ARCH)/rules.cml=
.  For
+# coexistence of kbuild 2.4 and 2.5 it is easier to put them here, move th=
em
+# later.  KAO
+
+# FIXME: more: Set the real sparc64 critical options.
+
+derive KBUILD_CRITICAL_ARCH_SPARC64 from "???"
+
+menu installation
+	kernel_format_sparc64
+
+unless SPARC64 suppress kernel_format_sparc64
diff -Nur linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/arch/sparc64/kernel=
/Makefile.in linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/arch/s=
parc64/kernel/Makefile.in
--- linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/arch/sparc64/kernel/Makef=
ile.in	Wed Dec 31 16:00:00 1969
+++ linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/arch/sparc64/ke=
rnel/Makefile.in	Tue Apr  9 11:33:35 2002
@@ -0,0 +1,22 @@
+
+expsyms(sparc64_ksyms.o)
+
+select(head.o init_task.o)
+
+select(process.o setup.o cpu.o idprom.o traps.o devices.o auxio.o irq.o pt=
race.o
+       time.o sys_sparc.o signal.o unaligned.o central.o pci.o starfire.o
+       semaphore.o power.o sbus.o iommu_common.o sparc64_ksyms.o chmc.o)
+
+select(CONFIG_PCI			ebus.o isa.o pci_common.o pci_iommu.o
+					pci_psycho.o pci_sabre.o pci_schizo.o)
+select(CONFIG_SMP			smp.o trampoline.o)
+select(CONFIG_SPARC32_COMPAT		sys32.o sys_sparc32.o signal32.o ioctl32.o)
+select(CONFIG_BINFMT_ELF32		binfmt_elf32.o)
+select(CONFIG_BINFMT_AOUT32		binfmt_aout32.o)
+select(CONFIG_SUNOS_EMUL		sys_sunos32.o sunos_ioctl32.o)
+select(CONFIG_Y CONFIG_SOLARIS_EMUL	sys_sunos32.o sunos_ioctl32.o)
+
+uses_asm_offsets(head.o head.o trampoline.o winfixup.o)
+
+# FIXME: ioctl32.c #include "../../../drivers/char/drm" :(.
+extra_cflags(ioctl32.o $(src_includelist /drivers/char/drm))
diff -Nur linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/arch/sparc64/kernel=
/entry.S linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/arch/sparc=
64/kernel/entry.S
--- linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/arch/sparc64/kernel/entry=
.S	Fri Dec 21 09:41:53 2001
+++ linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/arch/sparc64/ke=
rnel/entry.S	Tue Apr  9 11:33:35 2002
@@ -21,6 +21,13 @@
 #include <asm/visasm.h>
 #include <asm/estate.h>
=20
+#include <linux/config.h>	/* Remove this line after kbuild 2.5 is in */
+#ifdef CONFIG_KBUILD_2_5	/* Remove this line after kbuild 2.5 is in */
+#include <asm-offsets.h>	/* This is all that is required for kbuild 2.5 */
+#else				/* Remove this line after kbuild 2.5 is in */
+#include <asm/asm_offsets.h>	/* Remove this line after kbuild 2.5 is in */
+#endif				/* Remove this line after kbuild 2.5 is in */
+
 /* #define SYSCALL_TRACING	1 */
=20
 #define curptr      g6
diff -Nur linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/arch/sparc64/kernel=
/etrap.S linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/arch/sparc=
64/kernel/etrap.S
--- linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/arch/sparc64/kernel/etrap=
.S	Thu Sep 20 14:11:57 2001
+++ linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/arch/sparc64/ke=
rnel/etrap.S	Tue Apr  9 11:33:35 2002
@@ -13,6 +13,13 @@
 #include <asm/head.h>
 #include <asm/processor.h>
=20
+#include <linux/config.h>	/* Remove this line after kbuild 2.5 is in */
+#ifdef CONFIG_KBUILD_2_5	/* Remove this line after kbuild 2.5 is in */
+#include <asm-offsets.h>	/* This is all that is required for kbuild 2.5 */
+#else				/* Remove this line after kbuild 2.5 is in */
+#include <asm/asm_offsets.h>	/* Remove this line after kbuild 2.5 is in */
+#endif				/* Remove this line after kbuild 2.5 is in */
+
 #define		TASK_REGOFF		(THREAD_SIZE-TRACEREG_SZ-REGWIN_SZ)
 #define		ETRAP_PSTATE1		(PSTATE_RMO | PSTATE_PRIV)
 #define		ETRAP_PSTATE2		(PSTATE_RMO | PSTATE_PEF | PSTATE_PRIV | PSTATE_IE=
)
diff -Nur linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/arch/sparc64/kernel=
/head.S linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/arch/sparc6=
4/kernel/head.S
--- linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/arch/sparc64/kernel/head.=
S	Fri Dec 21 09:41:53 2001
+++ linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/arch/sparc64/ke=
rnel/head.S	Tue Apr  9 11:33:35 2002
@@ -10,7 +10,6 @@
 #include <linux/config.h>
 #include <linux/version.h>
 #include <linux/errno.h>
-#include <asm/asm_offsets.h>
 #include <asm/asi.h>
 #include <asm/pstate.h>
 #include <asm/ptrace.h>
@@ -25,6 +24,13 @@
 #include <asm/dcu.h>
 #include <asm/head.h>
 #include <asm/ttable.h>
+
+#include <linux/config.h>	/* Remove this line after kbuild 2.5 is in */
+#ifdef CONFIG_KBUILD_2_5	/* Remove this line after kbuild 2.5 is in */
+#include <asm-offsets.h>	/* This is all that is required for kbuild 2.5 */
+#else				/* Remove this line after kbuild 2.5 is in */
+#include <asm/asm_offsets.h>	/* Remove this line after kbuild 2.5 is in */
+#endif				/* Remove this line after kbuild 2.5 is in */
 =09
 /* This section from from _start to sparc64_boot_end should fit into
  * 0x0000.0000.0040.4000 to 0x0000.0000.0040.8000 and will be sharing spac=
e
diff -Nur linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/arch/sparc64/kernel=
/rtrap.S linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/arch/sparc=
64/kernel/rtrap.S
--- linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/arch/sparc64/kernel/rtrap=
.S	Mon Feb 25 11:37:56 2002
+++ linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/arch/sparc64/ke=
rnel/rtrap.S	Tue Apr  9 11:33:35 2002
@@ -13,6 +13,13 @@
 #include <asm/visasm.h>
 #include <asm/processor.h>
=20
+#include <linux/config.h>	/* Remove this line after kbuild 2.5 is in */
+#ifdef CONFIG_KBUILD_2_5	/* Remove this line after kbuild 2.5 is in */
+#include <asm-offsets.h>	/* This is all that is required for kbuild 2.5 */
+#else				/* Remove this line after kbuild 2.5 is in */
+#include <asm/asm_offsets.h>	/* Remove this line after kbuild 2.5 is in */
+#endif				/* Remove this line after kbuild 2.5 is in */
+
 #define		PTREGS_OFF		(STACK_BIAS + REGWIN_SZ)
 #define		RTRAP_PSTATE		(PSTATE_RMO|PSTATE_PEF|PSTATE_PRIV|PSTATE_IE)
 #define		RTRAP_PSTATE_IRQOFF	(PSTATE_RMO|PSTATE_PEF|PSTATE_PRIV)
diff -Nur linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/arch/sparc64/kernel=
/trampoline.S linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/arch/=
sparc64/kernel/trampoline.S
--- linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/arch/sparc64/kernel/tramp=
oline.S	Fri Dec 21 09:41:53 2001
+++ linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/arch/sparc64/ke=
rnel/trampoline.S	Tue Apr  9 11:33:35 2002
@@ -14,7 +14,13 @@
 #include <asm/pgtable.h>
 #include <asm/spitfire.h>
 #include <asm/processor.h>
-#include <asm/asm_offsets.h>
+
+#include <linux/config.h>	/* Remove this line after kbuild 2.5 is in */
+#ifdef CONFIG_KBUILD_2_5	/* Remove this line after kbuild 2.5 is in */
+#include <asm-offsets.h>	/* This is all that is required for kbuild 2.5 */
+#else				/* Remove this line after kbuild 2.5 is in */
+#include <asm/asm_offsets.h>	/* Remove this line after kbuild 2.5 is in */
+#endif				/* Remove this line after kbuild 2.5 is in */
=20
 	.data
 	.align	8
diff -Nur linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/arch/sparc64/kernel=
/winfixup.S linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/arch/sp=
arc64/kernel/winfixup.S
--- linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/arch/sparc64/kernel/winfi=
xup.S	Mon Mar 27 10:35:56 2000
+++ linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/arch/sparc64/ke=
rnel/winfixup.S	Tue Apr  9 11:33:35 2002
@@ -11,7 +11,13 @@
 #include <asm/ptrace.h>
 #include <asm/processor.h>
 #include <asm/spitfire.h>
-#include <asm/asm_offsets.h>
+
+#include <linux/config.h>	/* Remove this line after kbuild 2.5 is in */
+#ifdef CONFIG_KBUILD_2_5	/* Remove this line after kbuild 2.5 is in */
+#include <asm-offsets.h>	/* This is all that is required for kbuild 2.5 */
+#else				/* Remove this line after kbuild 2.5 is in */
+#include <asm/asm_offsets.h>	/* Remove this line after kbuild 2.5 is in */
+#endif				/* Remove this line after kbuild 2.5 is in */
=20
 	.text
 	.align	32
diff -Nur linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/arch/sparc64/lib/Ma=
kefile.in linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/arch/spar=
c64/lib/Makefile.in
--- linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/arch/sparc64/lib/Makefile=
.in	Wed Dec 31 16:00:00 1969
+++ linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/arch/sparc64/li=
b/Makefile.in	Tue Apr  9 11:34:55 2002
@@ -0,0 +1,14 @@
+#
+# Makefile for sparc64 library files.
+#
+
+objlink(lib.a PeeCeeI.o blockops.o debuglocks.o strlen.o strncmp.o memscan=
.o
+	strncpy_from_user.o strlen_user.o memcmp.o checksum.o VIScopy.o
+	VISbzero.o VISmemset.o VIScsum.o VIScsumcopy.o VIScsumcopyusr.o
+	VISsave.o atomic.o rwlock.o bitops.o dec_and_lock.o U3memcpy.o
+	U3copy_from_user.o U3copy_to_user.o U3copy_in_user.o)
+
+select(lib.a)
+
+uses_asm_offsets(VISsave.o VIScopy.o VIScsum.o blockops.o checksum.o
+	U3copy_from_user.o U3copy_to_user.o U3copy_in_user.o U3memcpy.o)
diff -Nur linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/arch/sparc64/lib/VI=
Scopy.S linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/arch/sparc6=
4/lib/VIScopy.S
--- linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/arch/sparc64/lib/VIScopy.=
S	Mon Oct  1 09:19:56 2001
+++ linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/arch/sparc64/li=
b/VIScopy.S	Tue Apr  9 11:33:35 2002
@@ -26,7 +26,13 @@
 #ifdef __KERNEL__
=20
 #include <asm/visasm.h>
-#include <asm/asm_offsets.h>
+
+#include <linux/config.h>	/* Remove this line after kbuild 2.5 is in */
+#ifdef CONFIG_KBUILD_2_5	/* Remove this line after kbuild 2.5 is in */
+#include <asm-offsets.h>	/* This is all that is required for kbuild 2.5 */
+#else				/* Remove this line after kbuild 2.5 is in */
+#include <asm/asm_offsets.h>	/* Remove this line after kbuild 2.5 is in */
+#endif				/* Remove this line after kbuild 2.5 is in */
=20
 #define FPU_CLEAN_RETL								\
 	ldub		[%g6 + AOFF_task_thread + AOFF_thread_current_ds], %o1;	\
diff -Nur linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/arch/sparc64/lib/VI=
Scsum.S linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/arch/sparc6=
4/lib/VIScsum.S
--- linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/arch/sparc64/lib/VIScsum.=
S	Mon Feb 21 16:32:27 2000
+++ linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/arch/sparc64/li=
b/VIScsum.S	Tue Apr  9 11:33:35 2002
@@ -28,7 +28,14 @@
 #include <asm/head.h>
 #include <asm/asi.h>
 #include <asm/visasm.h>
-#include <asm/asm_offsets.h>
+
+#include <linux/config.h>	/* Remove this line after kbuild 2.5 is in */
+#ifdef CONFIG_KBUILD_2_5	/* Remove this line after kbuild 2.5 is in */
+#include <asm-offsets.h>	/* This is all that is required for kbuild 2.5 */
+#else				/* Remove this line after kbuild 2.5 is in */
+#include <asm/asm_offsets.h>	/* Remove this line after kbuild 2.5 is in */
+#endif				/* Remove this line after kbuild 2.5 is in */
+
 #else
 #define ASI_BLK_P	0xf0
 #define FRPS_FEF	0x04
diff -Nur linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/arch/sparc64/lib/VI=
Ssave.S linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/arch/sparc6=
4/lib/VISsave.S
--- linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/arch/sparc64/lib/VISsave.=
S	Sun Mar 25 18:14:21 2001
+++ linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/arch/sparc64/li=
b/VISsave.S	Tue Apr  9 11:34:24 2002
@@ -11,6 +11,14 @@
 #include <asm/ptrace.h>
 #include <asm/visasm.h>
=20
+#include <linux/config.h>	/* Remove this line after kbuild 2.5 is in */
+#ifdef CONFIG_KBUILD_2_5	/* Remove this line after kbuild 2.5 is in */
+#include <asm-offsets.h>	/* This is all that is required for kbuild 2.5 */
+#else				/* Remove this line after kbuild 2.5 is in */
+#define AOFF_task_fpregs       (((ASIZ_task) + (64 - 1)) & ~(64 - 1))
+#include <asm/asm_offsets.h>	/* Remove this line after kbuild 2.5 is in */
+#endif				/* Remove this line after kbuild 2.5 is in */
+
 	.text
 	.globl		VISenter, VISenterhalf
=20
diff -Nur linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/arch/sparc64/lib/bl=
ockops.S linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/arch/sparc=
64/lib/blockops.S
--- linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/arch/sparc64/lib/blockops=
.S	Fri Dec 21 09:41:53 2001
+++ linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/arch/sparc64/li=
b/blockops.S	Tue Apr  9 11:33:35 2002
@@ -9,7 +9,13 @@
 #include <asm/visasm.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
-#include <asm/asm_offsets.h>
+
+#include <linux/config.h>	/* Remove this line after kbuild 2.5 is in */
+#ifdef CONFIG_KBUILD_2_5	/* Remove this line after kbuild 2.5 is in */
+#include <asm-offsets.h>	/* This is all that is required for kbuild 2.5 */
+#else				/* Remove this line after kbuild 2.5 is in */
+#include <asm/asm_offsets.h>	/* Remove this line after kbuild 2.5 is in */
+#endif				/* Remove this line after kbuild 2.5 is in */
=20
 #define TOUCH(reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7)	\
 	fmovd	%reg0, %f48; 	fmovd	%reg1, %f50;		\
diff -Nur linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/arch/sparc64/lib/ch=
ecksum.S linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/arch/sparc=
64/lib/checksum.S
--- linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/arch/sparc64/lib/checksum=
.S	Fri Jan 21 18:22:54 2000
+++ linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/arch/sparc64/li=
b/checksum.S	Tue Apr  9 11:33:35 2002
@@ -18,7 +18,13 @@
 #include <asm/ptrace.h>
 #include <asm/asi.h>
 #include <asm/page.h>
-#include <asm/asm_offsets.h>
+
+#include <linux/config.h>	/* Remove this line after kbuild 2.5 is in */
+#ifdef CONFIG_KBUILD_2_5	/* Remove this line after kbuild 2.5 is in */
+#include <asm-offsets.h>	/* This is all that is required for kbuild 2.5 */
+#else				/* Remove this line after kbuild 2.5 is in */
+#include <asm/asm_offsets.h>	/* Remove this line after kbuild 2.5 is in */
+#endif				/* Remove this line after kbuild 2.5 is in */
=20
 	/* The problem with the "add with carry" instructions on Ultra
 	 * are two fold.  Firstly, they cannot pair with jack shit,
diff -Nur linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/arch/sparc64/math-e=
mu/Makefile.in linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/arch=
/sparc64/math-emu/Makefile.in
--- linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/arch/sparc64/math-emu/Mak=
efile.in	Wed Dec 31 16:00:00 1969
+++ linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/arch/sparc64/ma=
th-emu/Makefile.in	Tue Apr  9 11:33:35 2002
@@ -0,0 +1,8 @@
+#
+# Makefile for the sparc64 FPU instruction emulation.
+#
+
+objlink(math-emu.o math.o)
+select(math-emu.o)
+
+extra_cflags_all($(src_includelist /include/math-emu) -w)
diff -Nur linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/arch/sparc64/mm/Mak=
efile.in linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/arch/sparc=
64/mm/Makefile.in
--- linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/arch/sparc64/mm/Makefile.=
in	Wed Dec 31 16:00:00 1969
+++ linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/arch/sparc64/mm=
/Makefile.in	Tue Apr  9 11:33:35 2002
@@ -0,0 +1,8 @@
+#
+# Makefile for the linux sparc64-specific parts of the memory manager.
+#
+
+objlink(mm.o ultra.o fault.o init.o generic.o extable.o modutil.o)
+select(mm.o)
+
+uses_asm_offsets(ultra.o)
diff -Nur linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/arch/sparc64/mm/ult=
ra.S linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/arch/sparc64/m=
m/ultra.S
--- linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/arch/sparc64/mm/ultra.S	F=
ri Dec 21 09:41:53 2001
+++ linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/arch/sparc64/mm=
/ultra.S	Tue Apr  9 11:33:35 2002
@@ -11,6 +11,13 @@
 #include <asm/spitfire.h>
 #include <asm/mmu_context.h>
=20
+#include <linux/config.h>	/* Remove this line after kbuild 2.5 is in */
+#ifdef CONFIG_KBUILD_2_5	/* Remove this line after kbuild 2.5 is in */
+#include <asm-offsets.h>	/* This is all that is required for kbuild 2.5 */
+#else				/* Remove this line after kbuild 2.5 is in */
+#include <asm/asm_offsets.h>	/* Remove this line after kbuild 2.5 is in */
+#endif				/* Remove this line after kbuild 2.5 is in */
+
 	/* Basically, all this madness has to do with the
 	 * fact that Cheetah does not support IMMU flushes
 	 * out of the secondary context.  Someone needs to
diff -Nur linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/arch/sparc64/prom/M=
akefile.in linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/arch/spa=
rc64/prom/Makefile.in
--- linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/arch/sparc64/prom/Makefil=
e.in	Wed Dec 31 16:00:00 1969
+++ linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/arch/sparc64/pr=
om/Makefile.in	Tue Apr  9 11:33:35 2002
@@ -0,0 +1,8 @@
+#
+# Makefile for the Sun Boot PROM interface library under Linux.
+#
+
+objlink(promlib.a bootstr.o devops.o init.o memory.o misc.o tree.o
+	console.o printf.o p1275.o map.o)
+
+select(promlib.a)
diff -Nur linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/arch/sparc64/solari=
s/Makefile.in linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/arch/=
sparc64/solaris/Makefile.in
--- linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/arch/sparc64/solaris/Make=
file.in	Wed Dec 31 16:00:00 1969
+++ linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/arch/sparc64/so=
laris/Makefile.in	Tue Apr  9 11:33:35 2002
@@ -0,0 +1,10 @@
+#
+# Makefile for the linux Solaris binary compatibility.
+#
+
+objlink(solaris.o entry64.o fs.o misc.o signal.o systbl.o socket.o ioctl.o
+	ipc.o socksys.o timod.o)
+
+select(CONFIG_SOLARIS_EMUL solaris.o)
+
+uses_asm_offsets(entry64.o)
diff -Nur linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/arch/sparc64/solari=
s/entry64.S linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/arch/sp=
arc64/solaris/entry64.S
--- linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/arch/sparc64/solaris/entr=
y64.S	Thu Jan 13 12:03:00 2000
+++ linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/arch/sparc64/so=
laris/entry64.S	Tue Apr  9 11:33:35 2002
@@ -17,6 +17,13 @@
 #include <asm/pgtable.h>
 #include <asm/processor.h>
=20
+#include <linux/config.h>	/* Remove this line after kbuild 2.5 is in */
+#ifdef CONFIG_KBUILD_2_5	/* Remove this line after kbuild 2.5 is in */
+#include <asm-offsets.h>	/* This is all that is required for kbuild 2.5 */
+#else				/* Remove this line after kbuild 2.5 is in */
+#include <asm/asm_offsets.h>	/* Remove this line after kbuild 2.5 is in */
+#endif				/* Remove this line after kbuild 2.5 is in */
+
 #include "conv.h"
=20
 #define NR_SYSCALLS	256
diff -Nur linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/arch/sparc64/vmlinu=
x.lds.S linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/arch/sparc6=
4/vmlinux.lds.S
--- linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/arch/sparc64/vmlinux.lds.=
S	Wed Dec 31 16:00:00 1969
+++ linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/arch/sparc64/vm=
linux.lds.S	Tue Apr  9 11:33:35 2002
@@ -0,0 +1,80 @@
+/* ld script to make UltraLinux kernel */
+OUTPUT_FORMAT("elf64-sparc", "elf64-sparc", "elf64-sparc")
+OUTPUT_ARCH(sparc:v9a)
+ENTRY(_start)
+
+SECTIONS
+{
+  swapper_pmd_dir =3D 0x0000000000402000;
+  empty_pg_dir =3D 0x0000000000403000;
+  . =3D 0x4000;
+  .text 0x0000000000404000 :
+  {
+    *(.text)
+    *(.gnu.warning)
+  } =3D0
+  _etext =3D .;
+  PROVIDE (etext =3D .);
+  .rodata    : { *(.rodata) *(.rodata.*) }
+  .rodata1   : { *(.rodata1) }
+  .data    :
+  {
+    *(.data)
+    CONSTRUCTORS
+  }
+  .data1   : { *(.data1) }
+  _edata  =3D  .;
+  PROVIDE (edata =3D .);
+  .fixup   : { *(.fixup) }
+  . =3D ALIGN(16);
+  __start___ex_table =3D .;
+  __ex_table : { *(__ex_table) }
+  __stop___ex_table =3D .;
+  __start___ksymtab =3D .;
+  __ksymtab  : { *(__ksymtab) }
+  __stop___ksymtab =3D .;
+  __kstrtab  : { *(.kstrtab) }
+  __start___kallsyms =3D .;	/* All kernel symbols */
+  __kallsyms : { *(__kallsyms) }
+  __stop___kallsyms =3D .;
+  . =3D ALIGN(8192);
+  __init_begin =3D .;
+  .text.init : { *(.text.init) }
+  .data.init : { *(.data.init) }
+  . =3D ALIGN(16);
+  __setup_start =3D .;
+  .setup_init : { *(.setup.init) }
+  __setup_end =3D .;
+  __initcall_start =3D .;
+  .initcall.init : { *(.initcall.init) }
+  __initcall_end =3D .;
+  . =3D ALIGN(8192);
+  __init_end =3D .;
+  . =3D ALIGN(64);
+  .data.cacheline_aligned : { *(.data.cacheline_aligned) }
+  __bss_start =3D .;
+  .sbss      : { *(.sbss) *(.scommon) }
+  .bss       :
+  {
+   *(.dynbss)
+   *(.bss)
+   *(COMMON)
+  }
+  _end =3D . ;
+  PROVIDE (end =3D .);
+  /* Stabs debugging sections.  */
+  .stab 0 : { *(.stab) }
+  .stabstr 0 : { *(.stabstr) }
+  .stab.excl 0 : { *(.stab.excl) }
+  .stab.exclstr 0 : { *(.stab.exclstr) }
+  .stab.index 0 : { *(.stab.index) }
+  .stab.indexstr 0 : { *(.stab.indexstr) }
+  .comment 0 : { *(.comment) }
+  .debug          0 : { *(.debug) }
+  .debug_srcinfo  0 : { *(.debug_srcinfo) }
+  .debug_aranges  0 : { *(.debug_aranges) }
+  .debug_pubnames 0 : { *(.debug_pubnames) }
+  .debug_sfnames  0 : { *(.debug_sfnames) }
+  .line           0 : { *(.line) }
+  /DISCARD/ : { *(.text.exit) *(.data.exit) *(.exitcall.exit) }
+}
diff -Nur linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/include/asm-sparc64=
/processor.h linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/includ=
e/asm-sparc64/processor.h
--- linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/include/asm-sparc64/proce=
ssor.h	Mon Feb 25 11:38:13 2002
+++ linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/include/asm-spa=
rc64/processor.h	Tue Apr  9 11:34:24 2002
@@ -307,6 +307,10 @@
=20
 #define cpu_relax()	udelay(1 + smp_processor_id())
=20
+#ifdef CONFIG_KBUILD_2_5
+#define AOFF_task_fpregs	((sizeof(struct task_struct) + (64 - 1)) & ~(64 -=
 1))
+#endif
+
 #endif /* __KERNEL__ */
=20
 #endif /* !(__ASSEMBLY__) */
diff -Nur linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/include/asm-sparc64=
/ptrace.h linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/include/a=
sm-sparc64/ptrace.h
--- linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/include/asm-sparc64/ptrac=
e.h	Mon Jan 12 15:15:58 1998
+++ linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/include/asm-spa=
rc64/ptrace.h	Tue Apr  9 11:34:41 2002
@@ -111,7 +111,10 @@
 #define STACKFRAME32_SZ		0x60
 #define REGWIN32_SZ		0x40
=20
+#include <linux/config.h>
+#ifndef CONFIG_KBUILD_2_5
 #include <asm/asm_offsets.h>
+#endif /* CONFIG_KBUILD_2_5 */
 #endif
=20
 #ifdef __KERNEL__
diff -Nur linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/include/asm-sparc64=
/system.h linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/include/a=
sm-sparc64/system.h
--- linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/include/asm-sparc64/syste=
m.h	Fri Dec 21 09:42:03 2001
+++ linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/include/asm-spa=
rc64/system.h	Tue Apr  9 11:34:24 2002
@@ -5,7 +5,9 @@
 #include <linux/config.h>
 #include <asm/ptrace.h>
 #include <asm/processor.h>
+#ifndef CONFIG_KBUILD_2_5
 #include <asm/asm_offsets.h>
+#endif
 #include <asm/visasm.h>
=20
 #ifndef __ASSEMBLY__
diff -Nur linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/include/asm-sparc64=
/ttable.h linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/include/a=
sm-sparc64/ttable.h
--- linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/include/asm-sparc64/ttabl=
e.h	Fri Dec 21 09:42:03 2001
+++ linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/include/asm-spa=
rc64/ttable.h	Tue Apr  9 11:34:24 2002
@@ -3,7 +3,9 @@
 #define _SPARC64_TTABLE_H
=20
 #include <linux/config.h>
+#ifndef CONFIG_KBUILD_2_5
 #include <asm/asm_offsets.h>
+#endif
 #include <asm/utrap.h>
=20
 #define BOOT_KERNEL b sparc64_boot; nop; nop; nop; nop; nop; nop; nop;
diff -Nur linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/include/asm-sparc64=
/visasm.h linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/include/a=
sm-sparc64/visasm.h
--- linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/include/asm-sparc64/visas=
m.h	Thu Apr 26 22:17:26 2001
+++ linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/include/asm-spa=
rc64/visasm.h	Tue Apr  9 11:34:41 2002
@@ -10,8 +10,11 @@
 #include <asm/pstate.h>
 #include <asm/ptrace.h>
=20
-#define AOFF_task_fpregs	(((ASIZ_task) + (64 - 1)) & ~(64 - 1))
-=20
+#include <linux/config.h>
+#ifndef CONFIG_KBUILD_2_5
+#define AOFF_task_fpregs       (((ASIZ_task) + (64 - 1)) & ~(64 - 1))
+#endif
+
 /* Clobbers %o5, %g1, %g2, %g3, %g7, %icc, %xcc */
=20
 #define VISEntry					\
diff -Nur linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/scripts/Makefile-2.=
5 linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/scripts/Makefile-=
2.5
--- linux-2.4.18+kbuild-v2.0+common2+core3+i386-1/scripts/Makefile-2.5	Tue =
Apr  9 11:27:38 2002
+++ linux-2.4.18+kbuild-v2.0+common2+core3+i386-1+sparc64-1/scripts/Makefil=
e-2.5	Tue Apr  9 11:33:35 2002
@@ -736,9 +736,10 @@
 	@( \
 	  echo ""; \
 	  echo "source \"arch/i386/boot/rules-2.5.cml\""; \
+	  echo "source \"arch/sparc64/boot/rules-2.5.cml\""; \
 	  echo ""; \
-	  echo "derive VMLINUX from VMLINUX_X86"; \
-	  echo "derive VMLINUZ from VMLINUZ_X86"; \
+	  echo "derive VMLINUX from VMLINUX_X86 or VMLINUX_SPARC64"; \
+	  echo "derive VMLINUZ from VMLINUZ_X86 or VMLINUZ_SPARC64"; \
 	  echo "derive BZIMAGE from BZIMAGE_X86"; \
 	  echo "derive ZIMAGE from ZIMAGE_X86"; \
 	  echo "derive VMLINUX_SREC from n"; \

--=-GDybNkNxB4CHRzavqUfK--
