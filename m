Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315414AbSEGLml>; Tue, 7 May 2002 07:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315415AbSEGLmk>; Tue, 7 May 2002 07:42:40 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:29963 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S315414AbSEGLme>;
	Tue, 7 May 2002 07:42:34 -0400
Date: Tue, 7 May 2002 15:47:14 +0400
From: Andrey Panin <pazke@orbita1.ru>
To: linux-kernel@vger.kernel.org
Cc: gregkh@us.ibm.com
Subject: [PATCH] IBM hotplug PCI, many missing __init's
Message-ID: <20020507114714.GA620@pazke.ipt>
Mail-Followup-To: linux-kernel@vger.kernel.org, gregkh@us.ibm.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="neYutvxvOLaeuPCA"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Uname: Linux pazke 2.5.10 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--neYutvxvOLaeuPCA
Content-Type: multipart/mixed; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this patch adds many missing __init modifiers to IBM hotplug PCI driver.
Patch against 2.5.14. Compiles, but untested.=20
Please consider applying.

Best regards.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net
--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-ibmphp
Content-Transfer-Encoding: quoted-printable

diff -urN -X /usr/share/dontdiff linux.vanilla/drivers/hotplug/ibmphp_core.=
c linux/drivers/hotplug/ibmphp_core.c
--- linux.vanilla/drivers/hotplug/ibmphp_core.c	Tue Apr 23 19:07:11 2002
+++ linux/drivers/hotplug/ibmphp_core.c	Sat May  4 00:43:18 2002
@@ -106,7 +106,7 @@
 	return rc;
 }
=20
-static int get_max_slots (void)
+static inline int get_max_slots (void)
 {
 	struct list_head * tmp;
 	int slot_count =3D 0;
@@ -528,7 +528,7 @@
  * function. It will also power off empty slots that are powered on since =
BIOS
  * leaves those on, albeit disconnected
  *************************************************************************=
*****/
-static int init_ops (void)
+static int __init init_ops (void)
 {
 	struct slot *slot_cur;
 	int retval;
@@ -755,7 +755,7 @@
 /******************************************************************
  * This function is here because we can no longer use pci_root_ops
  ******************************************************************/
-static struct pci_ops *get_root_pci_ops (void)
+static inline struct pci_ops *get_root_pci_ops (void)
 {
 	struct pci_bus * bus;
=20
diff -urN -X /usr/share/dontdiff linux.vanilla/drivers/hotplug/ibmphp_ebda.=
c linux/drivers/hotplug/ibmphp_ebda.c
--- linux.vanilla/drivers/hotplug/ibmphp_ebda.c	Wed Mar 13 21:43:31 2002
+++ linux/drivers/hotplug/ibmphp_ebda.c	Sat May  4 01:41:55 2002
@@ -65,7 +65,7 @@
 static int ebda_rsrc_rsrc (void);
 static int ebda_rio_table (void);
=20
-static struct slot *alloc_ibm_slot (void)
+static struct slot * __init alloc_ibm_slot (void)
 {
 	struct slot *slot;
=20
@@ -76,7 +76,7 @@
 	return slot;
 }
=20
-static struct ebda_hpc_list *alloc_ebda_hpc_list (void)
+static struct ebda_hpc_list * __init alloc_ebda_hpc_list (void)
 {
 	struct ebda_hpc_list *list;
=20
@@ -87,7 +87,7 @@
 	return list;
 }
=20
-static struct controller *alloc_ebda_hpc (u32 slot_count, u32 bus_count)
+static struct controller * __init alloc_ebda_hpc(u32 slot_count, u32 bus_c=
ount)
 {
 	struct controller *controller;
 	struct ebda_hpc_slot *slots;
@@ -127,7 +127,7 @@
 	kfree (controller);
 }
=20
-static struct ebda_rsrc_list *alloc_ebda_rsrc_list (void)
+static struct ebda_rsrc_list * __init alloc_ebda_rsrc_list (void)
 {
 	struct ebda_rsrc_list *list;
=20
@@ -138,7 +138,7 @@
 	return list;
 }
=20
-static struct ebda_pci_rsrc *alloc_ebda_pci_rsrc (void)
+static struct ebda_pci_rsrc * __init alloc_ebda_pci_rsrc (void)
 {
 	struct ebda_pci_rsrc *resource;
=20
@@ -149,7 +149,7 @@
 	return resource;
 }
=20
-static void print_bus_info (void)
+static void __init print_bus_info (void)
 {
 	struct bus_info *ptr;
 	struct list_head *ptr1;
@@ -167,7 +167,7 @@
 	}
 }
=20
-static void print_ebda_pci_rsrc (void)
+static void __init print_ebda_pci_rsrc (void)
 {
 	struct ebda_pci_rsrc *ptr;
 	struct list_head *ptr1;
@@ -179,7 +179,7 @@
 	}
 }
=20
-static void print_ebda_hpc (void)
+static void __init print_ebda_hpc (void)
 {
 	struct controller *hpc_ptr;
 	struct list_head *ptr1;
@@ -223,7 +223,7 @@
 	}
 }
=20
-int ibmphp_access_ebda (void)
+int __init ibmphp_access_ebda (void)
 {
 	u8 format, num_ctlrs, rio_complete, hs_complete;
 	u16 ebda_seg, num_entries, next_offset, offset, blk_id, sub_addr, rc, re,=
 rc_id, re_id, base;
@@ -382,7 +382,7 @@
  * each hpc from physical address to a list of hot plug controllers based =
on
  * hpc descriptors.
  */
-static int ebda_rsrc_controller (void)
+static int __init ebda_rsrc_controller (void)
 {
 	u16 addr, addr_slot, addr_bus;
 	u8 ctlr_id, temp, bus_index;
@@ -626,7 +626,7 @@
  * map info (bus, devfun, start addr, end addr..) of i/o, memory,
  * pfm from the physical addr to a list of resource.
  */
-static int ebda_rsrc_rsrc (void)
+static int __init ebda_rsrc_rsrc (void)
 {
 	u16 addr;
 	short rsrc;
@@ -694,7 +694,7 @@
 /*
  * map info of scalability details and rio details from physical address
  */
-static int ebda_rio_table(void)
+static int __init ebda_rio_table(void)
 {
 	u16 offset;
 	u8 i;
diff -urN -X /usr/share/dontdiff linux.vanilla/drivers/hotplug/ibmphp_hpc.c=
 linux/drivers/hotplug/ibmphp_hpc.c
--- linux.vanilla/drivers/hotplug/ibmphp_hpc.c	Wed Mar 13 21:43:31 2002
+++ linux/drivers/hotplug/ibmphp_hpc.c	Sat May  4 00:35:30 2002
@@ -1056,7 +1056,7 @@
 *
 * Action:  start polling thread
 *---------------------------------------------------------------------*/
-int ibmphp_hpc_start_poll_thread (void)
+int __init ibmphp_hpc_start_poll_thread (void)
 {
 	int rc =3D 0;
=20
@@ -1077,7 +1077,7 @@
 *
 * Action:  stop polling thread and cleanup
 *---------------------------------------------------------------------*/
-void ibmphp_hpc_stop_poll_thread (void)
+void __exit ibmphp_hpc_stop_poll_thread (void)
 {
 	debug ("ibmphp_hpc_stop_poll_thread - Entry\n");
=20
diff -urN -X /usr/share/dontdiff linux.vanilla/drivers/hotplug/ibmphp_res.c=
 linux/drivers/hotplug/ibmphp_res.c
--- linux.vanilla/drivers/hotplug/ibmphp_res.c	Wed Mar 13 21:43:31 2002
+++ linux/drivers/hotplug/ibmphp_res.c	Sun May  5 02:58:33 2002
@@ -45,7 +45,7 @@
=20
 static LIST_HEAD(gbuses);
=20
-static struct bus_node * alloc_error_bus (struct ebda_pci_rsrc * curr)
+static struct bus_node * __init alloc_error_bus (struct ebda_pci_rsrc * cu=
rr)
 {
 	struct bus_node * newbus;
=20
@@ -61,7 +61,7 @@
 	return newbus;
 }
=20
-static struct resource_node * alloc_resources (struct ebda_pci_rsrc * curr)
+static struct __init resource_node * alloc_resources (struct ebda_pci_rsrc=
 * curr)
 {
 	struct resource_node *rs =3D kmalloc (sizeof (struct resource_node), GFP_=
KERNEL);
 	if (!rs) {
@@ -77,7 +77,7 @@
 	return rs;
 }
=20
-static int alloc_bus_range (struct bus_node **new_bus, struct range_node *=
*new_range, struct ebda_pci_rsrc *curr, int flag, u8 first_bus)
+static int __init alloc_bus_range (struct bus_node **new_bus, struct range=
_node **new_range, struct ebda_pci_rsrc *curr, int flag, u8 first_bus)
 {
 	struct bus_node * newbus;
 	struct range_node *newrange;
@@ -184,7 +184,7 @@
  * Input: ptr to the head of the resource list from EBDA
  * Output: 0, -1 or error codes
  *************************************************************************=
**/
-int ibmphp_rsrc_init (void)
+int __init ibmphp_rsrc_init (void)
 {
 	struct ebda_pci_rsrc *curr;
 	struct range_node *newrange =3D NULL;
@@ -1650,7 +1650,7 @@
  * a new Mem node
  * This routine is called right after initialization
  *************************************************************************=
******/
-static int once_over (void)
+static int __init once_over (void)
 {
 	struct resource_node *pfmem_cur;
 	struct resource_node *pfmem_prev;
@@ -1871,7 +1871,7 @@
  *	 behind them All these are TO DO.
  *	 Also need to add more error checkings... (from fnc returns etc)
  */
-static int update_bridge_ranges (struct bus_node **bus)
+static int __init update_bridge_ranges (struct bus_node **bus)
 {
 	u8 sec_busno, device, function, busno, hdr_type, start_io_address, end_io=
_address;
 	u16 vendor_id, upper_io_start, upper_io_end, start_mem_address, end_mem_a=
ddress;

--x+6KMIRAuhnl3hBn--

--neYutvxvOLaeuPCA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8177CBm4rlNOo3YgRAqcHAJsF72ch5RnuXRyCNL8IUy3UfAuWbQCfSESV
hB39uBMn+WTmodwl32B1fy0=
=jFZw
-----END PGP SIGNATURE-----

--neYutvxvOLaeuPCA--
