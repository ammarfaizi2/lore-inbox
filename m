Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266472AbUG0RQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266472AbUG0RQq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 13:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266473AbUG0RQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 13:16:46 -0400
Received: from ozlabs.org ([203.10.76.45]:24542 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266472AbUG0RPF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 13:15:05 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16646.36181.74926.339375@cargo.ozlabs.ibm.com>
Date: Tue, 27 Jul 2004 12:13:57 -0500
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: anton@samba.org, linux-kernel@vger.kernel.org, linas@linas.org
Subject: [PATCH] PPC64 whitespace cleanup in prom.c
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch, originally from Linas Vepstas, cleans up some wonky
indentation and other formatting issues in arch/ppc64/kernel/prom.c.
It does not change any actual code.

Signed-off-by: Linas Vepstas <linas@linas.org>
Signed-off-by: Paul Mackerras <paulus@samba.org>

--- linux-2.5/arch/ppc64/kernel/prom.c	2004-07-24 04:25:06.000000000 +1000
+++ test25/arch/ppc64/kernel/prom.c	2004-07-28 03:03:00.851971936 +1000
@@ -199,16 +199,16 @@
 	unsigned long offset = reloc_offset();
 	struct prom_t *_prom = PTRRELOC(&prom);
 	va_list list;
-        
+
 	_prom->args.service = ADDR(service);
 	_prom->args.nargs = nargs;
 	_prom->args.nret = nret;
-        _prom->args.rets = (prom_arg_t *)&(_prom->args.args[nargs]);
+	_prom->args.rets = (prom_arg_t *)&(_prom->args.args[nargs]);
 
-        va_start(list, nret);
+	va_start(list, nret);
 	for (i=0; i < nargs; i++)
 		_prom->args.args[i] = va_arg(list, prom_arg_t);
-        va_end(list);
+	va_end(list);
 
 	for (i=0; i < nret ;i++)
 		_prom->args.rets[i] = 0;
@@ -244,17 +244,17 @@
 static void __init prom_print_hex(unsigned long val)
 {
 	unsigned long offset = reloc_offset();
-        int i, nibbles = sizeof(val)*2;
-        char buf[sizeof(val)*2+1];
+	int i, nibbles = sizeof(val)*2;
+	char buf[sizeof(val)*2+1];
 	struct prom_t *_prom = PTRRELOC(&prom);
 
-        for (i = nibbles-1;  i >= 0;  i--) {
-                buf[i] = (val & 0xf) + '0';
-                if (buf[i] > '9')
-                    buf[i] += ('a'-'0'-10);
-                val >>= 4;
-        }
-        buf[nibbles] = '\0';
+	for (i = nibbles-1;  i >= 0;  i--) {
+		buf[i] = (val & 0xf) + '0';
+		if (buf[i] > '9')
+			buf[i] += ('a'-'0'-10);
+		val >>= 4;
+	}
+	buf[nibbles] = '\0';
 	call_prom("write", 3, 1, _prom->stdout, buf, nibbles);
 }
 
@@ -343,22 +343,22 @@
 {
 	phandle node;
 	char type[64];
-        unsigned long num_cpus = 0;
-        unsigned long offset = reloc_offset();
+	unsigned long num_cpus = 0;
+	unsigned long offset = reloc_offset();
 	struct prom_t *_prom = PTRRELOC(&prom);
-        struct naca_struct *_naca = RELOC(naca);
-        struct systemcfg *_systemcfg = RELOC(systemcfg);
+	struct naca_struct *_naca = RELOC(naca);
+	struct systemcfg *_systemcfg = RELOC(systemcfg);
 
 	/* NOTE: _naca->debug_switch is already initialized. */
 	prom_debug("prom_initialize_naca: start...\n");
 
 	_naca->pftSize = 0;	/* ilog2 of htab size.  computed below. */
 
-        for (node = 0; prom_next_node(&node); ) {
-                type[0] = 0;
+	for (node = 0; prom_next_node(&node); ) {
+		type[0] = 0;
 		prom_getprop(node, "device_type", type, sizeof(type));
 
-                if (!strcmp(type, RELOC("cpu"))) {
+		if (!strcmp(type, RELOC("cpu"))) {
 			num_cpus += 1;
 
 			/* We're assuming *all* of the CPUs have the same
@@ -404,7 +404,7 @@
 					_naca->pftSize = pft_size[1];
 				}
 			}
-                } else if (!strcmp(type, RELOC("serial"))) {
+		} else if (!strcmp(type, RELOC("serial"))) {
 			phandle isa, pci;
 			struct isa_reg_property reg;
 			union pci_range ranges;
@@ -435,7 +435,7 @@
 					((((unsigned long)ranges.pci64.phys_hi) << 32) |
 					 (ranges.pci64.phys_lo)) + reg.address;
 			}
-                }
+		}
 	}
 
 	if (_systemcfg->platform == PLATFORM_POWERMAC)
@@ -465,8 +465,8 @@
 	}
 
 	/* We gotta have at least 1 cpu... */
-        if ( (_systemcfg->processorCount = num_cpus) < 1 )
-                PROM_BUG();
+	if ( (_systemcfg->processorCount = num_cpus) < 1 )
+		PROM_BUG();
 
 	_systemcfg->physicalMemorySize = lmb_phys_mem_size();
 
@@ -496,21 +496,21 @@
 	_systemcfg->version.minor = SYSTEMCFG_MINOR;
 	_systemcfg->processor = _get_PVR();
 
-        prom_debug("systemcfg->processorCount       = 0x%x\n",
+	prom_debug("systemcfg->processorCount       = 0x%x\n",
 		   _systemcfg->processorCount);
-        prom_debug("systemcfg->physicalMemorySize   = 0x%x\n",
+	prom_debug("systemcfg->physicalMemorySize   = 0x%x\n",
 		   _systemcfg->physicalMemorySize);
-        prom_debug("naca->pftSize                   = 0x%x\n",
+	prom_debug("naca->pftSize                   = 0x%x\n",
 		   _naca->pftSize);
-        prom_debug("systemcfg->dCacheL1LineSize     = 0x%x\n",
+	prom_debug("systemcfg->dCacheL1LineSize     = 0x%x\n",
 		   _systemcfg->dCacheL1LineSize);
-        prom_debug("systemcfg->iCacheL1LineSize     = 0x%x\n",
+	prom_debug("systemcfg->iCacheL1LineSize     = 0x%x\n",
 		   _systemcfg->iCacheL1LineSize);
-        prom_debug("naca->serialPortAddr            = 0x%x\n",
+	prom_debug("naca->serialPortAddr            = 0x%x\n",
 		   _naca->serialPortAddr);
-        prom_debug("naca->interrupt_controller      = 0x%x\n",
+	prom_debug("naca->interrupt_controller      = 0x%x\n",
 		   _naca->interrupt_controller);
-        prom_debug("systemcfg->platform             = 0x%x\n",
+	prom_debug("systemcfg->platform             = 0x%x\n",
 		   _systemcfg->platform);
 	prom_debug("prom_initialize_naca: end...\n");
 }
@@ -547,36 +547,36 @@
 #ifdef DEBUG_PROM
 void prom_dump_lmb(void)
 {
-        unsigned long i;
-        unsigned long offset = reloc_offset();
+	unsigned long i;
+	unsigned long offset = reloc_offset();
 	struct lmb *_lmb  = PTRRELOC(&lmb);
 
-        prom_printf("\nprom_dump_lmb:\n");
-        prom_printf("    memory.cnt                  = 0x%x\n",
+	prom_printf("\nprom_dump_lmb:\n");
+	prom_printf("    memory.cnt		  = 0x%x\n",
 		    _lmb->memory.cnt);
-        prom_printf("    memory.size                 = 0x%x\n",
+	prom_printf("    memory.size		 = 0x%x\n",
 		    _lmb->memory.size);
-        for (i=0; i < _lmb->memory.cnt ;i++) {
-                prom_printf("    memory.region[0x%x].base       = 0x%x\n",
+	for (i=0; i < _lmb->memory.cnt ;i++) {
+		prom_printf("    memory.region[0x%x].base       = 0x%x\n",
 			    i, _lmb->memory.region[i].base);
-                prom_printf("                      .physbase = 0x%x\n",
+		prom_printf("		      .physbase = 0x%x\n",
 			    _lmb->memory.region[i].physbase);
-                prom_printf("                      .size     = 0x%x\n",
+		prom_printf("		      .size     = 0x%x\n",
 			    _lmb->memory.region[i].size);
-        }
+	}
 
-        prom_printf("\n    reserved.cnt                  = 0x%x\n",
+	prom_printf("\n    reserved.cnt		  = 0x%x\n",
 		    _lmb->reserved.cnt);
-        prom_printf("    reserved.size                 = 0x%x\n",
+	prom_printf("    reserved.size		 = 0x%x\n",
 		    _lmb->reserved.size);
-        for (i=0; i < _lmb->reserved.cnt ;i++) {
-                prom_printf("    reserved.region[0x%x\n].base       = 0x%x\n",
+	for (i=0; i < _lmb->reserved.cnt ;i++) {
+		prom_printf("    reserved.region[0x%x\n].base       = 0x%x\n",
 			    i, _lmb->reserved.region[i].base);
-                prom_printf("                      .physbase = 0x%x\n",
+		prom_printf("		      .physbase = 0x%x\n",
 			    _lmb->reserved.region[i].physbase);
-                prom_printf("                      .size     = 0x%x\n",
+		prom_printf("		      .size     = 0x%x\n",
 			    _lmb->reserved.region[i].size);
-        }
+	}
 }
 #endif /* DEBUG_PROM */
 
@@ -584,9 +584,9 @@
 {
 	phandle node;
 	char type[64];
-        unsigned long i, offset = reloc_offset();
+	unsigned long i, offset = reloc_offset();
 	struct prom_t *_prom = PTRRELOC(&prom);
-        struct systemcfg *_systemcfg = RELOC(systemcfg);
+	struct systemcfg *_systemcfg = RELOC(systemcfg);
 	union lmb_reg_property reg;
 	unsigned long lmb_base, lmb_size;
 	unsigned long num_regs, bytes_per_reg = (_prom->encode_phys_size*2)/8;
@@ -599,11 +599,11 @@
 	if (_systemcfg->platform == PLATFORM_POWERMAC)
 		bytes_per_reg = 12;
 
-        for (node = 0; prom_next_node(&node); ) {
-                type[0] = 0;
-                prom_getprop(node, "device_type", type, sizeof(type));
+	for (node = 0; prom_next_node(&node); ) {
+		type[0] = 0;
+		prom_getprop(node, "device_type", type, sizeof(type));
 
-                if (strcmp(type, RELOC("memory")))
+		if (strcmp(type, RELOC("memory")))
 			continue;
 
 		num_regs = prom_getprop(node, "reg", &reg, sizeof(reg))
@@ -651,7 +651,7 @@
 	struct rtas_t *_rtas = PTRRELOC(&rtas);
 	struct systemcfg *_systemcfg = RELOC(systemcfg);
 	ihandle prom_rtas;
-        u32 getprop_rval;
+	u32 getprop_rval;
 	char hypertas_funcs[4];
 
 	prom_debug("prom_instantiate_rtas: start...\n");
@@ -669,7 +669,7 @@
 
 		prom_getprop(prom_rtas, "rtas-size",
 			     &getprop_rval, sizeof(getprop_rval));
-	        _rtas->size = getprop_rval;
+		_rtas->size = getprop_rval;
 		prom_printf("instantiating rtas");
 		if (_rtas->size != 0) {
 			unsigned long rtas_region = RTAS_INSTANTIATE_MAX;
@@ -707,9 +707,9 @@
 			prom_printf(" done\n");
 		}
 
-        	prom_debug("rtas->base                = 0x%x\n", _rtas->base);
-        	prom_debug("rtas->entry               = 0x%x\n", _rtas->entry);
-        	prom_debug("rtas->size                = 0x%x\n", _rtas->size);
+		prom_debug("rtas->base		= 0x%x\n", _rtas->base);
+		prom_debug("rtas->entry	       = 0x%x\n", _rtas->entry);
+		prom_debug("rtas->size		= 0x%x\n", _rtas->size);
 	}
 	prom_debug("prom_instantiate_rtas: end...\n");
 }
@@ -744,7 +744,7 @@
 {
 	phandle node;
 	ihandle phb_node;
-        unsigned long offset = reloc_offset();
+	unsigned long offset = reloc_offset();
 	char compatible[64], path[64], type[64], model[64];
 	unsigned long i, table = 0;
 	unsigned long base, vbase, align;
@@ -775,9 +775,9 @@
 
 		/* Keep the old logic in tack to avoid regression. */
 		if (compatible[0] != 0) {
-			if((strstr(compatible, RELOC("python")) == NULL) &&
-			   (strstr(compatible, RELOC("Speedwagon")) == NULL) &&
-			   (strstr(compatible, RELOC("Winnipeg")) == NULL))
+			if ((strstr(compatible, RELOC("python")) == NULL) &&
+			    (strstr(compatible, RELOC("Speedwagon")) == NULL) &&
+			    (strstr(compatible, RELOC("Winnipeg")) == NULL))
 				continue;
 		} else if (model[0] != 0) {
 			if ((strstr(model, RELOC("ython")) == NULL) &&
@@ -853,21 +853,21 @@
 		/* Call OF to setup the TCE hardware */
 		if (call_prom("package-to-path", 3, 1, node,
 			      path, sizeof(path)-1) == PROM_ERROR) {
-                        prom_printf("package-to-path failed\n");
-                } else {
-                        prom_printf("opening PHB %s", path);
-                }
-
-                phb_node = call_prom("open", 1, 1, path);
-                if ( (long)phb_node <= 0) {
-                        prom_printf("... failed\n");
-                } else {
-                        prom_printf("... done\n");
-                }
-                call_prom("call-method", 6, 0, ADDR("set-64-bit-addressing"),
+			prom_printf("package-to-path failed\n");
+		} else {
+			prom_printf("opening PHB %s", path);
+		}
+
+		phb_node = call_prom("open", 1, 1, path);
+		if ( (long)phb_node <= 0) {
+			prom_printf("... failed\n");
+		} else {
+			prom_printf("... done\n");
+		}
+		call_prom("call-method", 6, 0, ADDR("set-64-bit-addressing"),
 			  phb_node, -1, minsize,
 			  (u32) base, (u32) (base >> 32));
-                call_prom("close", 1, 0, phb_node);
+		call_prom("close", 1, 0, phb_node);
 
 		table++;
 	}
@@ -910,15 +910,15 @@
 	unsigned int cpu_threads, hw_cpu_num;
 	int propsize;
 	extern void __secondary_hold(void);
-        extern unsigned long __secondary_hold_spinloop;
-        extern unsigned long __secondary_hold_acknowledge;
-        unsigned long *spinloop
+	extern unsigned long __secondary_hold_spinloop;
+	extern unsigned long __secondary_hold_acknowledge;
+	unsigned long *spinloop
 		= (void *)virt_to_abs(&__secondary_hold_spinloop);
-        unsigned long *acknowledge
+	unsigned long *acknowledge
 		= (void *)virt_to_abs(&__secondary_hold_acknowledge);
-        unsigned long secondary_hold
+	unsigned long secondary_hold
 		= virt_to_abs(*PTRRELOC((unsigned long *)__secondary_hold));
-        struct systemcfg *_systemcfg = RELOC(systemcfg);
+	struct systemcfg *_systemcfg = RELOC(systemcfg);
 	struct paca_struct *lpaca = PTRRELOC(&paca[0]);
 	struct prom_t *_prom = PTRRELOC(&prom);
 #ifdef CONFIG_SMP
@@ -962,12 +962,12 @@
 	prom_debug("    1) *acknowledge   = 0x%x\n", *acknowledge);
 	prom_debug("    1) secondary_hold = 0x%x\n", secondary_hold);
 
-        /* Set the common spinloop variable, so all of the secondary cpus
+	/* Set the common spinloop variable, so all of the secondary cpus
 	 * will block when they are awakened from their OF spinloop.
 	 * This must occur for both SMP and non SMP kernels, since OF will
 	 * be trashed when we move the kernel.
-         */
-        *spinloop = 0;
+	 */
+	*spinloop = 0;
 
 #ifdef CONFIG_HMT
 	for (i=0; i < NR_CPUS; i++) {
@@ -986,7 +986,7 @@
 		if (strcmp(type, RELOC("okay")) != 0)
 			continue;
 
-                reg = -1;
+		reg = -1;
 		prom_getprop(node, "reg", &reg, sizeof(reg));
 
 		path = (char *) mem;
@@ -1124,7 +1124,7 @@
 	ihandle prom_options = 0;
 	char option[9];
 	unsigned long offset = reloc_offset();
-        struct naca_struct *_naca = RELOC(naca);
+	struct naca_struct *_naca = RELOC(naca);
 	char found = 0;
 
 	if (strstr(RELOC(cmd_line), RELOC("smt-enabled="))) {
@@ -1253,10 +1253,10 @@
 	struct prom_t *_prom = PTRRELOC(&prom);
 	u32 val;
 
-        if (prom_getprop(_prom->chosen, "stdout", &val, sizeof(val)) <= 0)
-                prom_panic("cannot find stdout");
+	if (prom_getprop(_prom->chosen, "stdout", &val, sizeof(val)) <= 0)
+		prom_panic("cannot find stdout");
 
-        _prom->stdout = val;
+	_prom->stdout = val;
 }
 
 static int __init prom_find_machine_type(void)
@@ -1306,7 +1306,7 @@
 	ihandle ih;
 	int i, j;
 	unsigned long offset = reloc_offset();
-        struct prom_t *_prom = PTRRELOC(&prom);
+	struct prom_t *_prom = PTRRELOC(&prom);
 	char type[16], *path;
 	static unsigned char default_colors[] = {
 		0x00, 0x00, 0x00,
@@ -1403,7 +1403,7 @@
 				break;
 #endif /* CONFIG_LOGO_LINUX_CLUT224 */
 	}
-	
+
 	return DOUBLEWORD_ALIGN(mem);
 }
 
@@ -1592,7 +1592,7 @@
 {
 	struct bi_record *first, *last;
 
-  	prom_debug("birec_verify: r6=0x%x\n", (unsigned long)bi_recs);
+	prom_debug("birec_verify: r6=0x%x\n", (unsigned long)bi_recs);
 	if (bi_recs != NULL)
 		prom_debug("  tag=0x%x\n", bi_recs->tag);
 
@@ -1601,7 +1601,7 @@
 
 	last = (struct bi_record *)(long)bi_recs->data[0];
 
-  	prom_debug("  last=0x%x\n", (unsigned long)last);
+	prom_debug("  last=0x%x\n", (unsigned long)last);
 	if (last != NULL)
 		prom_debug("  last_tag=0x%x\n", last->tag);
 
@@ -1609,7 +1609,7 @@
 		return NULL;
 
 	first = (struct bi_record *)(long)last->data[0];
-  	prom_debug("  first=0x%x\n", (unsigned long)first);
+	prom_debug("  first=0x%x\n", (unsigned long)first);
 
 	if ( first == NULL || first != bi_recs )
 		return NULL;
@@ -1681,9 +1681,9 @@
 	/* Init prom stdout device */
 	prom_init_stdout();
 
-  	prom_debug("klimit=0x%x\n", RELOC(klimit));
-  	prom_debug("offset=0x%x\n", offset);
-  	prom_debug("->mem=0x%x\n", RELOC(klimit) - offset);
+	prom_debug("klimit=0x%x\n", RELOC(klimit));
+	prom_debug("offset=0x%x\n", offset);
+	prom_debug("->mem=0x%x\n", RELOC(klimit) - offset);
 
 	/* check out if we have bi_recs */
 	_prom->bi_recs = prom_bi_rec_verify((struct bi_record *)r6);
@@ -1713,7 +1713,7 @@
 		copy_and_flush(0, KERNELBASE - offset, 0x100, 0);
 
 	/* Start storing things at klimit */
-      	mem = RELOC(klimit) - offset;
+	mem = RELOC(klimit) - offset;
 
 	/* Get the full OF pathname of the stdout device */
 	p = (char *) mem;
@@ -1728,9 +1728,9 @@
 	_prom->encode_phys_size = (getprop_rval == 1) ? 32 : 64;
 
 	/* Determine which cpu is actually running right _now_ */
-        if (prom_getprop(_prom->chosen, "cpu",
+	if (prom_getprop(_prom->chosen, "cpu",
 			 &prom_cpu, sizeof(prom_cpu)) <= 0)
-                prom_panic("cannot find boot cpu");
+		prom_panic("cannot find boot cpu");
 
 	cpu_pkg = call_prom("instance-to-package", 1, 1, prom_cpu);
 	prom_getprop(cpu_pkg, "reg", &getprop_rval, sizeof(getprop_rval));
@@ -1739,7 +1739,7 @@
 
 	RELOC(boot_cpuid) = 0;
 
-  	prom_debug("Booting CPU hw index = 0x%x\n", _prom->cpu);
+	prom_debug("Booting CPU hw index = 0x%x\n", _prom->cpu);
 
 	/* Get the boot device and translate it to a full OF pathname. */
 	p = (char *) mem;
@@ -1773,18 +1773,18 @@
 	if (_systemcfg->platform != PLATFORM_POWERMAC)
 		prom_instantiate_rtas();
 
-        /* Initialize some system info into the Naca early... */
-        prom_initialize_naca();
+	/* Initialize some system info into the Naca early... */
+	prom_initialize_naca();
 
 	smt_setup();
 
-        /* If we are on an SMP machine, then we *MUST* do the
-         * following, regardless of whether we have an SMP
-         * kernel or not.
-         */
+	/* If we are on an SMP machine, then we *MUST* do the
+	 * following, regardless of whether we have an SMP
+	 * kernel or not.
+	 */
 	prom_hold_cpus(mem);
 
-  	prom_debug("after basic inits, mem=0x%x\n", mem);
+	prom_debug("after basic inits, mem=0x%x\n", mem);
 #ifdef CONFIG_BLK_DEV_INITRD
 	prom_debug("initrd_start=0x%x\n", RELOC(initrd_start));
 	prom_debug("initrd_end=0x%x\n", RELOC(initrd_end));
@@ -1796,7 +1796,7 @@
 	RELOC(klimit) = mem + offset;
 
 	prom_debug("new klimit is\n");
-  	prom_debug("klimit=0x%x\n", RELOC(klimit));
+	prom_debug("klimit=0x%x\n", RELOC(klimit));
 	prom_debug(" ->mem=0x%x\n", mem);
 
 	lmb_reserve(0, __pa(RELOC(klimit)));
@@ -2082,7 +2082,7 @@
 		i = 0;
 		adr = (struct address_range *) mem_start;
 		while ((l -= sizeof(struct pci_reg_property)) >= 0) {
- 			if (!measure_only) {
+			if (!measure_only) {
 				adr[i].space = pci_addrs[i].addr.a_hi;
 				adr[i].address = pci_addrs[i].addr.a_lo;
 				adr[i].size = pci_addrs[i].size_lo;
@@ -2121,7 +2121,7 @@
 		i = 0;
 		adr = (struct address_range *) mem_start;
 		while ((l -= sizeof(struct reg_property32)) >= 0) {
- 			if (!measure_only) {
+			if (!measure_only) {
 				adr[i].space = 2;
 				adr[i].address = rp[i].address + base_address;
 				adr[i].size = rp[i].size;
@@ -2161,7 +2161,7 @@
 		i = 0;
 		adr = (struct address_range *) mem_start;
 		while ((l -= sizeof(struct reg_property32)) >= 0) {
- 			if (!measure_only) {
+			if (!measure_only) {
 				adr[i].space = 2;
 				adr[i].address = rp[i].address + base_address;
 				adr[i].size = rp[i].size;
@@ -2189,7 +2189,7 @@
 		i = 0;
 		adr = (struct address_range *) mem_start;
 		while ((l -= sizeof(struct reg_property)) >= 0) {
- 			if (!measure_only) {
+			if (!measure_only) {
 				adr[i].space = rp[i].space;
 				adr[i].address = rp[i].address;
 				adr[i].size = rp[i].size;
@@ -2218,7 +2218,7 @@
 		i = 0;
 		adr = (struct address_range *) mem_start;
 		while ((l -= rpsize) >= 0) {
- 			if (!measure_only) {
+			if (!measure_only) {
 				adr[i].space = 0;
 				adr[i].address = rp[naddrc - 1];
 				adr[i].size = rp[naddrc + nsizec - 1];
@@ -2296,7 +2296,7 @@
 	return mem_start;
 }
 
-/*
+/**
  * finish_device_tree is called once things are running normally
  * (i.e. with text and data mapped to the address they were linked at).
  * It traverses the device tree and fills in the name, type,
@@ -2347,7 +2347,7 @@
 	return 1;
 }
 
-/*
+/**
  * Work out the sense (active-low level / active-high edge)
  * of each interrupt from the device tree.
  */
@@ -2369,7 +2369,7 @@
 	}
 }
 
-/*
+/**
  * Construct and return a list of the device_nodes with a given name.
  */
 struct device_node *
@@ -2388,7 +2388,7 @@
 	return head;
 }
 
-/*
+/**
  * Construct and return a list of the device_nodes with a given type.
  */
 struct device_node *
@@ -2407,7 +2407,7 @@
 	return head;
 }
 
-/*
+/**
  * Returns all nodes linked together
  */
 struct device_node *
@@ -2424,7 +2424,7 @@
 	return head;
 }
 
-/* Checks if the given "compat" string matches one of the strings in
+/** Checks if the given "compat" string matches one of the strings in
  * the device's "compatible" property
  */
 int
@@ -2448,7 +2448,7 @@
 }
 
 
-/*
+/**
  * Indicates whether the root node has a given value in its
  * compatible property.
  */
@@ -2457,7 +2457,7 @@
 {
 	struct device_node *root;
 	int rc = 0;
-  
+
 	root = of_find_node_by_path("/");
 	if (root) {
 		rc = device_is_compatible(root, compat);
@@ -2466,7 +2466,7 @@
 	return rc;
 }
 
-/*
+/**
  * Construct and return a list of the device_nodes with a given type
  * and compatible property.
  */
@@ -2489,7 +2489,7 @@
 	return head;
 }
 
-/*
+/**
  * Find the device_node with a given full_name.
  */
 struct device_node *
@@ -2904,7 +2904,7 @@
 	u32 *regs;
 	int err = 0;
 	phandle *ibm_phandle;
- 
+
 	node->name = get_property(node, "name", NULL);
 	node->type = get_property(node, "device_type", NULL);
 
@@ -2957,27 +2957,26 @@
 		if (err) goto out;
 	}
 
-       /* now do the rough equivalent of update_dn_pci_info, this
-        * probably is not correct for phb's, but should work for
-	* IOAs and slots.
-        */
-
-       node->phb = parent->phb;
-
-       regs = (u32 *)get_property(node, "reg", NULL);
-       if (regs) {
-               node->busno = (regs[0] >> 16) & 0xff;
-               node->devfn = (regs[0] >> 8) & 0xff;
-       }
+	/* now do the rough equivalent of update_dn_pci_info, this
+	 * probably is not correct for phb's, but should work for
+	 * IOAs and slots.
+	 */
+
+	node->phb = parent->phb;
+
+	regs = (u32 *)get_property(node, "reg", NULL);
+	if (regs) {
+		node->busno = (regs[0] >> 16) & 0xff;
+		node->devfn = (regs[0] >> 8) & 0xff;
+	}
 
 	/* fixing up iommu_table */
 
-	if(strcmp(node->name, "pci") == 0 &&
-                get_property(node, "ibm,dma-window", NULL)) {
-                node->bussubno = node->busno;
-                iommu_devnode_init(node);
-        }
-	else
+	if (strcmp(node->name, "pci") == 0 &&
+	    get_property(node, "ibm,dma-window", NULL)) {
+		node->bussubno = node->busno;
+		iommu_devnode_init(node);
+	} else
 		node->iommu_table = parent->iommu_table;
 
 out:
