Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932191AbVJIASA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbVJIASA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 20:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbVJIASA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 20:18:00 -0400
Received: from xenotime.net ([66.160.160.81]:36319 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932191AbVJIAR7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 20:17:59 -0400
Date: Sat, 8 Oct 2005 17:17:53 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: tom.l.nguyen@intel.com, akpm <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Doc/MSI-HOWTO: cleanups
Message-Id: <20051008171753.2137fd82.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Clean up typos, kernel function interfaces, acronyms,
  add whitespace, improve readability.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---

 Documentation/MSI-HOWTO.txt |  156 +++++++++++++++++-----------------
 1 files changed, 78 insertions(+), 78 deletions(-)

diff -Naurp linux-2614-rc3-g7/Documentation/MSI-HOWTO.txt~doc_msi linux-2614-rc3-g7/Documentation/MSI-HOWTO.txt
--- linux-2614-rc3-g7/Documentation/MSI-HOWTO.txt~doc_msi	2005-10-08 11:44:06.000000000 -0700
+++ linux-2614-rc3-g7/Documentation/MSI-HOWTO.txt	2005-10-08 17:08:35.000000000 -0700
@@ -10,14 +10,14 @@
 This guide describes the basics of Message Signaled Interrupts (MSI),
 the advantages of using MSI over traditional interrupt mechanisms,
 and how to enable your driver to use MSI or MSI-X. Also included is
-a Frequently Asked Questions.
+a Frequently Asked Questions (FAQ) section.
 
 2. Copyright 2003 Intel Corporation
 
 3. What is MSI/MSI-X?
 
 Message Signaled Interrupt (MSI), as described in the PCI Local Bus
-Specification Revision 2.3 or latest, is an optional feature, and a
+Specification Revision 2.3 or later, is an optional feature, and a
 required feature for PCI Express devices. MSI enables a device function
 to request service by sending an Inbound Memory Write on its PCI bus to
 the FSB as a Message Signal Interrupt transaction. Because MSI is
@@ -27,7 +27,7 @@ supported.
 
 A PCI device that supports MSI must also support pin IRQ assertion
 interrupt mechanism to provide backward compatibility for systems that
-do not support MSI. In Systems, which support MSI, the bus driver is
+do not support MSI. In systems which support MSI, the bus driver is
 responsible for initializing the message address and message data of
 the device function's MSI/MSI-X capability structure during device
 initial configuration.
@@ -63,7 +63,7 @@ over the MSI capability structure as des
 	masking is an optional extension of MSI but a required
 	feature for MSI-X. Per-vector masking provides the kernel
 	the ability to mask/unmask MSI when servicing its software
-	interrupt service routing handler. If per-vector masking is
+	interrupt service routine handler. If per-vector masking is
 	not supported, then the device driver should provide the
 	hardware/software synchronization to ensure that the device
 	generates MSI when the driver wants it to do so.
@@ -87,7 +87,7 @@ support. As a result, the PCI Express te
 support for better interrupt performance.
 
 Using MSI enables the device functions to support two or more
-vectors, which can be configured to target different CPU's to
+vectors, which can be configured to target different CPUs to
 increase scalability.
 
 5. Configuring a driver to use MSI/MSI-X
@@ -119,13 +119,13 @@ pci_enable_msi() explicitly.
 
 int pci_enable_msi(struct pci_dev *dev)
 
-With this new API, any existing device driver, which like to have
-MSI enabled on its device function, must call this API to enable MSI
+With this new API, any existing device driver which wants to have
+MSI enabled on its device function must call this API to enable MSI.
 A successful call will initialize the MSI capability structure
 with ONE vector, regardless of whether a device function is
 capable of supporting multiple messages. This vector replaces the
 pre-assigned dev->irq with a new MSI vector. To avoid the conflict
-of new assigned vector with existing pre-assigned vector requires
+of the new assigned vector with existing pre-assigned vector requires
 a device driver to call this API before calling request_irq().
 
 5.2.2 API pci_disable_msi
@@ -137,14 +137,14 @@ when a device driver is unloading. This 
 the pre-assigned IOAPIC vector and switches a device's interrupt
 mode to PCI pin-irq assertion/INTx emulation mode.
 
-Note that a device driver should always call free_irq() on MSI vector
-it has done request_irq() on before calling this API. Failure to do
-so results a BUG_ON() and a device will be left with MSI enabled and
+Note that a device driver should always call free_irq() on the MSI vector
+that it has done request_irq() on before calling this API. Failure to do
+so results in a BUG_ON() and a device will be left with MSI enabled and
 leaks its vector.
 
 5.2.3 MSI mode vs. legacy mode diagram
 
-The below diagram shows the events, which switches the interrupt
+The below diagram shows the events which switch the interrupt
 mode on the MSI-capable device function between MSI mode and
 PIN-IRQ assertion mode.
 
@@ -155,9 +155,9 @@ PIN-IRQ assertion mode.
  	 ------------	pci_disable_msi  ------------------------
 
 
-Figure 1.0 MSI Mode vs. Legacy Mode
+Figure 1. MSI Mode vs. Legacy Mode
 
-In Figure 1.0, a device operates by default in legacy mode. Legacy
+In Figure 1, a device operates by default in legacy mode. Legacy
 in this context means PCI pin-irq assertion or PCI-Express INTx
 emulation. A successful MSI request (using pci_enable_msi()) switches
 a device's interrupt mode to MSI mode. A pre-assigned IOAPIC vector
@@ -166,11 +166,11 @@ assigned MSI vector will replace dev->ir
 
 To return back to its default mode, a device driver should always call
 pci_disable_msi() to undo the effect of pci_enable_msi(). Note that a
-device driver should always call free_irq() on MSI vector it has done
-request_irq() on before calling pci_disable_msi(). Failure to do so
-results a BUG_ON() and a device will be left with MSI enabled and
+device driver should always call free_irq() on the MSI vector it has
+done request_irq() on before calling pci_disable_msi(). Failure to do
+so results in a BUG_ON() and a device will be left with MSI enabled and
 leaks its vector. Otherwise, the PCI subsystem restores a device's
-dev->irq with a pre-assigned IOAPIC vector and marks released
+dev->irq with a pre-assigned IOAPIC vector and marks the released
 MSI vector as unused.
 
 Once being marked as unused, there is no guarantee that the PCI
@@ -178,8 +178,8 @@ subsystem will reserve this MSI vector f
 the availability of current PCI vector resources and the number of
 MSI/MSI-X requests from other drivers, this MSI may be re-assigned.
 
-For the case where the PCI subsystem re-assigned this MSI vector
-another driver, a request to switching back to MSI mode may result
+For the case where the PCI subsystem re-assigns this MSI vector to
+another driver, a request to switch back to MSI mode may result
 in being assigned a different MSI vector or a failure if no more
 vectors are available.
 
@@ -208,12 +208,12 @@ Unlike the function pci_enable_msi(), th
 does not replace the pre-assigned IOAPIC dev->irq with a new MSI
 vector because the PCI subsystem writes the 1:1 vector-to-entry mapping
 into the field vector of each element contained in a second argument.
-Note that the pre-assigned IO-APIC dev->irq is valid only if the device
-operates in PIN-IRQ assertion mode. In MSI-X mode, any attempt of
+Note that the pre-assigned IOAPIC dev->irq is valid only if the device
+operates in PIN-IRQ assertion mode. In MSI-X mode, any attempt at
 using dev->irq by the device driver to request for interrupt service
 may result unpredictabe behavior.
 
-For each MSI-X vector granted, a device driver is responsible to call
+For each MSI-X vector granted, a device driver is responsible for calling
 other functions like request_irq(), enable_irq(), etc. to enable
 this vector with its corresponding interrupt service handler. It is
 a device driver's choice to assign all vectors with the same
@@ -224,13 +224,13 @@ service handler.
 
 The PCI 3.0 specification has implementation notes that MMIO address
 space for a device's MSI-X structure should be isolated so that the
-software system can set different page for controlling accesses to
-the MSI-X structure. The implementation of MSI patch requires the PCI
+software system can set different pages for controlling accesses to the
+MSI-X structure. The implementation of the MSI patch requires the PCI
 subsystem, not a device driver, to maintain full control of the MSI-X
-table/MSI-X PBA and MMIO address space of the MSI-X table/MSI-X PBA.
-A device driver is prohibited from requesting the MMIO address space
-of the MSI-X table/MSI-X PBA. Otherwise, the PCI subsystem will fail
-enabling MSI-X on its hardware device when it calls the function
+table/MSI-X PBA (Pending Bit Array) and MMIO address space of the MSI-X
+table/MSI-X PBA.  A device driver is prohibited from requesting the MMIO
+address space of the MSI-X table/MSI-X PBA. Otherwise, the PCI subsystem
+will fail enabling MSI-X on its hardware device when it calls the function
 pci_enable_msix().
 
 5.3.2 Handling MSI-X allocation
@@ -274,9 +274,9 @@ For the case where fewer MSI-X vectors a
 than requested, the function pci_enable_msix() will return the
 maximum number of MSI-X vectors available to the caller. A device
 driver may re-send its request with fewer or equal vectors indicated
-in a return. For example, if a device driver requests 5 vectors, but
-the number of available vectors is 3 vectors, a value of 3 will be a
-return as a result of pci_enable_msix() call. A function could be
+in the return. For example, if a device driver requests 5 vectors, but
+the number of available vectors is 3 vectors, a value of 3 will be
+returned as a result of pci_enable_msix() call. A function could be
 designed for its driver to use only 3 MSI-X table entries as
 different combinations as ABC--, A-B-C, A--CB, etc. Note that this
 patch does not support multiple entries with the same vector. Such
@@ -285,49 +285,46 @@ as ABBCC, AABCC, BCCBA, etc will result 
 pci_enable_msix(). Below are the reasons why supporting multiple
 entries with the same vector is an undesirable solution.
 
-	- The PCI subsystem can not determine which entry, which
-	  generated the message, to mask/unmask MSI while handling
+	- The PCI subsystem cannot determine the entry that
+	  generated the message to mask/unmask MSI while handling
 	  software driver ISR. Attempting to walk through all MSI-X
 	  table entries (2048 max) to mask/unmask any match vector
 	  is an undesirable solution.
 
-	- Walk through all MSI-X table entries (2048 max) to handle
+	- Walking through all MSI-X table entries (2048 max) to handle
 	  SMP affinity of any match vector is an undesirable solution.
 
 5.3.4 API pci_enable_msix
 
-int pci_enable_msix(struct pci_dev *dev, u32 *entries, int nvec)
+int pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries, int nvec)
 
 This API enables a device driver to request the PCI subsystem
-for enabling MSI-X messages on its hardware device. Depending on
+to enable MSI-X messages on its hardware device. Depending on
 the availability of PCI vectors resources, the PCI subsystem enables
-either all or nothing.
+either all or none of the requested vectors.
 
-Argument dev points to the device (pci_dev) structure.
+Argument 'dev' points to the device (pci_dev) structure.
 
-Argument entries is a pointer of unsigned integer type. The number of
-elements is indicated in argument nvec. The content of each element
-will be mapped to the following struct defined in /driver/pci/msi.h.
+Argument 'entries' is a pointer to an array of msix_entry structs.
+The number of entries is indicated in argument 'nvec'.
+struct msix_entry is defined in /driver/pci/msi.h:
 
 struct msix_entry {
 	u16 	vector; /* kernel uses to write alloc vector */
 	u16	entry; /* driver uses to specify entry */
 };
 
-A device driver is responsible for initializing the field entry of
-each element with unique entry supported by MSI-X table. Otherwise,
+A device driver is responsible for initializing the field 'entry' of
+each element with a unique entry supported by MSI-X table. Otherwise,
 -EINVAL will be returned as a result. A successful return of zero
-indicates the PCI subsystem completes initializing each of requested
+indicates the PCI subsystem completed initializing each of the requested
 entries of the MSI-X table with message address and message data.
 Last but not least, the PCI subsystem will write the 1:1
-vector-to-entry mapping into the field vector of each element. A
-device driver is responsible of keeping track of allocated MSI-X
+vector-to-entry mapping into the field 'vector' of each element. A
+device driver is responsible for keeping track of allocated MSI-X
 vectors in its internal data structure.
 
-Argument nvec is an integer indicating the number of messages
-requested.
-
-A return of zero indicates that the number of MSI-X vectors is
+A return of zero indicates that the number of MSI-X vectors was
 successfully allocated. A return of greater than zero indicates
 MSI-X vector shortage. Or a return of less than zero indicates
 a failure. This failure may be a result of duplicate entries
@@ -341,12 +338,12 @@ void pci_disable_msix(struct pci_dev *de
 This API should always be used to undo the effect of pci_enable_msix()
 when a device driver is unloading. Note that a device driver should
 always call free_irq() on all MSI-X vectors it has done request_irq()
-on before calling this API. Failure to do so results a BUG_ON() and
+on before calling this API. Failure to do so results in a BUG_ON() and
 a device will be left with MSI-X enabled and leaks its vectors.
 
 5.3.6 MSI-X mode vs. legacy mode diagram
 
-The below diagram shows the events, which switches the interrupt
+The below diagram shows the events which switch the interrupt
 mode on the MSI-X capable device function between MSI-X mode and
 PIN-IRQ assertion mode (legacy).
 
@@ -356,22 +353,22 @@ PIN-IRQ assertion mode (legacy).
 	| 	     | ===============>	    |			     |
  	 ------------	pci_disable_msix     ------------------------
 
-Figure 2.0 MSI-X Mode vs. Legacy Mode
+Figure 2. MSI-X Mode vs. Legacy Mode
 
-In Figure 2.0, a device operates by default in legacy mode. A
+In Figure 2, a device operates by default in legacy mode. A
 successful MSI-X request (using pci_enable_msix()) switches a
 device's interrupt mode to MSI-X mode. A pre-assigned IOAPIC vector
 stored in dev->irq will be saved by the PCI subsystem; however,
 unlike MSI mode, the PCI subsystem will not replace dev->irq with
 assigned MSI-X vector because the PCI subsystem already writes the 1:1
-vector-to-entry mapping into the field vector of each element
+vector-to-entry mapping into the field 'vector' of each element
 specified in second argument.
 
 To return back to its default mode, a device driver should always call
 pci_disable_msix() to undo the effect of pci_enable_msix(). Note that
 a device driver should always call free_irq() on all MSI-X vectors it
 has done request_irq() on before calling pci_disable_msix(). Failure
-to do so results a BUG_ON() and a device will be left with MSI-X
+to do so results in a BUG_ON() and a device will be left with MSI-X
 enabled and leaks its vectors. Otherwise, the PCI subsystem switches a
 device function's interrupt mode from MSI-X mode to legacy mode and
 marks all allocated MSI-X vectors as unused.
@@ -383,53 +380,56 @@ MSI/MSI-X requests from other drivers, t
 re-assigned.
 
 For the case where the PCI subsystem re-assigned these MSI-X vectors
-to other driver, a request to switching back to MSI-X mode may result
+to other drivers, a request to switch back to MSI-X mode may result
 being assigned with another set of MSI-X vectors or a failure if no
 more vectors are available.
 
-5.4 Handling function implementng both MSI and MSI-X capabilities
+5.4 Handling function implementing both MSI and MSI-X capabilities
 
 For the case where a function implements both MSI and MSI-X
 capabilities, the PCI subsystem enables a device to run either in MSI
 mode or MSI-X mode but not both. A device driver determines whether it
 wants MSI or MSI-X enabled on its hardware device. Once a device
-driver requests for MSI, for example, it is prohibited to request for
+driver requests for MSI, for example, it is prohibited from requesting
 MSI-X; in other words, a device driver is not permitted to ping-pong
 between MSI mod MSI-X mode during a run-time.
 
 5.5 Hardware requirements for MSI/MSI-X support
+
 MSI/MSI-X support requires support from both system hardware and
 individual hardware device functions.
 
 5.5.1 System hardware support
+
 Since the target of MSI address is the local APIC CPU, enabling
-MSI/MSI-X support in Linux kernel is dependent on whether existing
-system hardware supports local APIC. Users should verify their
-system whether it runs when CONFIG_X86_LOCAL_APIC=y.
+MSI/MSI-X support in the Linux kernel is dependent on whether existing
+system hardware supports local APIC. Users should verify that their
+system supports local APIC operation by testing that it runs when
+CONFIG_X86_LOCAL_APIC=y.
 
 In SMP environment, CONFIG_X86_LOCAL_APIC is automatically set;
 however, in UP environment, users must manually set
 CONFIG_X86_LOCAL_APIC. Once CONFIG_X86_LOCAL_APIC=y, setting
-CONFIG_PCI_MSI enables the VECTOR based scheme and
-the option for MSI-capable device drivers to selectively enable
-MSI/MSI-X.
+CONFIG_PCI_MSI enables the VECTOR based scheme and the option for
+MSI-capable device drivers to selectively enable MSI/MSI-X.
 
 Note that CONFIG_X86_IO_APIC setting is irrelevant because MSI/MSI-X
 vector is allocated new during runtime and MSI/MSI-X support does not
 depend on BIOS support. This key independency enables MSI/MSI-X
-support on future IOxAPIC free platform.
+support on future IOxAPIC free platforms.
 
 5.5.2 Device hardware support
+
 The hardware device function supports MSI by indicating the
 MSI/MSI-X capability structure on its PCI capability list. By
 default, this capability structure will not be initialized by
 the kernel to enable MSI during the system boot. In other words,
 the device function is running on its default pin assertion mode.
 Note that in many cases the hardware supporting MSI have bugs,
-which may result in system hang. The software driver of specific
-MSI-capable hardware is responsible for whether calling
+which may result in system hangs. The software driver of specific
+MSI-capable hardware is responsible for deciding whether to call
 pci_enable_msi or not. A return of zero indicates the kernel
-successfully initializes the MSI/MSI-X capability structure of the
+successfully initialized the MSI/MSI-X capability structure of the
 device function. The device function is now running on MSI/MSI-X mode.
 
 5.6 How to tell whether MSI/MSI-X is enabled on device function
@@ -439,10 +439,10 @@ pci_enable_msi()/pci_enable_msix() indic
 its device function is initialized successfully and ready to run in
 MSI/MSI-X mode.
 
-At the user level, users can use command 'cat /proc/interrupts'
-to display the vector allocated for a device and its interrupt
-MSI/MSI-X mode ("PCI MSI"/"PCI MSIX"). Below shows below MSI mode is
-enabled on a SCSI Adaptec 39320D Ultra320.
+At the user level, users can use the command 'cat /proc/interrupts'
+to display the vectors allocated for devices and their interrupt
+MSI/MSI-X modes ("PCI-MSI"/"PCI-MSI-X"). Below shows MSI mode is
+enabled on a SCSI Adaptec 39320D Ultra320 controller.
 
            CPU0       CPU1
   0:     324639          0    IO-APIC-edge  timer
@@ -453,8 +453,8 @@ enabled on a SCSI Adaptec 39320D Ultra32
  15:          1          0    IO-APIC-edge  ide1
 169:          0          0   IO-APIC-level  uhci-hcd
 185:          0          0   IO-APIC-level  uhci-hcd
-193:        138         10         PCI MSI  aic79xx
-201:         30          0         PCI MSI  aic79xx
+193:        138         10         PCI-MSI  aic79xx
+201:         30          0         PCI-MSI  aic79xx
 225:         30          0   IO-APIC-level  aic7xxx
 233:         30          0   IO-APIC-level  aic7xxx
 NMI:          0          0
@@ -490,8 +490,8 @@ target address set as 0xfeexxxxx, as con
 specification 2.3 or latest, then it should work.
 
 Q4. From the driver point of view, if the MSI is lost because
-of the errors occur during inbound memory write, then it may
-wait for ever. Is there a mechanism for it to recover?
+of errors occurring during inbound memory write, then it may
+wait forever. Is there a mechanism for it to recover?
 
 A4. Since the target of the transaction is an inbound memory
 write, all transaction termination conditions (Retry,

---
