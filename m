Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293737AbSCKNwn>; Mon, 11 Mar 2002 08:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293743AbSCKNwd>; Mon, 11 Mar 2002 08:52:33 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:33032 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S293737AbSCKNwM>; Mon, 11 Mar 2002 08:52:12 -0500
Message-Id: <200203111349.g2BDnGq05361@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] KERN_INFO 2.4.19-pre2 arch/i386/kernel/*.c
Date: Mon, 11 Mar 2002 15:48:30 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Primary purpose of this patch is to make KERN_WARNING and
KERN_INFO log levels closer to their original meaning.
Today they are quite far from what was intended.
Just look what kernel writes at the WARNING level
each time you boot your box!

Diff for some arch/i386/kernel/*.c files

diff -u --recursive -x *.orig -x *.rej 
linux-2.4.19-pre2/arch/i386/kernel/apic.c linux-new/arch/i386/kernel/apic.c
--- linux-2.4.19-pre2/arch/i386/kernel/apic.c	Mon Feb 25 17:37:52 2002
+++ linux-new/arch/i386/kernel/apic.c	Mon Mar 11 11:38:03 2002
@@ -372,10 +372,10 @@
 	value = apic_read(APIC_LVT0) & APIC_LVT_MASKED;
 	if (!smp_processor_id() && (pic_mode || !value)) {
 		value = APIC_DM_EXTINT;
-		printk("enabled ExtINT on CPU#%d\n", smp_processor_id());
+		printk(KERN_INFO "Enabled ExtINT on CPU#%d\n", smp_processor_id());
 	} else {
 		value = APIC_DM_EXTINT | APIC_LVT_MASKED;
-		printk("masked ExtINT on CPU#%d\n", smp_processor_id());
+		printk(KERN_INFO "Masked ExtINT on CPU#%d\n", smp_processor_id());
 	}
 	apic_write_around(APIC_LVT0, value);
 
@@ -395,7 +395,7 @@
 		if (maxlvt > 3)		/* Due to the Pentium erratum 3AP. */
 			apic_write(APIC_ESR, 0);
 		value = apic_read(APIC_ESR);
-		printk("ESR value before enabling vector: %08lx\n", value);
+		printk(KERN_INFO "ESR value before enabling vector: %08lx\n", value);
 
 		value = ERROR_APIC_VECTOR;      // enables sending errors
 		apic_write_around(APIC_LVTERR, value);
@@ -405,7 +405,7 @@
 		if (maxlvt > 3)
 			apic_write(APIC_ESR, 0);
 		value = apic_read(APIC_ESR);
-		printk("ESR value after enabling vector: %08lx\n", value);
+		printk(KERN_INFO "ESR value after enabling vector: %08lx\n", value);
 	} else {
 		if (esr_disable)	
 			/* 
@@ -414,9 +414,9 @@
 			 * ESR disabled - we can't do anything useful with the
 			 * errors anyway - mbligh
 			 */
-			printk("Leaving ESR disabled.\n");
+			printk(KERN_INFO "Leaving ESR disabled\n");
 		else 
-			printk("No ESR for 82489DX.\n");
+			printk(KERN_INFO "No ESR for 82489DX\n");
 	}
 
 	if (nmi_watchdog == NMI_LOCAL_APIC)
@@ -614,7 +614,7 @@
 		 */
 		rdmsr(MSR_IA32_APICBASE, l, h);
 		if (!(l & MSR_IA32_APICBASE_ENABLE)) {
-			printk("Local APIC disabled by BIOS -- reenabling.\n");
+			printk(KERN_INFO "Local APIC disabled by BIOS -- reenabling\n");
 			l &= ~MSR_IA32_APICBASE_BASE;
 			l |= MSR_IA32_APICBASE_ENABLE | APIC_DEFAULT_PHYS_BASE;
 			wrmsr(MSR_IA32_APICBASE, l, h);
@@ -626,7 +626,7 @@
 	 */
 	features = cpuid_edx(1);
 	if (!(features & (1 << X86_FEATURE_APIC))) {
-		printk("Could not enable APIC!\n");
+		printk(KERN_WARNING "Could not enable APIC!\n");
 		return -1;
 	}
 	set_bit(X86_FEATURE_APIC, &boot_cpu_data.x86_capability);
@@ -635,14 +635,14 @@
 	if (nmi_watchdog != NMI_NONE)
 		nmi_watchdog = NMI_LOCAL_APIC;
 
-	printk("Found and enabled local APIC!\n");
+	printk(KERN_INFO "Found and enabled local APIC\n");
 
 	apic_pm_init1();
 
 	return 0;
 
 no_apic:
-	printk("No local APIC present or hardware disabled\n");
+	printk(KERN_INFO "No local APIC present or hardware disabled\n");
 	return -1;
 }
 
@@ -796,7 +796,7 @@
 	 */
 
 	slice = clocks / (smp_num_cpus+1);
-	printk("cpu: %d, clocks: %d, slice: %d\n",
+	printk(KERN_INFO "CPU: %d, clocks: %d, slice: %d\n",
 		smp_processor_id(), clocks, slice);
 
 	/*
@@ -820,7 +820,7 @@
 
 	__setup_APIC_LVTT(clocks);
 
-	printk("CPU%d<T0:%d,T1:%d,D:%d,S:%d,C:%d>\n",
+	printk(KERN_INFO "CPU%d<T0:%d,T1:%d,D:%d,S:%d,C:%d>\n",
 			smp_processor_id(), t0, t1, delta, slice, clocks);
 
 	__restore_flags(flags);
@@ -847,7 +847,7 @@
 	int i;
 	const int LOOPS = HZ/10;
 
-	printk("calibrating APIC timer ...\n");
+	printk(KERN_INFO "Calibrating APIC timer ...\n");
 
 	/*
 	 * Put whatever arbitrary (but long enough) timeout
@@ -892,11 +892,11 @@
 	result = (tt1-tt2)*APIC_DIVISOR/LOOPS;
 
 	if (cpu_has_tsc)
-		printk("..... CPU clock speed is %ld.%04ld MHz.\n",
+		printk(KERN_INFO "..... CPU clock speed is %ld.%04ld MHz\n",
 			((long)(t2-t1)/LOOPS)/(1000000/HZ),
 			((long)(t2-t1)/LOOPS)%(1000000/HZ));
 
-	printk("..... host bus clock speed is %ld.%04ld MHz.\n",
+	printk(KERN_INFO "..... host bus clock speed is %ld.%04ld MHz\n",
 		result/(1000000/HZ),
 		result%(1000000/HZ));
 
@@ -907,7 +907,7 @@
 
 void __init setup_APIC_clocks (void)
 {
-	printk("Using local APIC timer interrupts.\n");
+	printk(KERN_INFO "Using local APIC timer interrupts\n");
 	using_apic_timer = 1;
 
 	__cli();
diff -u --recursive -x *.orig -x *.rej 
linux-2.4.19-pre2/arch/i386/kernel/io_apic.c 
linux-new/arch/i386/kernel/io_apic.c
--- linux-2.4.19-pre2/arch/i386/kernel/io_apic.c	Tue Nov 13 23:28:41 2001
+++ linux-new/arch/i386/kernel/io_apic.c	Mon Mar 11 11:38:03 2002
@@ -192,7 +192,7 @@
 		pirq_entries[i] = -1;
 
 	pirqs_enabled = 1;
-	printk(KERN_INFO "PIRQ redirection, working around broken MP-BIOS.\n");
+	printk(KERN_INFO "PIRQ redirection, working around broken MP-BIOS\n");
 	max = MAX_PIRQS;
 	if (ints[0] < MAX_PIRQS)
 		max = ints[0];
@@ -513,7 +513,7 @@
 		}
 		default:
 		{
-			printk(KERN_ERR "unknown bus type %d.\n",bus); 
+			printk(KERN_ERR "unknown bus type %d\n",bus); 
 			irq = 0;
 			break;
 		}
@@ -649,7 +649,7 @@
 	}
 
 	if (!first_notcon)
-		printk(" not connected.\n");
+		printk(" not connected\n");
 }
 
 /*
@@ -731,7 +731,6 @@
 		*(int *)&reg_02 = io_apic_read(apic, 2);
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 
-	printk("\n");
 	printk(KERN_DEBUG "IO APIC #%d......\n", mp_ioapics[apic].mpc_apicid);
 	printk(KERN_DEBUG ".... register #00: %08X\n", *(int *)&reg_00);
 	printk(KERN_DEBUG ".......    : physical APIC id: %02X\n", reg_00.ID);
@@ -772,7 +771,7 @@
 	printk(KERN_DEBUG ".... IRQ redirection table:\n");
 
 	printk(KERN_DEBUG " NR Log Phy Mask Trig IRR Pol"
-			  " Stat Dest Deli Vect:   \n");
+			  " Stat Dest Deli Vect:\n");
 
 	for (i = 0; i <= reg_01.entries; i++) {
 		struct IO_APIC_route_entry entry;
@@ -1048,12 +1047,13 @@
 					break;
 			if (i >= 0xf)
 				panic("Max APIC ID exceeded!\n");
-			printk(KERN_ERR "... fixing up to %d. (tell your hw vendor)\n",
-				i);
+			printk(KERN_ERR "... fixing up to %d"
+				" (tell your hw vendor)\n",i);
 			phys_id_present_map |= 1 << i;
 			mp_ioapics[apic].mpc_apicid = i;
 		} else {
-			printk("Setting %d in the phys_id_present_map\n", 
mp_ioapics[apic].mpc_apicid);
+			printk(KERN_INFO "Setting %d in the phys_id_present_map\n",
+				mp_ioapics[apic].mpc_apicid);
 			phys_id_present_map |= 1 << mp_ioapics[apic].mpc_apicid;
 		}
 
@@ -1603,7 +1603,7 @@
 	enable_IO_APIC();
 
 	io_apic_irqs = ~PIC_IRQS;
-	printk("ENABLING IO-APIC IRQs\n");
+	printk(KERN_INFO "Enabling IO-APIC IRQs\n");
 
 	/*
 	 * Set up the IO-APIC IRQ routing table by parsing the MP-BIOS
diff -u --recursive -x *.orig -x *.rej 
linux-2.4.19-pre2/arch/i386/kernel/mpparse.c 
linux-new/arch/i386/kernel/mpparse.c
--- linux-2.4.19-pre2/arch/i386/kernel/mpparse.c	Tue Mar  5 12:41:24 2002
+++ linux-new/arch/i386/kernel/mpparse.c	Mon Mar 11 11:50:00 2002
@@ -149,13 +149,13 @@
 		quad = translation_table[mpc_record]->trans_quad;
 		logical_apicid = (quad << 4) + 
 			(m->mpc_apicid ? m->mpc_apicid << 1 : 1);
-		printk("Processor #%d %s APIC version %d (quad %d, apic %d)\n",
+		printk(KERN_INFO "Processor #%d %s APIC version %d (quad %d, apic %d)\n",
 			m->mpc_apicid,
 			mpc_family((m->mpc_cpufeature & CPU_FAMILY_MASK)>>8 ,
 				   (m->mpc_cpufeature & CPU_MODEL_MASK)>>4),
 			m->mpc_apicver, quad, logical_apicid);
 	} else {
-		printk("Processor #%d %s APIC version %d\n",
+		printk(KERN_INFO "Processor #%d %s APIC version %d\n",
 			m->mpc_apicid,
 			mpc_family((m->mpc_cpufeature & CPU_FAMILY_MASK)>>8 ,
 				   (m->mpc_cpufeature & CPU_MODEL_MASK)>>4),
@@ -219,7 +219,7 @@
 	num_processors++;
 
 	if (m->mpc_apicid > MAX_APICS) {
-		printk("Processor #%d INVALID. (Max ID: %d).\n",
+		printk("Processor #%d INVALID. (Max ID: %d)\n",
 			m->mpc_apicid, MAX_APICS);
 		return;
 	}
@@ -234,7 +234,8 @@
 	 * Validate version
 	 */
 	if (ver == 0x0) {
-		printk("BIOS bug, APIC version is 0 for CPU#%d! fixing up to 0x10. (tell 
your hw vendor)\n", m->mpc_apicid);
+		printk("BIOS bug, APIC version is 0 for CPU#%d!"
+		" fixing up to 0x10 (tell your hw vendor)\n", m->mpc_apicid);
 		ver = 0x10;
 	}
 	apic_version[m->mpc_apicid] = ver;
@@ -278,12 +279,12 @@
 	if (!(m->mpc_flags & MPC_APIC_USABLE))
 		return;
 
-	printk("I/O APIC #%d Version %d at 0x%lX.\n",
+	printk(KERN_INFO "I/O APIC #%d Version %d at 0x%lX\n",
 		m->mpc_apicid, m->mpc_apicver, m->mpc_apicaddr);
 	if (nr_ioapics >= MAX_IO_APICS) {
-		printk("Max # of I/O APICs (%d) exceeded (found %d).\n",
+		printk("Max # of I/O APICs (%d) exceeded (found %d)\n",
 			MAX_IO_APICS, nr_ioapics);
-		panic("Recompile kernel with bigger MAX_IO_APICS!.\n");
+		panic("Recompile kernel with bigger MAX_IO_APICS!\n");
 	}
 	if (!m->mpc_apicaddr) {
 		printk(KERN_ERR "WARNING: bogus zero I/O APIC address"
@@ -419,7 +420,7 @@
 	}
 	memcpy(str,mpc->mpc_oem,8);
 	str[8]=0;
-	printk("OEM ID: %s ",str);
+	printk(KERN_INFO "OEM ID: %s ",str);
 
 	memcpy(str,mpc->mpc_productid,12);
 	str[12]=0;
@@ -685,12 +686,12 @@
 	config_acpi_tables();
 #endif
 	
-	printk("Intel MultiProcessor Specification v1.%d\n", 
mpf->mpf_specification);
+	printk(KERN_INFO "Intel MultiProcessor Specification v1.%d\n", 
mpf->mpf_specification);
 	if (mpf->mpf_feature2 & (1<<7)) {
-		printk("    IMCR and PIC compatibility mode.\n");
+		printk(KERN_INFO "    IMCR and PIC compatibility mode\n");
 		pic_mode = 1;
 	} else {
-		printk("    Virtual Wire compatibility mode.\n");
+		printk(KERN_INFO "    Virtual Wire compatibility mode\n");
 		pic_mode = 0;
 	}
 
@@ -735,7 +736,7 @@
 	} else
 		BUG();
 
-	printk("Processors: %d\n", num_processors);
+	printk(KERN_INFO "Processors: %d\n", num_processors);
 	/*
 	 * Only use the first configuration found.
 	 */
diff -u --recursive -x *.orig -x *.rej 
linux-2.4.19-pre2/arch/i386/kernel/mtrr.c linux-new/arch/i386/kernel/mtrr.c
--- linux-2.4.19-pre2/arch/i386/kernel/mtrr.c	Tue Mar  5 12:41:24 2002
+++ linux-new/arch/i386/kernel/mtrr.c	Mon Mar 11 11:38:03 2002
@@ -1090,12 +1090,12 @@
 {
     if (!mask) return;
     if (mask & MTRR_CHANGE_MASK_FIXED)
-	printk ("mtrr: your CPUs had inconsistent fixed MTRR settings\n");
+	printk (KERN_WARNING "mtrr: your CPUs had inconsistent fixed MTRR 
settings\n");
     if (mask & MTRR_CHANGE_MASK_VARIABLE)
-	printk ("mtrr: your CPUs had inconsistent variable MTRR settings\n");
+	printk (KERN_WARNING "mtrr: your CPUs had inconsistent variable MTRR 
settings\n");
     if (mask & MTRR_CHANGE_MASK_DEFTYPE)
-	printk ("mtrr: your CPUs had inconsistent MTRRdefType settings\n");
-    printk ("mtrr: probably your BIOS does not setup all CPUs\n");
+	printk (KERN_WARNING "mtrr: your CPUs had inconsistent MTRRdefType 
settings\n");
+    printk (KERN_WARNING "mtrr: probably your BIOS does not setup all 
CPUs\n");
 }   /*  End Function mtrr_state_warn  */
 
 #endif  /*  CONFIG_SMP  */
@@ -2199,9 +2199,9 @@
 	mtrr_if = MTRR_IF_NONE;
     }
 
-    printk ("mtrr: v%s Richard Gooch (rgooch@atnf.csiro.au)\n"
-	    "mtrr: detected mtrr type: %s\n",
-	    MTRR_VERSION, mtrr_if_name[mtrr_if]);
+    printk (KERN_INFO "mtrr: v" MTRR_VERSION " Richard Gooch 
(rgooch@atnf.csiro.au)\n"
+	    KERN_INFO "mtrr: detected mtrr type: %s\n",
+	    mtrr_if_name[mtrr_if]);
 
     return (mtrr_if != MTRR_IF_NONE);
 }   /*  End Function mtrr_setup  */
@@ -2262,7 +2262,7 @@
 	break;
     default:
 	/* I see no MTRRs I can support in SMP mode... */
-	printk ("mtrr: SMP support incomplete for this vendor\n");
+	printk (KERN_WARNING "mtrr: SMP support incomplete for this vendor\n");
     }
 }   /*  End Function mtrr_init_secondary_cpu  */
 #endif  /*  CONFIG_SMP  */
diff -u --recursive -x *.orig -x *.rej 
linux-2.4.19-pre2/arch/i386/kernel/pci-pc.c 
linux-new/arch/i386/kernel/pci-pc.c
--- linux-2.4.19-pre2/arch/i386/kernel/pci-pc.c	Tue Mar  5 12:41:24 2002
+++ linux-new/arch/i386/kernel/pci-pc.c	Mon Mar 11 11:53:19 2002
@@ -421,7 +421,7 @@
 		    pci_sanity_check(&pci_direct_conf1)) {
 			outl (tmp, 0xCF8);
 			__restore_flags(flags);
-			printk("PCI: Using configuration type 1\n");
+			printk(KERN_INFO "PCI: Using configuration type 1\n");
 			request_region(0xCF8, 8, "PCI conf1");
 			return &pci_direct_conf1;
 		}
@@ -438,7 +438,7 @@
 		if (inb (0xCF8) == 0x00 && inb (0xCFA) == 0x00 &&
 		    pci_sanity_check(&pci_direct_conf2)) {
 			__restore_flags(flags);
-			printk("PCI: Using configuration type 2\n");
+			printk(KERN_INFO "PCI: Using configuration type 2\n");
 			request_region(0xCF8, 4, "PCI conf2");
 			return &pci_direct_conf2;
 		}
@@ -546,10 +546,10 @@
 		case 0:
 			return address + entry;
 		case 0x80:	/* Not present */
-			printk("bios32_service(0x%lx): not present\n", service);
+			printk(KERN_WARNING "bios32_service(0x%lx): not present\n", service);
 			return 0;
 		default: /* Shouldn't happen */
-			printk("bios32_service(0x%lx): returned 0x%x -- BIOS bug!\n",
+			printk(KERN_WARNING "bios32_service(0x%lx): returned 0x%x -- BIOS bug!\n",
 				service, return_code);
 			return 0;
 	}
@@ -599,7 +599,7 @@
 				status, signature);
 			return 0;
 		}
-		printk("PCI: PCI BIOS revision %x.%02x entry at 0x%lx, last bus=%d\n",
+		printk(KERN_INFO "PCI: PCI BIOS revision %x.%02x entry at 0x%lx, last 
bus=%d\n",
 			major_ver, minor_ver, pcibios_entry, pcibios_last_bus);
 #ifdef CONFIG_PCI_DIRECT
 		if (!(hw_mech & PCIBIOS_HW_TYPE1))
@@ -901,7 +901,7 @@
 				}
 			}
 			if (ln == &pci_devices) {
-				printk("PCI: BIOS reporting unknown device %02x:%02x\n", bus, devfn);
+				printk(KERN_WARNING "PCI: BIOS reporting unknown device %02x:%02x\n", 
bus, devfn);
 				/*
 				 * We must not continue scanning as several buggy BIOSes
 				 * return garbage after the last device. Grr.
@@ -910,7 +910,7 @@
 			}
 		}
 		if (!found) {
-			printk("PCI: Device %02x:%02x not found by BIOS\n",
+			printk(KERN_WARNING "PCI: Device %02x:%02x not found by BIOS\n",
 				dev->bus->number, dev->devfn);
 			list_del(&dev->global_list);
 			list_add_tail(&dev->global_list, &sorted_devices);
@@ -970,7 +970,7 @@
 			rt->size = opt.size + sizeof(struct irq_routing_table);
 			rt->exclusive_irqs = map;
 			memcpy(rt->slots, (void *) page, opt.size);
-			printk("PCI: Using BIOS Interrupt Routing Table\n");
+			printk(KERN_INFO "PCI: Using BIOS Interrupt Routing Table\n");
 		}
 	}
 	free_page(page);
@@ -1035,7 +1035,7 @@
 	}
 	if (!seen_host_bridge)
 		return;
-	printk("PCI: Ignoring ghost devices on bus %02x\n", b->number);
+	printk(KERN_WARNING "PCI: Ignoring ghost devices on bus %02x\n", b->number);
 
 	ln = &b->devices;
 	while (ln->next != &b->devices) {
@@ -1073,7 +1073,7 @@
 			if (!pci_read_config_word(&dev, PCI_VENDOR_ID, &l) &&
 			    l != 0x0000 && l != 0xffff) {
 				DBG("Found device at %02x:%02x [%04x]\n", n, dev.devfn, l);
-				printk("PCI: Discovered peer bus %02x\n", n);
+				printk(KERN_INFO "PCI: Discovered peer bus %02x\n", n);
 				pci_scan_bus(n, pci_root_ops, NULL);
 				break;
 			}
@@ -1093,7 +1093,7 @@
 	u8 busno, suba, subb;
 	int quad = BUS2QUAD(d->bus->number);
 
-	printk("PCI: Searching for i450NX host bridges on %s\n", d->slot_name);
+	printk(KERN_INFO "PCI: Searching for i450NX host bridges on %s\n", 
d->slot_name);
 	reg = 0xd0;
 	for(pxb=0; pxb<2; pxb++) {
 		pci_read_config_byte(d, reg++, &busno);
@@ -1116,7 +1116,7 @@
 	 */
 	u8 busno;
 	pci_read_config_byte(d, 0x4a, &busno);
-	printk("PCI: i440KX/GX host bridge %s: secondary bus %02x\n", d->slot_name, 
busno);
+	printk(KERN_INFO "PCI: i440KX/GX host bridge %s: secondary bus %02x\n", 
d->slot_name, busno);
 	pci_scan_bus(busno, pci_root_ops, NULL);
 	pcibios_last_bus = -1;
 }
@@ -1129,7 +1129,7 @@
 	 */
 	int i;
 
-	printk("PCI: Fixing base address flags for device %s\n", d->slot_name);
+	printk(KERN_WARNING "PCI: Fixing base address flags for device %s\n", 
d->slot_name);
 	for(i=0; i<4; i++)
 		d->resource[i].flags |= PCI_BASE_ADDRESS_SPACE_IO;
 }
@@ -1280,11 +1280,11 @@
 	if (!pci_root_ops)
 		pcibios_config_init();
 	if (!pci_root_ops) {
-		printk("PCI: System does not support PCI\n");
+		printk(KERN_WARNING "PCI: System does not support PCI\n");
 		return;
 	}
 
-	printk("PCI: Probing PCI hardware\n");
+	printk(KERN_INFO "PCI: Probing PCI hardware\n");
 	pci_root_bus = pci_scan_bus(0, pci_root_ops, NULL);
 	if (clustered_apic_mode && (numnodes > 1)) {
 		for (quad = 1; quad < numnodes; ++quad) {
