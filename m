Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261979AbTCZTYd>; Wed, 26 Mar 2003 14:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261987AbTCZTYc>; Wed, 26 Mar 2003 14:24:32 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:13323 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261979AbTCZTYE>; Wed, 26 Mar 2003 14:24:04 -0500
Date: Wed, 26 Mar 2003 19:35:11 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [BK PULL] (1/9) PCMCIA changes
Message-ID: <20030326193511.C8871@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20030326193427.B8871@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030326193427.B8871@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Wed, Mar 26, 2003 at 07:34:27PM +0000
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.889.342.35 -> 1.889.359.1
#	drivers/pcmcia/i82092aa.h	1.2     -> 1.3    
#	drivers/pcmcia/pci_socket.h	1.4     -> 1.5    
#	drivers/pcmcia/ti113x.h	1.4     -> 1.5    
#	drivers/pcmcia/ricoh.h	1.4     -> 1.5    
#	drivers/pcmcia/tcic.c	1.16    -> 1.17   
#	drivers/pcmcia/hd64465_ss.c	1.11    -> 1.12   
#	drivers/pcmcia/yenta.c	1.19    -> 1.20   
#	drivers/pcmcia/sa1100_generic.c	1.26    -> 1.27   
#	drivers/pcmcia/i82365.c	1.24    -> 1.25   
#	 include/pcmcia/ss.h	1.7     -> 1.8    
#	drivers/pcmcia/pci_socket.c	1.13    -> 1.14   
#	drivers/pcmcia/i82092.c	1.13    -> 1.14   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/03/17	rmk@flint.arm.linux.org.uk	1.889.359.1
# [PCMCIA] pcmcia-2: Remove get_io_map and get_mem_map socket methods.
# 
# get_io_map and get_mem_map PCMCIA socket methods are never called
# by the PCMCIA core code.  They are therefore dead code, and can be
# removed.
# --------------------------------------------
#
diff -Nru a/drivers/pcmcia/hd64465_ss.c b/drivers/pcmcia/hd64465_ss.c
--- a/drivers/pcmcia/hd64465_ss.c	Wed Mar 26 19:18:19 2003
+++ b/drivers/pcmcia/hd64465_ss.c	Wed Mar 26 19:18:19 2003
@@ -599,21 +599,6 @@
 
 /*============================================================*/
 
-static int hs_get_io_map(unsigned int sock, struct pccard_io_map *io)
-{
-    	hs_socket_t *sp = &hs_sockets[sock];
-	int map = io->map;
-
-    	DPRINTK("hs_get_io_map(%d, %d)\n", sock, map);
-	if (map >= MAX_IO_WIN)
-	    return -EINVAL;
-	
-	*io = sp->io_maps[map];
-	return 0;
-}
-
-/*============================================================*/
-
 static int hs_set_io_map(unsigned int sock, struct pccard_io_map *io)
 {
     	hs_socket_t *sp = &hs_sockets[sock];
@@ -696,21 +681,6 @@
 
 /*============================================================*/
 
-static int hs_get_mem_map(unsigned int sock, struct pccard_mem_map *mem)
-{
-    	hs_socket_t *sp = &hs_sockets[sock];
-	int map = mem->map;
-
-    	DPRINTK("hs_get_mem_map(%d, %d)\n", sock, map);
-	if (map >= MAX_WIN)
-	    return -EINVAL;
-	
-	*mem = sp->mem_maps[map];
-	return 0;
-}
-
-/*============================================================*/
-
 static int hs_set_mem_map(unsigned int sock, struct pccard_mem_map *mem)
 {
     	hs_socket_t *sp = &hs_sockets[sock];
@@ -894,9 +864,7 @@
 	.get_status		= hs_get_status,
 	.get_socket		= hs_get_socket,
 	.set_socket		= hs_set_socket,
-	.get_io_map		= hs_get_io_map,
 	.set_io_map		= hs_set_io_map,
-	.get_mem_map		= hs_get_mem_map,
 	.set_mem_map		= hs_set_mem_map,
 	.proc_setup		= hs_proc_setup,
 };
diff -Nru a/drivers/pcmcia/i82092.c b/drivers/pcmcia/i82092.c
--- a/drivers/pcmcia/i82092.c	Wed Mar 26 19:18:20 2003
+++ b/drivers/pcmcia/i82092.c	Wed Mar 26 19:18:20 2003
@@ -63,9 +63,7 @@
 	.get_status		= i82092aa_get_status,
 	.get_socket		= i82092aa_get_socket,
 	.set_socket		= i82092aa_set_socket,
-	.get_io_map		= i82092aa_get_io_map,
 	.set_io_map		= i82092aa_set_io_map,
-	.get_mem_map		= i82092aa_get_mem_map,
 	.set_mem_map		= i82092aa_set_mem_map,
 	.proc_setup		= i82092aa_proc_setup,
 };
@@ -688,34 +686,6 @@
 	return 0;
 }
 
-static int i82092aa_get_io_map(unsigned int sock, struct pccard_io_map *io)
-{
-	unsigned char map, ioctl, addr;
-	
-	enter("i82092aa_get_io_map");
-	map = io->map;
-	if (map > 1) {
-		leave("i82092aa_get_io_map with -EINVAL");
-		return -EINVAL;
-	}
-	
-	/* FIXME: How does this fit in with the PCI resource (re)allocation */
-	io->start = indirect_read16(sock, I365_IO(map)+I365_W_START);
-	io->stop  = indirect_read16(sock, I365_IO(map)+I365_W_START);
-	
-	ioctl = indirect_read(sock,I365_IOCTL); /* IOCREG: I/O Control Register */
-	addr  = indirect_read(sock,I365_ADDRWIN); /* */
-	
-	io->speed = to_ns(ioctl & I365_IOCTL_WAIT(map)) ? 1 : 0; /* check this out later */
-	io->flags = 0;
-	
-	if (addr & I365_IOCTL_16BIT(map))
-		io->flags |= MAP_AUTOSZ;
-		
-	leave("i82092aa_get_io_map");
-	return 0;
-}
-
 static int i82092aa_set_io_map(unsigned sock, struct pccard_io_map *io)
 {
 	unsigned char map, ioctl;
@@ -757,64 +727,6 @@
 			
 	leave("i82092aa_set_io_map");	
 	return 0;
-}
-
-static int i82092aa_get_mem_map(unsigned sock, struct pccard_mem_map *mem)
-{
-	unsigned short base, i;
-	unsigned char map, addr;
-	
-	enter("i82092aa_get_mem_map");
-	
-	mem->flags = 0;
-	mem->speed = 0;
-	map = mem->map;
-	if (map > 4) {
-		leave("i82092aa_get_mem_map: -EINVAL");
-		return -EINVAL;
-	}
-	
-	addr = indirect_read(sock, I365_ADDRWIN);
-		
-	if (addr & I365_ENA_MEM(map))
-		mem->flags |= MAP_ACTIVE;		/* yes this mapping is active */
-	
-	base = I365_MEM(map); 
-	
-	/* Find the start address - this register also has mapping info */
-	
-	i = indirect_read16(sock,base+I365_W_START);
-	if (i & I365_MEM_16BIT)
-		mem->flags |= MAP_16BIT;
-	if (i & I365_MEM_0WS)
-		mem->flags |= MAP_0WS;
-	
-	mem->sys_start = ((unsigned long)(i & 0x0fff) << 12);
-	
-	/* Find the end address - this register also has speed info */
-	i = indirect_read16(sock,base+I365_W_STOP);
-	if (i & I365_MEM_WS0)
-		mem->speed = 1;
-	if (i & I365_MEM_WS1)
-		mem->speed += 2;
-	mem->speed = to_ns(mem->speed);
-	mem->sys_stop = ( (unsigned long)(i & 0x0fff) << 12) + 0x0fff;
-	
-	/* Find the card start address, also some more MAP attributes */
-	
-	i = indirect_read16(sock, base+I365_W_OFF);
-	if (i & I365_MEM_WRPROT)
-		mem->flags |= MAP_WRPROT;
-	if (i & I365_MEM_REG)
-		mem->flags |= MAP_ATTRIB;
-	mem->card_start = ( (unsigned long)(i & 0x3fff)<12) + mem->sys_start;
-	mem->card_start &=  0x3ffffff;
-	
-	printk("Card %i is from %lx to %lx \n",sock,mem->sys_start,mem->sys_stop);
-	
-	leave("i82092aa_get_mem_map");
-	return 0;
-	
 }
 
 static int i82092aa_set_mem_map(unsigned sock, struct pccard_mem_map *mem)
diff -Nru a/drivers/pcmcia/i82092aa.h b/drivers/pcmcia/i82092aa.h
--- a/drivers/pcmcia/i82092aa.h	Wed Mar 26 19:18:19 2003
+++ b/drivers/pcmcia/i82092aa.h	Wed Mar 26 19:18:19 2003
@@ -29,9 +29,7 @@
 static int i82092aa_get_status(unsigned int sock, u_int *value);
 static int i82092aa_get_socket(unsigned int sock, socket_state_t *state);
 static int i82092aa_set_socket(unsigned int sock, socket_state_t *state);
-static int i82092aa_get_io_map(unsigned int sock, struct pccard_io_map *io);
 static int i82092aa_set_io_map(unsigned int sock, struct pccard_io_map *io);
-static int i82092aa_get_mem_map(unsigned int sock, struct pccard_mem_map *mem);
 static int i82092aa_set_mem_map(unsigned int sock, struct pccard_mem_map *mem);
 static int i82092aa_init(unsigned int s);
 static int i82092aa_suspend(unsigned int sock);
diff -Nru a/drivers/pcmcia/i82365.c b/drivers/pcmcia/i82365.c
--- a/drivers/pcmcia/i82365.c	Wed Mar 26 19:18:20 2003
+++ b/drivers/pcmcia/i82365.c	Wed Mar 26 19:18:20 2003
@@ -1250,29 +1250,6 @@
 
 /*====================================================================*/
 
-static int i365_get_io_map(u_short sock, struct pccard_io_map *io)
-{
-    u_char map, ioctl, addr;
-    
-    map = io->map;
-    if (map > 1) return -EINVAL;
-    io->start = i365_get_pair(sock, I365_IO(map)+I365_W_START);
-    io->stop = i365_get_pair(sock, I365_IO(map)+I365_W_STOP);
-    ioctl = i365_get(sock, I365_IOCTL);
-    addr = i365_get(sock, I365_ADDRWIN);
-    io->speed = to_ns(ioctl & I365_IOCTL_WAIT(map)) ? 1 : 0;
-    io->flags  = (addr & I365_ENA_IO(map)) ? MAP_ACTIVE : 0;
-    io->flags |= (ioctl & I365_IOCTL_0WS(map)) ? MAP_0WS : 0;
-    io->flags |= (ioctl & I365_IOCTL_16BIT(map)) ? MAP_16BIT : 0;
-    io->flags |= (ioctl & I365_IOCTL_IOCS16(map)) ? MAP_AUTOSZ : 0;
-    DEBUG(1, "i82365: GetIOMap(%d, %d) = %#2.2x, %d ns, "
-	  "%#4.4x-%#4.4x\n", sock, map, io->flags, io->speed,
-	  io->start, io->stop);
-    return 0;
-} /* i365_get_io_map */
-
-/*====================================================================*/
-
 static int i365_set_io_map(u_short sock, struct pccard_io_map *io)
 {
     u_char map, ioctl;
@@ -1302,42 +1279,6 @@
 
 /*====================================================================*/
 
-static int i365_get_mem_map(u_short sock, struct pccard_mem_map *mem)
-{
-    u_short base, i;
-    u_char map, addr;
-    
-    map = mem->map;
-    if (map > 4) return -EINVAL;
-    addr = i365_get(sock, I365_ADDRWIN);
-    mem->flags = (addr & I365_ENA_MEM(map)) ? MAP_ACTIVE : 0;
-    base = I365_MEM(map);
-    
-    i = i365_get_pair(sock, base+I365_W_START);
-    mem->flags |= (i & I365_MEM_16BIT) ? MAP_16BIT : 0;
-    mem->flags |= (i & I365_MEM_0WS) ? MAP_0WS : 0;
-    mem->sys_start = ((u_long)(i & 0x0fff) << 12);
-    
-    i = i365_get_pair(sock, base+I365_W_STOP);
-    mem->speed  = (i & I365_MEM_WS0) ? 1 : 0;
-    mem->speed += (i & I365_MEM_WS1) ? 2 : 0;
-    mem->speed = to_ns(mem->speed);
-    mem->sys_stop = ((u_long)(i & 0x0fff) << 12) + 0x0fff;
-    
-    i = i365_get_pair(sock, base+I365_W_OFF);
-    mem->flags |= (i & I365_MEM_WRPROT) ? MAP_WRPROT : 0;
-    mem->flags |= (i & I365_MEM_REG) ? MAP_ATTRIB : 0;
-    mem->card_start = ((u_int)(i & 0x3fff) << 12) + mem->sys_start;
-    mem->card_start &= 0x3ffffff;
-    
-    DEBUG(1, "i82365: GetMemMap(%d, %d) = %#2.2x, %d ns, %#5.5lx-%#5."
-	  "5lx, %#5.5x\n", sock, mem->map, mem->flags, mem->speed,
-	  mem->sys_start, mem->sys_stop, mem->card_start);
-    return 0;
-} /* i365_get_mem_map */
-
-/*====================================================================*/
-  
 static int i365_set_mem_map(u_short sock, struct pccard_mem_map *mem)
 {
     u_short base, i;
@@ -1506,14 +1447,6 @@
 	LOCKED(i365_set_socket(sock, state));
 }
 
-static int pcic_get_io_map(unsigned int sock, struct pccard_io_map *io)
-{
-	if (socket[sock].flags & IS_ALIVE)
-		return -EINVAL;
-
-	LOCKED(i365_get_io_map(sock, io));
-}
-
 static int pcic_set_io_map(unsigned int sock, struct pccard_io_map *io)
 {
 	if (socket[sock].flags & IS_ALIVE)
@@ -1522,14 +1455,6 @@
 	LOCKED(i365_set_io_map(sock, io));
 }
 
-static int pcic_get_mem_map(unsigned int sock, struct pccard_mem_map *mem)
-{
-	if (socket[sock].flags & IS_ALIVE)
-		return -EINVAL;
-
-	LOCKED(i365_get_mem_map(sock, mem));
-}
-
 static int pcic_set_mem_map(unsigned int sock, struct pccard_mem_map *mem)
 {
 	if (socket[sock].flags & IS_ALIVE)
@@ -1571,9 +1496,7 @@
 	.get_status		= pcic_get_status,
 	.get_socket		= pcic_get_socket,
 	.set_socket		= pcic_set_socket,
-	.get_io_map		= pcic_get_io_map,
 	.set_io_map		= pcic_set_io_map,
-	.get_mem_map		= pcic_get_mem_map,
 	.set_mem_map		= pcic_set_mem_map,
 	.proc_setup		= pcic_proc_setup,
 };
diff -Nru a/drivers/pcmcia/pci_socket.c b/drivers/pcmcia/pci_socket.c
--- a/drivers/pcmcia/pci_socket.c	Wed Mar 26 19:18:20 2003
+++ b/drivers/pcmcia/pci_socket.c	Wed Mar 26 19:18:20 2003
@@ -105,15 +105,6 @@
 	return -EINVAL;
 }
 
-static int pci_get_io_map(unsigned int sock, struct pccard_io_map *io)
-{
-	pci_socket_t *socket = pci_socket_array + sock;
-
-	if (socket->op && socket->op->get_io_map)
-		return socket->op->get_io_map(socket, io);
-	return -EINVAL;
-}
-
 static int pci_set_io_map(unsigned int sock, struct pccard_io_map *io)
 {
 	pci_socket_t *socket = pci_socket_array + sock;
@@ -123,15 +114,6 @@
 	return -EINVAL;
 }
 
-static int pci_get_mem_map(unsigned int sock, struct pccard_mem_map *mem)
-{
-	pci_socket_t *socket = pci_socket_array + sock;
-
-	if (socket->op && socket->op->get_mem_map)
-		return socket->op->get_mem_map(socket, mem);
-	return -EINVAL;
-}
-
 static int pci_set_mem_map(unsigned int sock, struct pccard_mem_map *mem)
 {
 	pci_socket_t *socket = pci_socket_array + sock;
@@ -158,9 +140,7 @@
 	.get_status		= pci_get_status,
 	.get_socket		= pci_get_socket,
 	.set_socket		= pci_set_socket,
-	.get_io_map		= pci_get_io_map,
 	.set_io_map		= pci_set_io_map,
-	.get_mem_map		= pci_get_mem_map,
 	.set_mem_map		= pci_set_mem_map,
 	.proc_setup		= pci_proc_setup,
 };
diff -Nru a/drivers/pcmcia/pci_socket.h b/drivers/pcmcia/pci_socket.h
--- a/drivers/pcmcia/pci_socket.h	Wed Mar 26 19:18:19 2003
+++ b/drivers/pcmcia/pci_socket.h	Wed Mar 26 19:18:19 2003
@@ -37,9 +37,7 @@
 	int (*get_status)(struct pci_socket *, unsigned int *);
 	int (*get_socket)(struct pci_socket *, socket_state_t *);
 	int (*set_socket)(struct pci_socket *, socket_state_t *);
-	int (*get_io_map)(struct pci_socket *, struct pccard_io_map *);
 	int (*set_io_map)(struct pci_socket *, struct pccard_io_map *);
-	int (*get_mem_map)(struct pci_socket *, struct pccard_mem_map *);
 	int (*set_mem_map)(struct pci_socket *, struct pccard_mem_map *);
 	void (*proc_setup)(struct pci_socket *, struct proc_dir_entry *base);
 };
diff -Nru a/drivers/pcmcia/ricoh.h b/drivers/pcmcia/ricoh.h
--- a/drivers/pcmcia/ricoh.h	Wed Mar 26 19:18:19 2003
+++ b/drivers/pcmcia/ricoh.h	Wed Mar 26 19:18:19 2003
@@ -170,9 +170,7 @@
 	yenta_get_status,
 	yenta_get_socket,
 	yenta_set_socket,
-	yenta_get_io_map,
 	yenta_set_io_map,
-	yenta_get_mem_map,
 	yenta_set_mem_map,
 	yenta_proc_setup
 };
diff -Nru a/drivers/pcmcia/sa1100_generic.c b/drivers/pcmcia/sa1100_generic.c
--- a/drivers/pcmcia/sa1100_generic.c	Wed Mar 26 19:18:20 2003
+++ b/drivers/pcmcia/sa1100_generic.c	Wed Mar 26 19:18:20 2003
@@ -567,31 +567,6 @@
 }  /* sa1100_pcmcia_set_socket() */
 
 
-/* sa1100_pcmcia_get_io_map()
- * ^^^^^^^^^^^^^^^^^^^^^^^^^^
- * Implements the get_io_map() operation for the in-kernel PCMCIA
- * service (formerly SS_GetIOMap in Card Services). Just returns an
- * I/O map descriptor which was assigned earlier by a set_io_map().
- *
- * Returns: 0 on success, -1 if the map index was out of range
- */
-static int
-sa1100_pcmcia_get_io_map(unsigned int sock, struct pccard_io_map *map)
-{
-  struct sa1100_pcmcia_socket *skt = PCMCIA_SOCKET(sock);
-  int ret = -1;
-
-  DEBUG(2, "%s() for sock %u\n", __FUNCTION__, sock);
-
-  if (map->map < MAX_IO_WIN) {
-    *map = skt->io_map[map->map];
-    ret = 0;
-  }
-
-  return ret;
-}
-
-
 /* sa1100_pcmcia_set_io_map()
  * ^^^^^^^^^^^^^^^^^^^^^^^^^^
  * Implements the set_io_map() operation for the in-kernel PCMCIA
@@ -646,32 +621,6 @@
 }  /* sa1100_pcmcia_set_io_map() */
 
 
-/* sa1100_pcmcia_get_mem_map()
- * ^^^^^^^^^^^^^^^^^^^^^^^^^^^
- * Implements the get_mem_map() operation for the in-kernel PCMCIA
- * service (formerly SS_GetMemMap in Card Services). Just returns a
- *  memory map descriptor which was assigned earlier by a
- *  set_mem_map() request.
- *
- * Returns: 0 on success, -1 if the map index was out of range
- */
-static int
-sa1100_pcmcia_get_mem_map(unsigned int sock, struct pccard_mem_map *map)
-{
-  struct sa1100_pcmcia_socket *skt = PCMCIA_SOCKET(sock);
-  int ret = -1;
-
-  DEBUG(2, "%s() for sock %u\n", __FUNCTION__, sock);
-
-  if (map->map < MAX_WIN) {
-    *map = skt->pc_mem_map[map->map];
-    ret = 0;
-  }
-
-  return ret;
-}
-
-
 /* sa1100_pcmcia_set_mem_map()
  * ^^^^^^^^^^^^^^^^^^^^^^^^^^^
  * Implements the set_mem_map() operation for the in-kernel PCMCIA
@@ -841,9 +790,7 @@
   .get_status		= sa1100_pcmcia_get_status,
   .get_socket		= sa1100_pcmcia_get_socket,
   .set_socket		= sa1100_pcmcia_set_socket,
-  .get_io_map		= sa1100_pcmcia_get_io_map,
   .set_io_map		= sa1100_pcmcia_set_io_map,
-  .get_mem_map		= sa1100_pcmcia_get_mem_map,
   .set_mem_map		= sa1100_pcmcia_set_mem_map,
 #ifdef CONFIG_PROC_FS
   .proc_setup		= sa1100_pcmcia_proc_setup
diff -Nru a/drivers/pcmcia/tcic.c b/drivers/pcmcia/tcic.c
--- a/drivers/pcmcia/tcic.c	Wed Mar 26 19:18:19 2003
+++ b/drivers/pcmcia/tcic.c	Wed Mar 26 19:18:19 2003
@@ -805,44 +805,6 @@
   
 /*====================================================================*/
 
-static int tcic_get_io_map(unsigned int lsock, struct pccard_io_map *io)
-{
-    u_short psock = socket_table[lsock].psock;
-    u_short base, ioctl;
-    u_int addr;
-    
-    if (io->map > 1) return -EINVAL;
-    tcic_setw(TCIC_ADDR+2, TCIC_ADR2_INDREG | (psock << TCIC_SS_SHFT));
-    addr = TCIC_IWIN(psock, io->map);
-    tcic_setw(TCIC_ADDR, addr + TCIC_IBASE_X);
-    base = tcic_getw(TCIC_DATA);
-    tcic_setw(TCIC_ADDR, addr + TCIC_ICTL_X);
-    ioctl = tcic_getw(TCIC_DATA);
-
-    if (ioctl & TCIC_ICTL_TINY)
-	io->start = io->stop = base;
-    else {
-	io->start = base & (base-1);
-	io->stop = io->start + (base ^ (base-1));
-    }
-    io->speed = to_ns(ioctl & TCIC_ICTL_WSCNT_MASK);
-    io->flags  = (ioctl & TCIC_ICTL_ENA) ? MAP_ACTIVE : 0;
-    switch (ioctl & TCIC_ICTL_BW_MASK) {
-    case TCIC_ICTL_BW_DYN:
-	io->flags |= MAP_AUTOSZ; break;
-    case TCIC_ICTL_BW_16:
-	io->flags |= MAP_16BIT; break;
-    default:
-	break;
-    }
-    DEBUG(1, "tcic: GetIOMap(%d, %d) = %#2.2x, %d ns, "
-	  "%#4.4x-%#4.4x\n", lsock, io->map, io->flags,
-	  io->speed, io->start, io->stop);
-    return 0;
-} /* tcic_get_io_map */
-
-/*====================================================================*/
-
 static int tcic_set_io_map(unsigned int lsock, struct pccard_io_map *io)
 {
     u_short psock = socket_table[lsock].psock;
@@ -880,51 +842,6 @@
 
 /*====================================================================*/
 
-static int tcic_get_mem_map(unsigned int lsock, struct pccard_mem_map *mem)
-{
-    u_short psock = socket_table[lsock].psock;
-    u_short addr, ctl;
-    u_long base, mmap;
-    
-    if (mem->map > 3) return -EINVAL;
-    tcic_setw(TCIC_ADDR+2, TCIC_ADR2_INDREG | (psock << TCIC_SS_SHFT));
-    addr = TCIC_MWIN(psock, mem->map);
-    
-    tcic_setw(TCIC_ADDR, addr + TCIC_MBASE_X);
-    base = tcic_getw(TCIC_DATA);
-    if (base & TCIC_MBASE_4K_BIT) {
-	mem->sys_start = base & TCIC_MBASE_HA_MASK;
-	mem->sys_stop = mem->sys_start;
-    } else {
-	base &= TCIC_MBASE_HA_MASK;
-	mem->sys_start = (base & (base-1));
-	mem->sys_stop = mem->sys_start + (base ^ (base-1));
-    }
-    mem->sys_start = mem->sys_start << TCIC_MBASE_HA_SHFT;
-    mem->sys_stop = (mem->sys_stop << TCIC_MBASE_HA_SHFT) + 0x0fff;
-    
-    tcic_setw(TCIC_ADDR, addr + TCIC_MMAP_X);
-    mmap = tcic_getw(TCIC_DATA);
-    mem->flags = (mmap & TCIC_MMAP_REG) ? MAP_ATTRIB : 0;
-    mmap &= TCIC_MMAP_CA_MASK;
-    mem->card_start = mem->sys_start + (mmap << TCIC_MMAP_CA_SHFT);
-    mem->card_start &= 0x3ffffff;
-    
-    tcic_setw(TCIC_ADDR, addr + TCIC_MCTL_X);
-    ctl = tcic_getw(TCIC_DATA);
-    mem->flags |= (ctl & TCIC_MCTL_ENA) ? MAP_ACTIVE : 0;
-    mem->flags |= (ctl & TCIC_MCTL_B8) ? 0 : MAP_16BIT;
-    mem->flags |= (ctl & TCIC_MCTL_WP) ? MAP_WRPROT : 0;
-    mem->speed = to_ns(ctl & TCIC_MCTL_WSCNT_MASK);
-    
-    DEBUG(1, "tcic: GetMemMap(%d, %d) = %#2.2x, %d ns, "
-	  "%#5.5lx-%#5.5lx, %#5.5x\n", lsock, mem->map, mem->flags,
-	  mem->speed, mem->sys_start, mem->sys_stop, mem->card_start);
-    return 0;
-} /* tcic_get_mem_map */
-
-/*====================================================================*/
-  
 static int tcic_set_mem_map(unsigned int lsock, struct pccard_mem_map *mem)
 {
     u_short psock = socket_table[lsock].psock;
@@ -1006,9 +923,7 @@
 	.get_status	   = tcic_get_status,
 	.get_socket	   = tcic_get_socket,
 	.set_socket	   = tcic_set_socket,
-	.get_io_map	   = tcic_get_io_map,
 	.set_io_map	   = tcic_set_io_map,
-	.get_mem_map	   = tcic_get_mem_map,
 	.set_mem_map	   = tcic_set_mem_map,
 	.proc_setup	   = tcic_proc_setup,
 };
diff -Nru a/drivers/pcmcia/ti113x.h b/drivers/pcmcia/ti113x.h
--- a/drivers/pcmcia/ti113x.h	Wed Mar 26 19:18:19 2003
+++ b/drivers/pcmcia/ti113x.h	Wed Mar 26 19:18:19 2003
@@ -185,9 +185,7 @@
 	yenta_get_status,
 	yenta_get_socket,
 	yenta_set_socket,
-	yenta_get_io_map,
 	yenta_set_io_map,
-	yenta_get_mem_map,
 	yenta_set_mem_map,
 	yenta_proc_setup
 };
@@ -230,9 +228,7 @@
 	yenta_get_status,
 	yenta_get_socket,
 	yenta_set_socket,
-	yenta_get_io_map,
 	yenta_set_io_map,
-	yenta_get_mem_map,
 	yenta_set_mem_map,
 	yenta_proc_setup
 };
@@ -272,9 +268,7 @@
 	yenta_get_status,
 	yenta_get_socket,
 	yenta_set_socket,
-	yenta_get_io_map,
 	yenta_set_io_map,
-	yenta_get_mem_map,
 	yenta_set_mem_map,
 	yenta_proc_setup
 };
diff -Nru a/drivers/pcmcia/yenta.c b/drivers/pcmcia/yenta.c
--- a/drivers/pcmcia/yenta.c	Wed Mar 26 19:18:19 2003
+++ b/drivers/pcmcia/yenta.c	Wed Mar 26 19:18:19 2003
@@ -27,7 +27,7 @@
 #include "i82365.h"
 
 #if 0
-#define DEBUG(x,args...)	printk(__FUNCTION__ ": " x,##args)
+#define DEBUG(x,args...)	printk("%s: " x, __FUNCTION__, ##args)
 #else
 #define DEBUG(x,args...)
 #endif
@@ -300,29 +300,6 @@
 	return 0;
 }
 
-static int yenta_get_io_map(pci_socket_t *socket, struct pccard_io_map *io)
-{
-	int map;
-	unsigned char ioctl, addr;
-
-	map = io->map;
-	if (map > 1)
-		return -EINVAL;
-
-	io->start = exca_readw(socket, I365_IO(map)+I365_W_START);
-	io->stop = exca_readw(socket, I365_IO(map)+I365_W_STOP);
-
-	ioctl = exca_readb(socket, I365_IOCTL);
-	addr = exca_readb(socket, I365_ADDRWIN);
-	io->speed = to_ns(ioctl & I365_IOCTL_WAIT(map)) ? 1 : 0;
-	io->flags  = (addr & I365_ENA_IO(map)) ? MAP_ACTIVE : 0;
-	io->flags |= (ioctl & I365_IOCTL_0WS(map)) ? MAP_0WS : 0;
-	io->flags |= (ioctl & I365_IOCTL_16BIT(map)) ? MAP_16BIT : 0;
-	io->flags |= (ioctl & I365_IOCTL_IOCS16(map)) ? MAP_AUTOSZ : 0;
-
-	return 0;
-}
-
 static int yenta_set_io_map(pci_socket_t *socket, struct pccard_io_map *io)
 {
 	int map;
@@ -356,41 +333,6 @@
 	return 0;
 }
 
-static int yenta_get_mem_map(pci_socket_t *socket, struct pccard_mem_map *mem)
-{
-	int map;
-	unsigned char addr;
-	unsigned int start, stop, page, offset;
-
-	map = mem->map;
-	if (map > 4)
-		return -EINVAL;
-
-	addr = exca_readb(socket, I365_ADDRWIN);
-	mem->flags = (addr & I365_ENA_MEM(map)) ? MAP_ACTIVE : 0;
-
-	start = exca_readw(socket, I365_MEM(map) + I365_W_START);
-	mem->flags |= (start & I365_MEM_16BIT) ? MAP_16BIT : 0;
-	mem->flags |= (start & I365_MEM_0WS) ? MAP_0WS : 0;
-	start = (start & 0x0fff) << 12;
-
-	stop = exca_readw(socket, I365_MEM(map) + I365_W_STOP);
-	mem->speed = to_ns(stop >> 14);
-	stop = ((stop & 0x0fff) << 12) + 0x0fff;
-
-	offset = exca_readw(socket, I365_MEM(map) + I365_W_OFF);
-	mem->flags |= (offset & I365_MEM_WRPROT) ? MAP_WRPROT : 0;
-	mem->flags |= (offset & I365_MEM_REG) ? MAP_ATTRIB : 0;
-	offset = ((offset & 0x3fff) << 12) + start;
-	mem->card_start = offset & 0x3ffffff;
-
-	page = exca_readb(socket, CB_MEM_PAGE(map)) << 24;
-	mem->sys_start = start + page;
-	mem->sys_stop = start + page;
-
-	return 0;
-}
-
 static int yenta_set_mem_map(pci_socket_t *socket, struct pccard_mem_map *mem)
 {
 	int map;
@@ -935,9 +877,7 @@
 	yenta_get_status,
 	yenta_get_socket,
 	yenta_set_socket,
-	yenta_get_io_map,
 	yenta_set_io_map,
-	yenta_get_mem_map,
 	yenta_set_mem_map,
 	yenta_proc_setup
 };
diff -Nru a/include/pcmcia/ss.h b/include/pcmcia/ss.h
--- a/include/pcmcia/ss.h	Wed Mar 26 19:18:20 2003
+++ b/include/pcmcia/ss.h	Wed Mar 26 19:18:20 2003
@@ -134,9 +134,7 @@
 	int (*get_status)(unsigned int sock, u_int *value);
 	int (*get_socket)(unsigned int sock, socket_state_t *state);
 	int (*set_socket)(unsigned int sock, socket_state_t *state);
-	int (*get_io_map)(unsigned int sock, struct pccard_io_map *io);
 	int (*set_io_map)(unsigned int sock, struct pccard_io_map *io);
-	int (*get_mem_map)(unsigned int sock, struct pccard_mem_map *mem);
 	int (*set_mem_map)(unsigned int sock, struct pccard_mem_map *mem);
 	void (*proc_setup)(unsigned int sock, struct proc_dir_entry *base);
 };

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

