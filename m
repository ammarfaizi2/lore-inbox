Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbWAPQyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbWAPQyd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 11:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbWAPQyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 11:54:33 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:3536 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751111AbWAPQyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 11:54:32 -0500
Subject: PATCH: Remove proto.h from rio driver (unused file)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Jan 2006 16:58:38 +0000
Message-Id: <1137430718.15553.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.15-git12/drivers/char/rio/proto.h linux-2.6.15-git12/drivers/char/rio/proto.h
--- linux.vanilla-2.6.15-git12/drivers/char/rio/proto.h	2006-01-16 14:19:13.000000000 +0000
+++ linux-2.6.15-git12/drivers/char/rio/proto.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,244 +0,0 @@
-/*
- *
- *  (C) 1990 - 2000 Specialix International Ltd., Byfleet, Surrey, UK.
- *
- *      This program is free software; you can redistribute it and/or modify
- *      it under the terms of the GNU General Public License as published by
- *      the Free Software Foundation; either version 2 of the License, or
- *      (at your option) any later version.
- *
- *      This program is distributed in the hope that it will be useful,
- *      but WITHOUT ANY WARRANTY; without even the implied warranty of
- *      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *      GNU General Public License for more details.
- *
- *      You should have received a copy of the GNU General Public License
- *      along with this program; if not, write to the Free Software
- *      Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- */
-#ifndef	_prototypes_h
-#define _prototypes_h
-
-
-/*
-** boot.c
-*/
-void init_boot(char *p, short stage);
-
-/*
-** disconct.c
-*/
-void kill_boot(LPB * link);
-void disconnected(LPB * link);
-short boot_3(LPB * link, PKT * pkt);
-short send_3_pkt(LPB * link, PKT * pkt);
-
-/*
-** error.c
-*/
-void du_error(void);
-
-/*
-** formpkt.c
-*/
-ushort sum_it(PKT * pkt);
-void form_rup_pkt(RUP * form_rup, PKT * pkt);
-void form_poll_pkt(int type, LPB * link, int node);
-void form_route_pkt(int type, PKT * pkt, LPB * link);
-
-/*
-** idle.c
-*/
-void idle(Process * idle_p);
-
-/*
-** init.c
-*/
-void general_init(void);
-void mem_halt(int error);
-
-/*
-** linkinit.c
-*/
-void initlink(u_short number, LPB * link);
-void runlink(LPB * link);
-
-/*
-** list.c
-*/
-PKT *get_free_start(void);
-void put_free_start(PKT * pkt);
-
-#ifdef HOST
-int can_remove_transmit(PKT ** pkt, PKT * pointer);
-#endif
-
-#ifdef RTA
-int spl7(void);
-int spl0(void);
-Q_BUF *get_free_q(void);
-PKT *get_free_end(void);
-int add_end(PKT * pkt, PHB * phb, int type);
-unsigned short free_packets(PHB * phb, int type);
-int can_remove_start(PKT ** pkt, PHB * phb, int type);
-int can_add_start(PHB * phb, int type);
-int can_add_end(PHB * phb, int type);
-void put_free_end(PKT * pkt);
-int remove_start(PKT ** pkt, PHB * phb, int type);
-#endif
-
-/*
-** Lrt.c
-*/
-void lrt(Process * lrt_p, LPB * link);
-
-#ifdef RTA
-void set_led_red(LPB * link);
-#endif
-
-/*
-** ltt.c
-*/
-void ltt(Process * ltt_p, LPB * link, PHB * phb_ptr[]);
-void send_poll(LPB * link);
-void request_id(LPB * link);
-void send_topology_update(LPB * link);
-void send_topology(LPB * link);
-void supply_id(LPB * link);
-
-#ifdef RTA
-void redirect_queue(LPB * link, ushort flush);
-int obtain_rup(int rup_number, PKT ** pkt_address, LPB * link);
-#endif
-
-#ifdef TESTING_PERF
-int consume_cpu(void);
-#endif
-
-/*
-** lttwake.c
-*/
-#ifdef HOST
-void ltt_wakeup(Process * ltt_wakeup_p);
-#endif
-
-/*
-** mapgen.c
-*/
-void generate_id_map(short mapping, ROUTE_STR route[]);
-void gen_map(int mapping, int looking_at, int come_from, ROUTE_STR route[], int link, int *ttl);
-void adjust_ttl(int mapping, int looking_at, int come_from, ROUTE_STR route[], int link, int *ttl);
-void init_sys_map(void);
-
-/*
-** mmu.c
-*/
-char *rio_malloc(unsigned int amount);
-char *rio_calloc(unsigned int num, unsigned int size);
-ERROR rio_mmu_init(uint total_mem);
-
-/*
-** partn.c
-*/
-void partition_tx(struct PHB *phb, u_short tx_size, u_short rx_size, u_short rx_limit);
-
-/*
-** poll.c
-*/
-void tx_poll(Process * tx_poll_p);
-
-/*
-** process.c
-*/
-int get_proc_space(Process ** pd, int **pws, int wssize);
-
-/*
-** readrom.c
-*/
-void read_serial_number(char *buf);
-
-/*
-** rio.c
-*/
-int main(void);
-
-/*
-** route.c
-*/
-void route_update(PKT * pkt, LPB * link);
-
-/*
-** rtainit.c
-*/
-#if defined(RTA)
-void rta_init(ushort RtaType);
-#endif				/* defined(RTA) */
-
-/*
-** rupboot.c
-*/
-void rup_boot(PKT * pkt, RUP * this_rup, LPB * link);
-
-#ifdef RTA
-void kill_your_neighbour(int link_to_kill);
-#endif
-
-/*
-** rupcmd.c
-*/
-void rup_command(PKT * pkt, struct RUP *this_rup, LPB * link);
-
-/*
-** ruperr.c
-*/
-void rup_error(PKT * pkt, RUP * this_rup, LPB * link);
-void illegal_cmd(PKT * src_pkt);
-
-/*
-** ruppoll.c
-*/
-void rup_poll(PKT * pkt, RUP * this_rup, LPB * link);
-
-/*
-** ruppower.c
-*/
-void rup_power(PKT * pkt, RUP * this_rup, LPB * link);
-
-/*
-** ruprm.c
-*/
-void rup_route_map(PKT * pkt, RUP * this_rup, LPB * link);
-
-/*
-** rupstat.c
-*/
-void rup_status(PKT * pkt, RUP * this_rup, LPB * link);
-
-/*
-** rupsync.c
-*/
-void rup_sync(PKT * pkt);
-
-/*
-** rxpkt.c
-*/
-ERROR rx_pkt(PKT_ptr_ptr pkt_address, LPB * link);
-
-/*
-** sendsts.c
-*/
-void send_status(PKT * requesting_pkt, RUP * this_rup);
-
-/*
-** serial.c
-*/
-void assign_serial(char *ser_in, char *ser_out);
-int cmp_serial(char *ser_1, char *ser_2);
-
-/*
-** txpkt.c
-*/
-ERROR tx_pkt(PKT * pkt, LPB * link);
-short send_sync(LPB * link);
-
-#endif				/* _prototypes_h */

