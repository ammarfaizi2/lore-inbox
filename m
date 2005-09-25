Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751418AbVIYOMl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbVIYOMl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 10:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbVIYOMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 10:12:41 -0400
Received: from quark.didntduck.org ([69.55.226.66]:41690 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id S1751418AbVIYOMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 10:12:40 -0400
Message-ID: <4336B03E.7050503@didntduck.org>
Date: Sun, 25 Sep 2005 10:12:14 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0.6-5 (X11/20050818)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] CONFIG_IA32
References: <4335DD14.7090909@didntduck.org> <20050925100525.GA14741@infradead.org>
In-Reply-To: <20050925100525.GA14741@infradead.org>
Content-Type: multipart/mixed;
 boundary="------------000400070101080502080800"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000400070101080502080800
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Christoph Hellwig wrote:
> On Sat, Sep 24, 2005 at 07:11:16PM -0400, Brian Gerst wrote:
> 
>>Add CONFIG_IA32 for i386.  This allows selecting options that only apply 
>>to 32-bit systems.
>>
>>(X86 && !X86_64) becomes IA32
>>(X86 ||  X86_64) becomes X86
> 
> 
> Please call it X86_32 or I386, to match the terminology we use everywhere.
> I386 would match the uname, and X86_32 would be the logical countepart
> to X86_64.
> 

I changed it to X86_32.  That will better differentiate between 32-bit, 
64-bit, and common X86 options.

--------------000400070101080502080800
Content-Type: text/plain;
 name="0001-CONFIG_X86_32.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-CONFIG_X86_32.txt"

Subject: [PATCH] CONFIG_X86_32

Add CONFIG_X86_32 for i386.  This allows selecting options that only apply
to 32-bit systems.

(X86 && !X86_64) becomes X86_32
(X86 ||  X86_64) becomes X86

Signed-off-by: Brian Gerst <bgerst@didntduck.org>

---

 arch/i386/Kconfig                |    6 +++++-
 drivers/char/Kconfig             |    4 ++--
 drivers/char/agp/Kconfig         |   16 ++++++++--------
 drivers/char/hangcheck-timer.c   |    2 +-
 drivers/crypto/Kconfig           |    2 +-
 drivers/firmware/Kconfig         |    2 +-
 drivers/input/misc/Kconfig       |    2 +-
 drivers/pci/hotplug/pciehp_pci.c |    2 +-
 drivers/pci/hotplug/shpchp_pci.c |    2 +-
 drivers/pcmcia/rsrc_nonstatic.c  |    2 +-
 drivers/video/Kconfig            |    6 +++---
 drivers/video/console/Kconfig    |    2 +-
 fs/Kconfig                       |    2 +-
 fs/Kconfig.binfmt                |    2 +-
 include/linux/dmi.h              |    2 +-
 lib/Kconfig.debug                |    2 +-
 16 files changed, 30 insertions(+), 26 deletions(-)

d1db2b526b845229c75030d07745caed67360088
diff --git a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig
+++ b/arch/i386/Kconfig
@@ -5,7 +5,7 @@
 
 mainmenu "Linux Kernel Configuration"
 
-config X86
+config X86_32
 	bool
 	default y
 	help
@@ -18,6 +18,10 @@ config SEMAPHORE_SLEEPERS
 	bool
 	default y
 
+config X86
+	bool
+	default y
+	  
 config MMU
 	bool
 	default y
diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -661,7 +661,7 @@ config HW_RANDOM
 
 config NVRAM
 	tristate "/dev/nvram support"
-	depends on ATARI || X86 || X86_64 || ARM || GENERIC_NVRAM
+	depends on ATARI || X86 || ARM || GENERIC_NVRAM
 	---help---
 	  If you say Y here and create a character special file /dev/nvram
 	  with major number 10 and minor number 144 using mknod ("man mknod"),
@@ -985,7 +985,7 @@ config MAX_RAW_DEVS
 
 config HANGCHECK_TIMER
 	tristate "Hangcheck timer"
-	depends on X86_64 || X86 || IA64 || PPC64 || ARCH_S390
+	depends on X86 || IA64 || PPC64 || ARCH_S390
 	help
 	  The hangcheck-timer module detects when the system has gone
 	  out to lunch past a certain margin.  It can reboot the system
diff --git a/drivers/char/agp/Kconfig b/drivers/char/agp/Kconfig
--- a/drivers/char/agp/Kconfig
+++ b/drivers/char/agp/Kconfig
@@ -27,7 +27,7 @@ config AGP
 
 config AGP_ALI
 	tristate "ALI chipset support"
-	depends on AGP && X86 && !X86_64
+	depends on AGP && X86_32
 	---help---
 	  This option gives you AGP support for the GLX component of
 	  XFree86 4.x on the following ALi chipsets.  The supported chipsets
@@ -45,7 +45,7 @@ config AGP_ALI
 
 config AGP_ATI
 	tristate "ATI chipset support"
-	depends on AGP && X86 && !X86_64
+	depends on AGP && X86_32
 	---help---
       This option gives you AGP support for the GLX component of
       XFree86 4.x on the ATI RadeonIGP family of chipsets.
@@ -55,7 +55,7 @@ config AGP_ATI
 
 config AGP_AMD
 	tristate "AMD Irongate, 761, and 762 chipset support"
-	depends on AGP && X86 && !X86_64
+	depends on AGP && X86_32
 	help
 	  This option gives you AGP support for the GLX component of
 	  XFree86 4.x on AMD Irongate, 761, and 762 chipsets.
@@ -91,7 +91,7 @@ config AGP_INTEL
 
 config AGP_NVIDIA
 	tristate "NVIDIA nForce/nForce2 chipset support"
-	depends on AGP && X86 && !X86_64
+	depends on AGP && X86_32
 	help
 	  This option gives you AGP support for the GLX component of
 	  XFree86 4.x on the following NVIDIA chipsets.  The supported chipsets
@@ -99,7 +99,7 @@ config AGP_NVIDIA
 
 config AGP_SIS
 	tristate "SiS chipset support"
-	depends on AGP && X86 && !X86_64
+	depends on AGP && X86_32
 	help
 	  This option gives you AGP support for the GLX component of
 	  XFree86 4.x on Silicon Integrated Systems [SiS] chipsets.
@@ -111,14 +111,14 @@ config AGP_SIS
 
 config AGP_SWORKS
 	tristate "Serverworks LE/HE chipset support"
-	depends on AGP && X86 && !X86_64
+	depends on AGP && X86_32
 	help
 	  Say Y here to support the Serverworks AGP card.  See 
 	  <http://www.serverworks.com/> for product descriptions and images.
 
 config AGP_VIA
 	tristate "VIA chipset support"
-	depends on AGP && X86 && !X86_64
+	depends on AGP && X86_32
 	help
 	  This option gives you AGP support for the GLX component of
 	  XFree86 4.x on VIA MVP3/Apollo Pro chipsets.
@@ -154,7 +154,7 @@ config AGP_UNINORTH
 
 config AGP_EFFICEON
 	tristate "Transmeta Efficeon support"
-	depends on AGP && X86 && !X86_64
+	depends on AGP && X86_32
 	help
 	  This option gives you AGP support for the Transmeta Efficeon
 	  series processors with integrated northbridges.
diff --git a/drivers/char/hangcheck-timer.c b/drivers/char/hangcheck-timer.c
--- a/drivers/char/hangcheck-timer.c
+++ b/drivers/char/hangcheck-timer.c
@@ -117,7 +117,7 @@ __setup("hcheck_reboot", hangcheck_parse
 __setup("hcheck_dump_tasks", hangcheck_parse_dump_tasks);
 #endif /* not MODULE */
 
-#if defined(CONFIG_X86) || defined(CONFIG_X86_64)
+#if defined(CONFIG_X86)
 # define HAVE_MONOTONIC
 # define TIMER_FREQ 1000000000ULL
 #elif defined(CONFIG_ARCH_S390)
diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -2,7 +2,7 @@ menu "Hardware crypto devices"
 
 config CRYPTO_DEV_PADLOCK
 	tristate "Support for VIA PadLock ACE"
-	depends on CRYPTO && X86 && !X86_64
+	depends on CRYPTO && X86_32
 	help
 	  Some VIA processors come with an integrated crypto engine
 	  (so called VIA PadLock ACE, Advanced Cryptography Engine)
diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -70,7 +70,7 @@ config DELL_RBU
 
 config DCDBAS
 	tristate "Dell Systems Management Base Driver"
-	depends on X86 || X86_64
+	depends on X86
 	help
 	  The Dell Systems Management Base Driver provides a sysfs interface
 	  for systems management software to perform System Management
diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -14,7 +14,7 @@ if INPUT_MISC
 
 config INPUT_PCSPKR
 	tristate "PC Speaker support"
-	depends on ALPHA || X86 || X86_64 || MIPS || PPC_PREP || PPC_CHRP || PPC_PSERIES
+	depends on ALPHA || X86 || MIPS || PPC_PREP || PPC_CHRP || PPC_PSERIES
 	help
 	  Say Y here if you want the standard PC Speaker to be used for
 	  bells and whistles.
diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -113,7 +113,7 @@ int pciehp_unconfigure_device(struct pci
  */
 int pciehp_set_irq (u8 bus_num, u8 dev_num, u8 int_pin, u8 irq_num)
 {
-#if defined(CONFIG_X86) && !defined(CONFIG_X86_IO_APIC) && !defined(CONFIG_X86_64)
+#if defined(CONFIG_X86_32) && !defined(CONFIG_X86_IO_APIC)
 	int rc;
 	u16 temp_word;
 	struct pci_dev fakedev;
diff --git a/drivers/pci/hotplug/shpchp_pci.c b/drivers/pci/hotplug/shpchp_pci.c
--- a/drivers/pci/hotplug/shpchp_pci.c
+++ b/drivers/pci/hotplug/shpchp_pci.c
@@ -104,7 +104,7 @@ int shpchp_unconfigure_device(struct pci
  */
 int shpchp_set_irq (u8 bus_num, u8 dev_num, u8 int_pin, u8 irq_num)
 {
-#if defined(CONFIG_X86) && !defined(CONFIG_X86_IO_APIC) && !defined(CONFIG_X86_64)
+#if defined(CONFIG_X86_32) && !defined(CONFIG_X86_IO_APIC)
 	int rc;
 	u16 temp_word;
 	struct pci_dev fakedev;
diff --git a/drivers/pcmcia/rsrc_nonstatic.c b/drivers/pcmcia/rsrc_nonstatic.c
--- a/drivers/pcmcia/rsrc_nonstatic.c
+++ b/drivers/pcmcia/rsrc_nonstatic.c
@@ -779,7 +779,7 @@ static int nonstatic_autoadd_resources(s
 	if (!s->cb_dev || !s->cb_dev->bus)
 		return -ENODEV;
 
-#if defined(CONFIG_X86) || defined(CONFIG_X86_64)
+#if defined(CONFIG_X86)
 	/* If this is the root bus, the risk of hitting
 	 * some strange system devices which aren't protected
 	 * by either ACPI resource tables or properly requested
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -494,7 +494,7 @@ config FB_TGA
 
 config FB_VESA
 	bool "VESA VGA graphics support"
-	depends on (FB = y) && (X86 || X86_64)
+	depends on (FB = y) && X86
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
@@ -712,7 +712,7 @@ config FB_RIVA_DEBUG
 
 config FB_I810
 	tristate "Intel 810/815 support (EXPERIMENTAL)"
-	depends on FB && EXPERIMENTAL && PCI && X86 && !X86_64
+	depends on FB && EXPERIMENTAL && PCI && X86_32
 	select AGP
 	select AGP_INTEL
 	select FB_MODE_HELPERS
@@ -761,7 +761,7 @@ config FB_I810_I2C
 
 config FB_INTEL
 	tristate "Intel 830M/845G/852GM/855GM/865G support (EXPERIMENTAL)"
-	depends on FB && EXPERIMENTAL && PCI && X86 && !X86_64
+	depends on FB && EXPERIMENTAL && PCI && X86_32
 	select AGP
 	select AGP_INTEL
 	select FB_MODE_HELPERS
diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -28,7 +28,7 @@ config VGA_CONSOLE
 
 config VIDEO_SELECT
 	bool "Video mode selection support"
-	depends on  (X86 || X86_64) && VGA_CONSOLE
+	depends on  X86 && VGA_CONSOLE
 	---help---
 	  This enables support for text mode selection on kernel startup. If
 	  you want to take advantage of some high-resolution text mode your
diff --git a/fs/Kconfig b/fs/Kconfig
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -840,7 +840,7 @@ config TMPFS
 
 config HUGETLBFS
 	bool "HugeTLB file system support"
-	depends X86 || IA64 || PPC64 || SPARC64 || SUPERH || X86_64 || BROKEN
+	depends X86 || IA64 || PPC64 || SPARC64 || SUPERH || BROKEN
 
 config HUGETLB_PAGE
 	def_bool HUGETLBFS
diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
--- a/fs/Kconfig.binfmt
+++ b/fs/Kconfig.binfmt
@@ -57,7 +57,7 @@ config BINFMT_SHARED_FLAT
 
 config BINFMT_AOUT
 	tristate "Kernel support for a.out and ECOFF binaries"
-	depends on (X86 && !X86_64) || ALPHA || ARM || M68K || SPARC32
+	depends on X86_32 || ALPHA || ARM || M68K || SPARC32
 	---help---
 	  A.out (Assembler.OUTput) is a set of formats for libraries and
 	  executables used in the earliest versions of UNIX.  Linux used
diff --git a/include/linux/dmi.h b/include/linux/dmi.h
--- a/include/linux/dmi.h
+++ b/include/linux/dmi.h
@@ -60,7 +60,7 @@ struct dmi_device {
 	void *device_data;	/* Type specific data */
 };
 
-#if defined(CONFIG_X86) && !defined(CONFIG_X86_64)
+#if defined(CONFIG_X86_32)
 
 extern int dmi_check_system(struct dmi_system_id *list);
 extern char * dmi_get_system_info(int field);
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -128,7 +128,7 @@ config DEBUG_HIGHMEM
 config DEBUG_BUGVERBOSE
 	bool "Verbose BUG() reporting (adds 70K)" if DEBUG_KERNEL && EMBEDDED
 	depends on BUG
-	depends on ARM || ARM26 || M32R || M68K || SPARC32 || SPARC64 || (X86 && !X86_64) || FRV
+	depends on ARM || ARM26 || M32R || M68K || SPARC32 || SPARC64 || X86_32 || FRV
 	default !EMBEDDED
 	help
 	  Say Y here to make BUG() panics output the file name and line number

--------------000400070101080502080800--
