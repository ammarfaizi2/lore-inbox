Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750988AbWFELep@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbWFELep (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 07:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750990AbWFELep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 07:34:45 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:20429 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1750988AbWFELeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 07:34:44 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Mon, 5 Jun 2006 13:31:02 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.17-rc5-mm3] ieee1394: adjust code formatting in
 highlevel.c
To: linux1394-devel@lists.sourceforge.net
cc: Arjan van de Ven <arjan@linux.intel.com>, Jiri Slaby <jirislaby@gmail.com>,
        Ben Collins <bcollins@ubuntu.com>,
        Jody McIntyre <scjody@modernduck.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@osdl.org>,
        =?iso-8859-1?Q?J=2EA=2E_Magall=F3n?= <jamagallon@ono.com>
In-Reply-To: <tkrat.02c63cb007e86f12@s5r6.in-berlin.de>
Message-ID: <tkrat.475c04773b87c309@s5r6.in-berlin.de>
References: <20060601014806.e86b3cc0.akpm@osdl.org>
 <447F0905.8020600@gmail.com>
 <1149176945.3115.70.camel@laptopd505.fenrus.org>
 <1149179744.4533.205.camel@grayson>
 <tkrat.02c63cb007e86f12@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace spaces by tabulators, wrap lines at 80 columns, delete some
blank lines and superfluous braces.  Collapse some if()-within-if()
constructs.  Replace a literal CSR address by its preprocessor constant.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
applies after patch
"ieee1394: hl_irqs_lock is taken in hardware interrupt context"

 drivers/ieee1394/highlevel.c |  415 +++++++++++++++--------------------
 1 files changed, 182 insertions(+), 233 deletions(-)

Index: linux/drivers/ieee1394/highlevel.c
===================================================================
--- linux.orig/drivers/ieee1394/highlevel.c	2006-06-05 11:42:07.000000000 +0200
+++ linux/drivers/ieee1394/highlevel.c	2006-06-05 12:50:45.000000000 +0200
@@ -53,7 +53,7 @@ static struct hpsb_address_serve dummy_z
 
 
 static struct hl_host_info *hl_get_hostinfo(struct hpsb_highlevel *hl,
-					      struct hpsb_host *host)
+					    struct hpsb_host *host)
 {
 	struct hl_host_info *hi = NULL;
 
@@ -68,24 +68,18 @@ static struct hl_host_info *hl_get_hosti
 		}
 	}
 	read_unlock(&hl->host_info_lock);
-
 	return NULL;
 }
 
-
 /* Returns a per host/driver data structure that was previously stored by
  * hpsb_create_hostinfo. */
 void *hpsb_get_hostinfo(struct hpsb_highlevel *hl, struct hpsb_host *host)
 {
 	struct hl_host_info *hi = hl_get_hostinfo(hl, host);
 
-	if (hi)
-		return hi->data;
-
-	return NULL;
+	return hi ? hi->data : NULL;
 }
 
-
 /* If size is zero, then the return here is only valid for error checking */
 void *hpsb_create_hostinfo(struct hpsb_highlevel *hl, struct hpsb_host *host,
 			   size_t data_size)
@@ -96,8 +90,8 @@ void *hpsb_create_hostinfo(struct hpsb_h
 
 	hi = hl_get_hostinfo(hl, host);
 	if (hi) {
-		HPSB_ERR("%s called hpsb_create_hostinfo when hostinfo already exists",
-			 hl->name);
+		HPSB_ERR("%s called hpsb_create_hostinfo when hostinfo already"
+			 " exists", hl->name);
 		return NULL;
 	}
 
@@ -120,7 +114,6 @@ void *hpsb_create_hostinfo(struct hpsb_h
 	return data;
 }
 
-
 int hpsb_set_hostinfo(struct hpsb_highlevel *hl, struct hpsb_host *host,
 		      void *data)
 {
@@ -132,16 +125,14 @@ int hpsb_set_hostinfo(struct hpsb_highle
 			hi->data = data;
 			return 0;
 		} else
-			HPSB_ERR("%s called hpsb_set_hostinfo when hostinfo already has data",
-				 hl->name);
+			HPSB_ERR("%s called hpsb_set_hostinfo when hostinfo "
+				 "already has data", hl->name);
 	} else
 		HPSB_ERR("%s called hpsb_set_hostinfo when no hostinfo exists",
 			 hl->name);
-
 	return -EINVAL;
 }
 
-
 void hpsb_destroy_hostinfo(struct hpsb_highlevel *hl, struct hpsb_host *host)
 {
 	struct hl_host_info *hi;
@@ -154,23 +145,20 @@ void hpsb_destroy_hostinfo(struct hpsb_h
 		write_unlock_irqrestore(&hl->host_info_lock, flags);
 		kfree(hi);
 	}
-
 	return;
 }
 
-
-void hpsb_set_hostinfo_key(struct hpsb_highlevel *hl, struct hpsb_host *host, unsigned long key)
+void hpsb_set_hostinfo_key(struct hpsb_highlevel *hl, struct hpsb_host *host,
+			   unsigned long key)
 {
 	struct hl_host_info *hi;
 
 	hi = hl_get_hostinfo(hl, host);
 	if (hi)
 		hi->key = key;
-
 	return;
 }
 
-
 void *hpsb_get_hostinfo_bykey(struct hpsb_highlevel *hl, unsigned long key)
 {
 	struct hl_host_info *hi;
@@ -187,24 +175,18 @@ void *hpsb_get_hostinfo_bykey(struct hps
 		}
 	}
 	read_unlock(&hl->host_info_lock);
-
 	return data;
 }
 
-
 static int highlevel_for_each_host_reg(struct hpsb_host *host, void *__data)
 {
 	struct hpsb_highlevel *hl = __data;
 
 	hl->add_host(host);
 
-        if (host->update_config_rom) {
-		if (hpsb_update_config_rom_image(host) < 0) {
-			HPSB_ERR("Failed to generate Configuration ROM image for host "
-				 "%s-%d", hl->name, host->id);
-		}
-	}
-
+	if (host->update_config_rom && hpsb_update_config_rom_image(host) < 0)
+		HPSB_ERR("Failed to generate Configuration ROM image for host "
+			 "%s-%d", hl->name, host->id);
 	return 0;
 }
 
@@ -212,13 +194,13 @@ void hpsb_register_highlevel(struct hpsb
 {
 	unsigned long flags;
 
-        INIT_LIST_HEAD(&hl->addr_list);
+	INIT_LIST_HEAD(&hl->addr_list);
 	INIT_LIST_HEAD(&hl->host_info_list);
 
 	rwlock_init(&hl->host_info_lock);
 
 	down_write(&hl_drivers_sem);
-        list_add_tail(&hl->hl_list, &hl_drivers);
+	list_add_tail(&hl->hl_list, &hl_drivers);
 	up_write(&hl_drivers_sem);
 
 	write_lock_irqsave(&hl_irqs_lock, flags);
@@ -227,8 +209,7 @@ void hpsb_register_highlevel(struct hpsb
 
 	if (hl->add_host)
 		nodemgr_for_each_host(hl, highlevel_for_each_host_reg);
-
-        return;
+	return;
 }
 
 static void __delete_addr(struct hpsb_address_serve *as)
@@ -238,7 +219,8 @@ static void __delete_addr(struct hpsb_ad
 	kfree(as);
 }
 
-static void __unregister_host(struct hpsb_highlevel *hl, struct hpsb_host *host, int update_cr)
+static void __unregister_host(struct hpsb_highlevel *hl, struct hpsb_host *host,
+			      int update_cr)
 {
 	unsigned long flags;
 	struct list_head *lh, *next;
@@ -253,7 +235,6 @@ static void __unregister_host(struct hps
 	write_lock_irqsave(&addr_space_lock, flags);
 	list_for_each_safe (lh, next, &hl->addr_list) {
 		as = list_entry(lh, struct hpsb_address_serve, hl_list);
-
 		if (as->host == host)
 			__delete_addr(as);
 	}
@@ -261,15 +242,12 @@ static void __unregister_host(struct hps
 
 	/* Now update the config-rom to reflect anything removed by the
 	 * highlevel driver. */
-	if (update_cr && host->update_config_rom) {
-		if (hpsb_update_config_rom_image(host) < 0) {
-			HPSB_ERR("Failed to generate Configuration ROM image for host "
-				 "%s-%d", hl->name, host->id);
-		}
-	}
+	if (update_cr && host->update_config_rom &&
+	    hpsb_update_config_rom_image(host) < 0)
+		HPSB_ERR("Failed to generate Configuration ROM image for host "
+			 "%s-%d", hl->name, host->id);
 
-	/* And finally, remove all the host info associated between these
-	 * two. */
+	/* Finally remove all the host info associated between these two. */
 	hpsb_destroy_hostinfo(hl, host);
 }
 
@@ -278,7 +256,6 @@ static int highlevel_for_each_host_unreg
 	struct hpsb_highlevel *hl = __data;
 
 	__unregister_host(hl, host, 1);
-
 	return 0;
 }
 
@@ -291,7 +268,7 @@ void hpsb_unregister_highlevel(struct hp
 	write_unlock_irqrestore(&hl_irqs_lock, flags);
 
 	down_write(&hl_drivers_sem);
-        list_del(&hl->hl_list);
+	list_del(&hl->hl_list);
 	up_write(&hl_drivers_sem);
 
 	nodemgr_for_each_host(hl, highlevel_for_each_host_unreg);
@@ -325,9 +302,11 @@ u64 hpsb_allocate_and_register_addrspace
 		end   = CSR1212_ALL_SPACE_END;
 	}
 
-	if (((start|end) & ~align_mask) || (start >= end) || (end > 0x1000000000000ULL)) {
-		HPSB_ERR("%s called with invalid addresses (start = %012Lx    end = %012Lx)",
-			 __FUNCTION__, (unsigned long long)start, (unsigned long long)end);
+	if (((start|end) & ~align_mask) || (start >= end) ||
+	    (end > CSR1212_ALL_SPACE_END)) {
+		HPSB_ERR("%s called with invalid addresses "
+			 "(start = %012Lx  end = %012Lx)", __FUNCTION__,
+			 (unsigned long long)start,(unsigned long long)end);
 		return retval;
 	}
 
@@ -341,20 +320,21 @@ u64 hpsb_allocate_and_register_addrspace
 	as->host = host;
 
 	write_lock_irqsave(&addr_space_lock, flags);
-
 	list_for_each(entry, &host->addr_space) {
 		u64 a1sa, a1ea;
 		u64 a2sa, a2ea;
 
 		a1 = list_entry(entry, struct hpsb_address_serve, host_list);
-		a2 = list_entry(entry->next, struct hpsb_address_serve, host_list);
+		a2 = list_entry(entry->next, struct hpsb_address_serve,
+				host_list);
 
 		a1sa = a1->start & align_mask;
 		a1ea = (a1->end + alignment -1) & align_mask;
 		a2sa = a2->start & align_mask;
 		a2ea = (a2->end + alignment -1) & align_mask;
 
-		if ((a2sa - a1ea >= size) && (a2sa - start >= size) && (a2sa > start)) {
+		if ((a2sa - a1ea >= size) && (a2sa - start >= size) &&
+		    (a2sa > start)) {
 			as->start = max(start, a1ea);
 			as->end = as->start + size;
 			list_add(&as->host_list, entry);
@@ -363,47 +343,45 @@ u64 hpsb_allocate_and_register_addrspace
 			break;
 		}
 	}
-
 	write_unlock_irqrestore(&addr_space_lock, flags);
 
-	if (retval == CSR1212_INVALID_ADDR_SPACE) {
+	if (retval == CSR1212_INVALID_ADDR_SPACE)
 		kfree(as);
-	}
-
 	return retval;
 }
 
 int hpsb_register_addrspace(struct hpsb_highlevel *hl, struct hpsb_host *host,
-                            struct hpsb_address_ops *ops, u64 start, u64 end)
+			    struct hpsb_address_ops *ops, u64 start, u64 end)
 {
-        struct hpsb_address_serve *as;
+	struct hpsb_address_serve *as;
 	struct list_head *lh;
-        int retval = 0;
-        unsigned long flags;
+	int retval = 0;
+	unsigned long flags;
 
-        if (((start|end) & 3) || (start >= end) || (end > 0x1000000000000ULL)) {
-                HPSB_ERR("%s called with invalid addresses", __FUNCTION__);
-                return 0;
-        }
+	if (((start|end) & 3) || (start >= end) ||
+	    (end > CSR1212_ALL_SPACE_END)) {
+		HPSB_ERR("%s called with invalid addresses", __FUNCTION__);
+		return 0;
+	}
 
 	as = kmalloc(sizeof(*as), GFP_ATOMIC);
 	if (!as)
 		return 0;
 
-        INIT_LIST_HEAD(&as->host_list);
-        INIT_LIST_HEAD(&as->hl_list);
-        as->op = ops;
-        as->start = start;
-        as->end = end;
+	INIT_LIST_HEAD(&as->host_list);
+	INIT_LIST_HEAD(&as->hl_list);
+	as->op = ops;
+	as->start = start;
+	as->end = end;
 	as->host = host;
 
 	write_lock_irqsave(&addr_space_lock, flags);
-
 	list_for_each(lh, &host->addr_space) {
 		struct hpsb_address_serve *as_this =
 			list_entry(lh, struct hpsb_address_serve, host_list);
 		struct hpsb_address_serve *as_next =
-			list_entry(lh->next, struct hpsb_address_serve, host_list);
+			list_entry(lh->next, struct hpsb_address_serve,
+				   host_list);
 
 		if (as_this->end > as->start)
 			break;
@@ -419,60 +397,51 @@ int hpsb_register_addrspace(struct hpsb_
 
 	if (retval == 0)
 		kfree(as);
-
-        return retval;
+	return retval;
 }
 
 int hpsb_unregister_addrspace(struct hpsb_highlevel *hl, struct hpsb_host *host,
-                              u64 start)
+			      u64 start)
 {
-        int retval = 0;
-        struct hpsb_address_serve *as;
-        struct list_head *lh, *next;
-        unsigned long flags;
-
-        write_lock_irqsave(&addr_space_lock, flags);
+	int retval = 0;
+	struct hpsb_address_serve *as;
+	struct list_head *lh, *next;
+	unsigned long flags;
 
+	write_lock_irqsave(&addr_space_lock, flags);
 	list_for_each_safe (lh, next, &hl->addr_list) {
-                as = list_entry(lh, struct hpsb_address_serve, hl_list);
-                if (as->start == start && as->host == host) {
+		as = list_entry(lh, struct hpsb_address_serve, hl_list);
+		if (as->start == start && as->host == host) {
 			__delete_addr(as);
-                        retval = 1;
-                        break;
-                }
-        }
-
-        write_unlock_irqrestore(&addr_space_lock, flags);
-
-        return retval;
+			retval = 1;
+			break;
+		}
+	}
+	write_unlock_irqrestore(&addr_space_lock, flags);
+	return retval;
 }
 
 int hpsb_listen_channel(struct hpsb_highlevel *hl, struct hpsb_host *host,
-                         unsigned int channel)
+			unsigned int channel)
 {
-        if (channel > 63) {
-                HPSB_ERR("%s called with invalid channel", __FUNCTION__);
-                return -EINVAL;
-        }
-
-        if (host->iso_listen_count[channel]++ == 0) {
-                return host->driver->devctl(host, ISO_LISTEN_CHANNEL, channel);
-        }
-
+	if (channel > 63) {
+		HPSB_ERR("%s called with invalid channel", __FUNCTION__);
+		return -EINVAL;
+	}
+	if (host->iso_listen_count[channel]++ == 0)
+		return host->driver->devctl(host, ISO_LISTEN_CHANNEL, channel);
 	return 0;
 }
 
 void hpsb_unlisten_channel(struct hpsb_highlevel *hl, struct hpsb_host *host,
-                           unsigned int channel)
+			   unsigned int channel)
 {
-        if (channel > 63) {
-                HPSB_ERR("%s called with invalid channel", __FUNCTION__);
-                return;
-        }
-
-        if (--host->iso_listen_count[channel] == 0) {
-                host->driver->devctl(host, ISO_UNLISTEN_CHANNEL, channel);
-        }
+	if (channel > 63) {
+		HPSB_ERR("%s called with invalid channel", __FUNCTION__);
+		return;
+	}
+	if (--host->iso_listen_count[channel] == 0)
+		host->driver->devctl(host, ISO_UNLISTEN_CHANNEL, channel);
 }
 
 static void init_hpsb_highlevel(struct hpsb_host *host)
@@ -493,26 +462,24 @@ static void init_hpsb_highlevel(struct h
 
 void highlevel_add_host(struct hpsb_host *host)
 {
-        struct hpsb_highlevel *hl;
+	struct hpsb_highlevel *hl;
 
 	init_hpsb_highlevel(host);
 
 	down_read(&hl_drivers_sem);
-        list_for_each_entry(hl, &hl_drivers, hl_list) {
+	list_for_each_entry(hl, &hl_drivers, hl_list) {
 		if (hl->add_host)
 			hl->add_host(host);
-        }
-	up_read(&hl_drivers_sem);
-	if (host->update_config_rom) {
-		if (hpsb_update_config_rom_image(host) < 0)
-			HPSB_ERR("Failed to generate Configuration ROM image for "
-				 "host %s-%d", hl->name, host->id);
 	}
+	up_read(&hl_drivers_sem);
+	if (host->update_config_rom && hpsb_update_config_rom_image(host) < 0)
+		HPSB_ERR("Failed to generate Configuration ROM image for host "
+			 "%s-%d", hl->name, host->id);
 }
 
 void highlevel_remove_host(struct hpsb_host *host)
 {
-        struct hpsb_highlevel *hl;
+	struct hpsb_highlevel *hl;
 
 	down_read(&hl_drivers_sem);
 	list_for_each_entry(hl, &hl_drivers, hl_list)
@@ -523,186 +490,168 @@ void highlevel_remove_host(struct hpsb_h
 void highlevel_host_reset(struct hpsb_host *host)
 {
 	unsigned long flags;
-        struct hpsb_highlevel *hl;
+	struct hpsb_highlevel *hl;
 
 	read_lock_irqsave(&hl_irqs_lock, flags);
 	list_for_each_entry(hl, &hl_irqs, irq_list) {
-                if (hl->host_reset)
-                        hl->host_reset(host);
-        }
+		if (hl->host_reset)
+			hl->host_reset(host);
+	}
 	read_unlock_irqrestore(&hl_irqs_lock, flags);
 }
 
 void highlevel_iso_receive(struct hpsb_host *host, void *data, size_t length)
 {
 	unsigned long flags;
-        struct hpsb_highlevel *hl;
-        int channel = (((quadlet_t *)data)[0] >> 8) & 0x3f;
+	struct hpsb_highlevel *hl;
+	int channel = (((quadlet_t *)data)[0] >> 8) & 0x3f;
 
-        read_lock_irqsave(&hl_irqs_lock, flags);
+	read_lock_irqsave(&hl_irqs_lock, flags);
 	list_for_each_entry(hl, &hl_irqs, irq_list) {
-                if (hl->iso_receive)
-                        hl->iso_receive(host, channel, data, length);
-        }
-        read_unlock_irqrestore(&hl_irqs_lock, flags);
+		if (hl->iso_receive)
+			hl->iso_receive(host, channel, data, length);
+	}
+	read_unlock_irqrestore(&hl_irqs_lock, flags);
 }
 
 void highlevel_fcp_request(struct hpsb_host *host, int nodeid, int direction,
 			   void *data, size_t length)
 {
 	unsigned long flags;
-        struct hpsb_highlevel *hl;
-        int cts = ((quadlet_t *)data)[0] >> 4;
+	struct hpsb_highlevel *hl;
+	int cts = ((quadlet_t *)data)[0] >> 4;
 
-        read_lock_irqsave(&hl_irqs_lock, flags);
+	read_lock_irqsave(&hl_irqs_lock, flags);
 	list_for_each_entry(hl, &hl_irqs, irq_list) {
-                if (hl->fcp_request)
-                        hl->fcp_request(host, nodeid, direction, cts, data,
+		if (hl->fcp_request)
+			hl->fcp_request(host, nodeid, direction, cts, data,
 					length);
-        }
-        read_unlock_irqrestore(&hl_irqs_lock, flags);
+	}
+	read_unlock_irqrestore(&hl_irqs_lock, flags);
 }
 
-int highlevel_read(struct hpsb_host *host, int nodeid, void *data,
-                   u64 addr, unsigned int length, u16 flags)
+int highlevel_read(struct hpsb_host *host, int nodeid, void *data, u64 addr,
+		   unsigned int length, u16 flags)
 {
-        struct hpsb_address_serve *as;
-        unsigned int partlength;
-        int rcode = RCODE_ADDRESS_ERROR;
-
-        read_lock(&addr_space_lock);
+	struct hpsb_address_serve *as;
+	unsigned int partlength;
+	int rcode = RCODE_ADDRESS_ERROR;
 
+	read_lock(&addr_space_lock);
 	list_for_each_entry(as, &host->addr_space, host_list) {
 		if (as->start > addr)
 			break;
 
-                if (as->end > addr) {
-                        partlength = min(as->end - addr, (u64) length);
+		if (as->end > addr) {
+			partlength = min(as->end - addr, (u64) length);
 
-                        if (as->op->read) {
-                                rcode = as->op->read(host, nodeid, data,
+			if (as->op->read)
+				rcode = as->op->read(host, nodeid, data,
 						     addr, partlength, flags);
-                        } else {
-                                rcode = RCODE_TYPE_ERROR;
-                        }
+			else
+				rcode = RCODE_TYPE_ERROR;
 
 			data += partlength;
-                        length -= partlength;
-                        addr += partlength;
+			length -= partlength;
+			addr += partlength;
 
-                        if ((rcode != RCODE_COMPLETE) || !length) {
-                                break;
-                        }
-                }
-        }
-
-        read_unlock(&addr_space_lock);
-
-        if (length && (rcode == RCODE_COMPLETE)) {
-                rcode = RCODE_ADDRESS_ERROR;
-        }
+			if ((rcode != RCODE_COMPLETE) || !length)
+				break;
+		}
+	}
+	read_unlock(&addr_space_lock);
 
-        return rcode;
+	if (length && (rcode == RCODE_COMPLETE))
+		rcode = RCODE_ADDRESS_ERROR;
+	return rcode;
 }
 
-int highlevel_write(struct hpsb_host *host, int nodeid, int destid,
-		    void *data, u64 addr, unsigned int length, u16 flags)
+int highlevel_write(struct hpsb_host *host, int nodeid, int destid, void *data,
+		    u64 addr, unsigned int length, u16 flags)
 {
-        struct hpsb_address_serve *as;
-        unsigned int partlength;
-        int rcode = RCODE_ADDRESS_ERROR;
-
-        read_lock(&addr_space_lock);
+	struct hpsb_address_serve *as;
+	unsigned int partlength;
+	int rcode = RCODE_ADDRESS_ERROR;
 
+	read_lock(&addr_space_lock);
 	list_for_each_entry(as, &host->addr_space, host_list) {
 		if (as->start > addr)
 			break;
 
-                if (as->end > addr) {
-                        partlength = min(as->end - addr, (u64) length);
+		if (as->end > addr) {
+			partlength = min(as->end - addr, (u64) length);
 
-                        if (as->op->write) {
-                                rcode = as->op->write(host, nodeid, destid,
-						      data, addr, partlength, flags);
-                        } else {
-                                rcode = RCODE_TYPE_ERROR;
-                        }
+			if (as->op->write)
+				rcode = as->op->write(host, nodeid, destid,
+						      data, addr, partlength,
+						      flags);
+			else
+				rcode = RCODE_TYPE_ERROR;
 
 			data += partlength;
-                        length -= partlength;
-                        addr += partlength;
+			length -= partlength;
+			addr += partlength;
 
-                        if ((rcode != RCODE_COMPLETE) || !length) {
-                                break;
-                        }
-                }
-        }
-
-        read_unlock(&addr_space_lock);
-
-        if (length && (rcode == RCODE_COMPLETE)) {
-                rcode = RCODE_ADDRESS_ERROR;
-        }
+			if ((rcode != RCODE_COMPLETE) || !length)
+				break;
+		}
+	}
+	read_unlock(&addr_space_lock);
 
-        return rcode;
+	if (length && (rcode == RCODE_COMPLETE))
+		rcode = RCODE_ADDRESS_ERROR;
+	return rcode;
 }
 
-
 int highlevel_lock(struct hpsb_host *host, int nodeid, quadlet_t *store,
-                   u64 addr, quadlet_t data, quadlet_t arg, int ext_tcode, u16 flags)
+		   u64 addr, quadlet_t data, quadlet_t arg, int ext_tcode,
+		   u16 flags)
 {
-        struct hpsb_address_serve *as;
-        int rcode = RCODE_ADDRESS_ERROR;
-
-        read_lock(&addr_space_lock);
+	struct hpsb_address_serve *as;
+	int rcode = RCODE_ADDRESS_ERROR;
 
+	read_lock(&addr_space_lock);
 	list_for_each_entry(as, &host->addr_space, host_list) {
 		if (as->start > addr)
 			break;
 
-                if (as->end > addr) {
-                        if (as->op->lock) {
-                                rcode = as->op->lock(host, nodeid, store, addr,
-                                                     data, arg, ext_tcode, flags);
-                        } else {
-                                rcode = RCODE_TYPE_ERROR;
-                        }
-
-                        break;
-                }
-        }
-
-        read_unlock(&addr_space_lock);
-
-        return rcode;
+		if (as->end > addr) {
+			if (as->op->lock)
+				rcode = as->op->lock(host, nodeid, store, addr,
+						     data, arg, ext_tcode,
+						     flags);
+			else
+				rcode = RCODE_TYPE_ERROR;
+			break;
+		}
+	}
+	read_unlock(&addr_space_lock);
+	return rcode;
 }
 
 int highlevel_lock64(struct hpsb_host *host, int nodeid, octlet_t *store,
-                     u64 addr, octlet_t data, octlet_t arg, int ext_tcode, u16 flags)
+		     u64 addr, octlet_t data, octlet_t arg, int ext_tcode,
+		     u16 flags)
 {
-        struct hpsb_address_serve *as;
-        int rcode = RCODE_ADDRESS_ERROR;
+	struct hpsb_address_serve *as;
+	int rcode = RCODE_ADDRESS_ERROR;
 
-        read_lock(&addr_space_lock);
+	read_lock(&addr_space_lock);
 
 	list_for_each_entry(as, &host->addr_space, host_list) {
 		if (as->start > addr)
 			break;
 
-                if (as->end > addr) {
-                        if (as->op->lock64) {
-                                rcode = as->op->lock64(host, nodeid, store,
-                                                       addr, data, arg,
-                                                       ext_tcode, flags);
-                        } else {
-                                rcode = RCODE_TYPE_ERROR;
-                        }
-
-                        break;
-                }
-        }
-
-        read_unlock(&addr_space_lock);
-
-        return rcode;
+		if (as->end > addr) {
+			if (as->op->lock64)
+				rcode = as->op->lock64(host, nodeid, store,
+						       addr, data, arg,
+						       ext_tcode, flags);
+			else
+				rcode = RCODE_TYPE_ERROR;
+			break;
+		}
+	}
+	read_unlock(&addr_space_lock);
+	return rcode;
 }


