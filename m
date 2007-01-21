Return-Path: <linux-kernel-owner+w=401wt.eu-S1751437AbXAUTNx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbXAUTNx (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 14:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbXAUTNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 14:13:52 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4211 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751409AbXAUTNr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 14:13:47 -0500
Date: Sun, 21 Jan 2007 20:13:52 +0100
From: Adrian Bunk <bunk@stusta.de>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au,
       nfs@lists.sourceforge.net, trond.myklebust@fys.uio.no
Subject: [2.6 patch] net/sunrpc/: cleanups
Message-ID: <20070121191352.GP9093@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- proper prototypes in header files for global variables and functions
- make the following needlessly global struct static:
  - auth_gss/gss_spkm3_seal.c: struct cast5_cbc_oid
- make the following needlessly global variables static:
  - xprtsock.c: xprt_udp_slot_table_entries
  - xprtsock.c: xprt_tcp_slot_table_entries
  - xprtsock.c: xprt_min_resvport
  - xprtsock.c: xprt_max_resvport
- make the following needlessly global functions static:
  - auth_gss/gss_spkm3_seal.c: gss_mech_get()
  - clnt.c: rpc_ping()
  - xdr.c: write_bytes_to_xdr_buf()
- remove the following unused EXPORT_SYMBOL's:
  - auth_gss/gss_mech_switch.c: gss_mech_get_by_name
  - auth_gss/gss_mech_switch.c: gss_mech_get_by_pseudoflavor
  - auth_gss/gss_mech_switch.c: gss_pseudoflavor_to_service
  - auth_gss/gss_mech_switch.c: gss_service_to_auth_domain_name
  - auth_gss/gss_mech_switch.c: gss_mech_put
  - auth_gss/svcauth_gss.c: svcauth_gss_register_pseudoflavor
  - auth_gss/svcauth_gss.c: svcauth_gss_unregister_pseudoflavor
  - auth_gss/gss_spkm3_seal.c: make_spkm3_checksum
  - stats.c: rpc_alloc_iostats
  - stats.c: rpc_free_iostats
  - sunrpc_syms.c: rpc_wake_up_next
  - sunrpc_syms.c: rpc_killall_tasks
  - sunrpc_syms.c: xprt_set_timeout
  - sunrpc_syms.c: svc_drop
  - sunrpc_syms.c: svc_authenticate
- remove the following unused EXPORT_SYMBOL_GPL:
  - clnt.c: rpc_peeraddr2str

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/linux/sunrpc/clnt.h           |    1 -
 include/linux/sunrpc/gss_api.h        |    3 ---
 include/linux/sunrpc/gss_spkm3.h      |    1 -
 include/linux/sunrpc/rpc_pipe_fs.h    |    3 +++
 include/linux/sunrpc/svcauth.h        |    1 +
 include/linux/sunrpc/xdr.h            |    1 -
 include/linux/sunrpc/xprt.h           |   12 +++---------
 net/sunrpc/auth_gss/gss_mech_switch.c |   14 +-------------
 net/sunrpc/auth_gss/gss_spkm3_seal.c  |    3 +--
 net/sunrpc/auth_gss/svcauth_gss.c     |    4 ----
 net/sunrpc/clnt.c                     |    5 +++--
 net/sunrpc/stats.c                    |    2 --
 net/sunrpc/sunrpc_syms.c              |   16 +++-------------
 net/sunrpc/xdr.c                      |    3 ++-
 net/sunrpc/xprtsock.c                 |    9 +++++----
 15 files changed, 22 insertions(+), 56 deletions(-)

--- linux-2.6.20-rc4-mm1/include/linux/sunrpc/gss_api.h.old	2007-01-20 15:37:56.000000000 +0100
+++ linux-2.6.20-rc4-mm1/include/linux/sunrpc/gss_api.h	2007-01-20 15:38:07.000000000 +0100
@@ -123,9 +123,6 @@
 /* Similar, but get by pseudoflavor. */
 struct gss_api_mech *gss_mech_get_by_pseudoflavor(u32);
 
-/* Just increments the mechanism's reference count and returns its input: */
-struct gss_api_mech * gss_mech_get(struct gss_api_mech *);
-
 /* For every successful gss_mech_get or gss_mech_get_by_* call there must be a
  * corresponding call to gss_mech_put. */
 void gss_mech_put(struct gss_api_mech *);
--- linux-2.6.20-rc4-mm1/net/sunrpc/auth_gss/gss_mech_switch.c.old	2007-01-20 15:38:19.000000000 +0100
+++ linux-2.6.20-rc4-mm1/net/sunrpc/auth_gss/gss_mech_switch.c	2007-01-20 15:39:45.000000000 +0100
@@ -137,15 +137,13 @@
 
 EXPORT_SYMBOL(gss_mech_unregister);
 
-struct gss_api_mech *
+static struct gss_api_mech *
 gss_mech_get(struct gss_api_mech *gm)
 {
 	__module_get(gm->gm_owner);
 	return gm;
 }
 
-EXPORT_SYMBOL(gss_mech_get);
-
 struct gss_api_mech *
 gss_mech_get_by_name(const char *name)
 {
@@ -164,8 +162,6 @@
 
 }
 
-EXPORT_SYMBOL(gss_mech_get_by_name);
-
 static inline int
 mech_supports_pseudoflavor(struct gss_api_mech *gm, u32 pseudoflavor)
 {
@@ -197,8 +193,6 @@
 	return gm;
 }
 
-EXPORT_SYMBOL(gss_mech_get_by_pseudoflavor);
-
 u32
 gss_pseudoflavor_to_service(struct gss_api_mech *gm, u32 pseudoflavor)
 {
@@ -211,8 +205,6 @@
 	return 0;
 }
 
-EXPORT_SYMBOL(gss_pseudoflavor_to_service);
-
 char *
 gss_service_to_auth_domain_name(struct gss_api_mech *gm, u32 service)
 {
@@ -225,8 +217,6 @@
 	return NULL;
 }
 
-EXPORT_SYMBOL(gss_service_to_auth_domain_name);
-
 void
 gss_mech_put(struct gss_api_mech * gm)
 {
@@ -234,8 +224,6 @@
 		module_put(gm->gm_owner);
 }
 
-EXPORT_SYMBOL(gss_mech_put);
-
 /* The mech could probably be determined from the token instead, but it's just
  * as easy for now to pass it in. */
 int
--- linux-2.6.20-rc4-mm1/net/sunrpc/auth_gss/svcauth_gss.c.old	2007-01-20 15:41:02.000000000 +0100
+++ linux-2.6.20-rc4-mm1/net/sunrpc/auth_gss/svcauth_gss.c	2007-01-20 20:52:55.000000000 +0100
@@ -775,8 +775,6 @@
 	return stat;
 }
 
-EXPORT_SYMBOL(svcauth_gss_register_pseudoflavor);
-
 void svcauth_gss_unregister_pseudoflavor(char *name)
 {
 	struct auth_domain *dom;
@@ -788,8 +786,6 @@
 	}
 }
 
-EXPORT_SYMBOL(svcauth_gss_unregister_pseudoflavor);
-
 static inline int
 read_u32_from_xdr_buf(struct xdr_buf *buf, int base, u32 *obj)
 {
--- linux-2.6.20-rc4-mm1/net/sunrpc/stats.c.old	2007-01-20 15:41:45.000000000 +0100
+++ linux-2.6.20-rc4-mm1/net/sunrpc/stats.c	2007-01-20 15:43:26.000000000 +0100
@@ -117,7 +117,6 @@
 	new = kcalloc(clnt->cl_maxproc, sizeof(struct rpc_iostats), GFP_KERNEL);
 	return new;
 }
-EXPORT_SYMBOL(rpc_alloc_iostats);
 
 /**
  * rpc_free_iostats - release an rpc_iostats structure
@@ -128,7 +127,6 @@
 {
 	kfree(stats);
 }
-EXPORT_SYMBOL(rpc_free_iostats);
 
 /**
  * rpc_count_iostats - tally up per-task stats
--- linux-2.6.20-rc4-mm1/include/linux/sunrpc/gss_spkm3.h.old	2007-01-20 15:44:53.000000000 +0100
+++ linux-2.6.20-rc4-mm1/include/linux/sunrpc/gss_spkm3.h	2007-01-20 15:44:59.000000000 +0100
@@ -24,7 +24,6 @@
 
 /* OIDs declarations for K-ALG, I-ALG, C-ALG, and OWF-ALG */
 extern const struct xdr_netobj hmac_md5_oid;
-extern const struct xdr_netobj cast5_cbc_oid;
 
 /* SPKM InnerContext Token types */
 
--- linux-2.6.20-rc4-mm1/net/sunrpc/auth_gss/gss_spkm3_seal.c.old	2007-01-20 15:44:10.000000000 +0100
+++ linux-2.6.20-rc4-mm1/net/sunrpc/auth_gss/gss_spkm3_seal.c	2007-01-20 20:52:24.000000000 +0100
@@ -48,7 +48,7 @@
 #endif
 
 const struct xdr_netobj hmac_md5_oid = { 8, "\x2B\x06\x01\x05\x05\x08\x01\x01"};
-const struct xdr_netobj cast5_cbc_oid = {9, "\x2A\x86\x48\x86\xF6\x7D\x07\x42\x0A"};
+static const struct xdr_netobj cast5_cbc_oid = {9, "\x2A\x86\x48\x86\xF6\x7D\x07\x42\x0A"};
 
 /*
  * spkm3_make_token()
@@ -183,4 +183,3 @@
 	return err ? GSS_S_FAILURE : 0;
 }
 
-EXPORT_SYMBOL(make_spkm3_checksum);
--- linux-2.6.20-rc4-mm1/include/linux/sunrpc/clnt.h.old	2007-01-20 15:45:17.000000000 +0100
+++ linux-2.6.20-rc4-mm1/include/linux/sunrpc/clnt.h	2007-01-20 15:45:24.000000000 +0100
@@ -135,7 +135,6 @@
 void		rpc_setbufsize(struct rpc_clnt *, unsigned int, unsigned int);
 size_t		rpc_max_payload(struct rpc_clnt *);
 void		rpc_force_rebind(struct rpc_clnt *);
-int		rpc_ping(struct rpc_clnt *clnt, int flags);
 size_t		rpc_peeraddr(struct rpc_clnt *, struct sockaddr *, size_t);
 char *		rpc_peeraddr2str(struct rpc_clnt *, enum rpc_display_format_t);
 
--- linux-2.6.20-rc4-mm1/net/sunrpc/clnt.c.old	2007-01-20 15:45:34.000000000 +0100
+++ linux-2.6.20-rc4-mm1/net/sunrpc/clnt.c	2007-01-20 20:51:41.000000000 +0100
@@ -64,6 +64,8 @@
 static __be32 *	call_header(struct rpc_task *task);
 static __be32 *	call_verify(struct rpc_task *task);
 
+static int	rpc_ping(struct rpc_clnt *clnt, int flags);
+
 
 static int
 rpc_setup_pipedir(struct rpc_clnt *clnt, char *dir_name)
@@ -600,7 +602,6 @@
 	else
 		return "unprintable";
 }
-EXPORT_SYMBOL_GPL(rpc_peeraddr2str);
 
 void
 rpc_setbufsize(struct rpc_clnt *clnt, unsigned int sndsize, unsigned int rcvsize)
@@ -1395,7 +1396,7 @@
 	.p_decode = rpcproc_decode_null,
 };
 
-int rpc_ping(struct rpc_clnt *clnt, int flags)
+static int rpc_ping(struct rpc_clnt *clnt, int flags)
 {
 	struct rpc_message msg = {
 		.rpc_proc = &rpcproc_null,
--- linux-2.6.20-rc4-mm1/include/linux/sunrpc/xdr.h.old	2007-01-20 15:46:49.000000000 +0100
+++ linux-2.6.20-rc4-mm1/include/linux/sunrpc/xdr.h	2007-01-20 15:46:56.000000000 +0100
@@ -143,7 +143,6 @@
 extern int xdr_buf_subsegment(struct xdr_buf *, struct xdr_buf *, unsigned int, unsigned int);
 extern int xdr_buf_read_netobj(struct xdr_buf *, struct xdr_netobj *, unsigned int);
 extern int read_bytes_from_xdr_buf(struct xdr_buf *, unsigned int, void *, unsigned int);
-extern int write_bytes_to_xdr_buf(struct xdr_buf *, unsigned int, void *, unsigned int);
 
 /*
  * Helper structure for copying from an sk_buff.
--- linux-2.6.20-rc4-mm1/net/sunrpc/xdr.c.old	2007-01-20 15:47:04.000000000 +0100
+++ linux-2.6.20-rc4-mm1/net/sunrpc/xdr.c	2007-01-20 15:47:29.000000000 +0100
@@ -736,7 +736,8 @@
 }
 
 /* obj is assumed to point to allocated memory of size at least len: */
-int write_bytes_to_xdr_buf(struct xdr_buf *buf, unsigned int base, void *obj, unsigned int len)
+static int write_bytes_to_xdr_buf(struct xdr_buf *buf, unsigned int base,
+				  void *obj, unsigned int len)
 {
 	struct xdr_buf subbuf;
 	int status;
--- linux-2.6.20-rc4-mm1/include/linux/sunrpc/xprt.h.old	2007-01-20 15:48:05.000000000 +0100
+++ linux-2.6.20-rc4-mm1/include/linux/sunrpc/xprt.h	2007-01-20 15:52:08.000000000 +0100
@@ -17,19 +17,10 @@
 #include <linux/sunrpc/xdr.h>
 #include <linux/sunrpc/msg_prot.h>
 
-extern unsigned int xprt_udp_slot_table_entries;
-extern unsigned int xprt_tcp_slot_table_entries;
-
 #define RPC_MIN_SLOT_TABLE	(2U)
 #define RPC_DEF_SLOT_TABLE	(16U)
 #define RPC_MAX_SLOT_TABLE	(128U)
 
-/*
- * Parameters for choosing a free port
- */
-extern unsigned int xprt_min_resvport;
-extern unsigned int xprt_max_resvport;
-
 #define RPC_MIN_RESVPORT	(1U)
 #define RPC_MAX_RESVPORT	(65535U)
 #define RPC_DEF_MIN_RESVPORT	(665U)
@@ -242,6 +233,9 @@
 struct rpc_xprt *	xs_setup_udp(struct sockaddr *addr, size_t addrlen, struct rpc_timeout *to);
 struct rpc_xprt *	xs_setup_tcp(struct sockaddr *addr, size_t addrlen, struct rpc_timeout *to);
 
+int			init_socket_xprt(void);
+void			cleanup_socket_xprt(void);
+
 /*
  * Reserved bit positions in xprt->state
  */
--- linux-2.6.20-rc4-mm1/net/sunrpc/xprtsock.c.old	2007-01-20 15:48:19.000000000 +0100
+++ linux-2.6.20-rc4-mm1/net/sunrpc/xprtsock.c	2007-01-20 15:54:04.000000000 +0100
@@ -28,6 +28,7 @@
 #include <linux/tcp.h>
 #include <linux/sunrpc/clnt.h>
 #include <linux/sunrpc/sched.h>
+#include <linux/sunrpc/xprt.h>
 #include <linux/file.h>
 
 #include <net/sock.h>
@@ -38,11 +39,11 @@
 /*
  * xprtsock tunables
  */
-unsigned int xprt_udp_slot_table_entries = RPC_DEF_SLOT_TABLE;
-unsigned int xprt_tcp_slot_table_entries = RPC_DEF_SLOT_TABLE;
+static unsigned int xprt_udp_slot_table_entries = RPC_DEF_SLOT_TABLE;
+static unsigned int xprt_tcp_slot_table_entries = RPC_DEF_SLOT_TABLE;
 
-unsigned int xprt_min_resvport = RPC_DEF_MIN_RESVPORT;
-unsigned int xprt_max_resvport = RPC_DEF_MAX_RESVPORT;
+static unsigned int xprt_min_resvport = RPC_DEF_MIN_RESVPORT;
+static unsigned int xprt_max_resvport = RPC_DEF_MAX_RESVPORT;
 
 /*
  * We can register our own files under /proc/sys/sunrpc by
--- linux-2.6.20-rc4-mm1/include/linux/sunrpc/rpc_pipe_fs.h.old	2007-01-20 15:55:03.000000000 +0100
+++ linux-2.6.20-rc4-mm1/include/linux/sunrpc/rpc_pipe_fs.h	2007-01-20 15:55:22.000000000 +0100
@@ -48,5 +48,8 @@
 extern struct vfsmount *rpc_get_mount(void);
 extern void rpc_put_mount(void);
 
+extern int register_rpc_pipefs(void);
+extern void unregister_rpc_pipefs(void);
+
 #endif
 #endif
--- linux-2.6.20-rc4-mm1/include/linux/sunrpc/svcauth.h.old	2007-01-20 15:56:27.000000000 +0100
+++ linux-2.6.20-rc4-mm1/include/linux/sunrpc/svcauth.h	2007-01-20 15:57:00.000000000 +0100
@@ -111,6 +111,7 @@
 #define	SVC_PENDING	8
 #define	SVC_COMPLETE	9
 
+extern struct cache_detail ip_map_cache;
 
 extern int	svc_authenticate(struct svc_rqst *rqstp, __be32 *authp);
 extern int	svc_authorise(struct svc_rqst *rqstp);
--- linux-2.6.20-rc4-mm1/net/sunrpc/sunrpc_syms.c.old	2007-01-20 15:52:16.000000000 +0100
+++ linux-2.6.20-rc4-mm1/net/sunrpc/sunrpc_syms.c	2007-01-20 20:50:39.000000000 +0100
@@ -20,13 +20,15 @@
 #include <linux/sunrpc/auth.h>
 #include <linux/workqueue.h>
 #include <linux/sunrpc/rpc_pipe_fs.h>
+#include <linux/sunrpc/xprt.h>
+#include <linux/sunrpc/rpc_pipe_fs.h>
+#include <linux/sunrpc/svcauth.h>
 
 
 /* RPC scheduler */
 EXPORT_SYMBOL(rpc_execute);
 EXPORT_SYMBOL(rpc_init_task);
 EXPORT_SYMBOL(rpc_sleep_on);
-EXPORT_SYMBOL(rpc_wake_up_next);
 EXPORT_SYMBOL(rpc_wake_up_task);
 EXPORT_SYMBOL(rpciod_down);
 EXPORT_SYMBOL(rpciod_up);
@@ -38,7 +40,6 @@
 EXPORT_SYMBOL(rpc_bind_new_program);
 EXPORT_SYMBOL(rpc_destroy_client);
 EXPORT_SYMBOL(rpc_shutdown_client);
-EXPORT_SYMBOL(rpc_killall_tasks);
 EXPORT_SYMBOL(rpc_call_sync);
 EXPORT_SYMBOL(rpc_call_async);
 EXPORT_SYMBOL(rpc_call_setup);
@@ -52,9 +53,6 @@
 EXPORT_SYMBOL(rpc_queue_upcall);
 EXPORT_SYMBOL(rpc_mkpipe);
 
-/* Client transport */
-EXPORT_SYMBOL(xprt_set_timeout);
-
 /* Client credential cache */
 EXPORT_SYMBOL(rpcauth_register);
 EXPORT_SYMBOL(rpcauth_unregister);
@@ -72,7 +70,6 @@
 EXPORT_SYMBOL(svc_set_num_threads);
 EXPORT_SYMBOL(svc_exit_thread);
 EXPORT_SYMBOL(svc_destroy);
-EXPORT_SYMBOL(svc_drop);
 EXPORT_SYMBOL(svc_process);
 EXPORT_SYMBOL(svc_recv);
 EXPORT_SYMBOL(svc_wake_up);
@@ -80,7 +77,6 @@
 EXPORT_SYMBOL(svc_reserve);
 EXPORT_SYMBOL(svc_auth_register);
 EXPORT_SYMBOL(auth_domain_lookup);
-EXPORT_SYMBOL(svc_authenticate);
 EXPORT_SYMBOL(svc_set_client);
 
 /* RPC statistics */
@@ -134,12 +130,6 @@
 EXPORT_SYMBOL(nlm_debug);
 #endif
 
-extern int register_rpc_pipefs(void);
-extern void unregister_rpc_pipefs(void);
-extern struct cache_detail ip_map_cache;
-extern int init_socket_xprt(void);
-extern void cleanup_socket_xprt(void);
-
 static int __init
 init_sunrpc(void)
 {

