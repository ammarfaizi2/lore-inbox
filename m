Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967454AbWK2Xh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967454AbWK2Xh7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 18:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967678AbWK2Xh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 18:37:59 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:50075 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S967454AbWK2Xh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 18:37:57 -0500
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [GIT PULL] please pull infiniband.git
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 29 Nov 2006 15:37:55 -0800
Message-ID: <ada7ixdq0x8.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 29 Nov 2006 23:37:55.0707 (UTC) FILETIME=[6520ECB0:01C7140F]
Authentication-Results: sj-dkim-3; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim3002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

    master.kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This tree is also available from kernel.org mirrors at:

    git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This is the first batch of post-2.6.19 fixes:

Arne Redlich (1):
      IB/srp: Increase supported CDB size

Dotan Barak (1):
      RDMA/cm: Remove setting local write as part of QP access flags

Eric Sesterhenn (1):
      IB: kmemdup() cleanup

Hoang-Nam Nguyen (1):
      IB/ehca: Use WQE offset instead of WQE addr for pending work reqs

Jack Morgenstein (1):
      IB/mthca: Fix initial SRQ logsize for mem-free HCAs

Krishna Kumar (11):
      RDMA/cma: Optimize cma_bind_loopback() to check for empty list
      RDMA/cma: Remove redundant check in cma_add_one
      RDMA/addr: Use time_after_eq() instead of time_after() in queue_req()
      RDMA/cma: Rewrite cma_req_handler() to encapsulate common code
      RDMA/iwcm: Fix memory corruption bug in cm_work_handler()
      RDMA/iwcm: Fix memory leak
      RDMA/iwcm: Remove unnecessary initializations
      RDMA/iwcm: Remove unnecessary function argument
      RDMA/iwcm: Fix comment for iwcm_deref_id() to match code
      RDMA/amso1100: Prevent deadlock in destroy QP
      RDMA/addr: Fix some cancellation problems in process_req()

Michael S. Tsirkin (2):
      IPoIB: Fix skb leak when freeing neighbour
      IB/ucm: Fix deadlock in cleanup

Roland Dreier (5):
      IB/mthca: Fix section mismatches
      RDMA/amso1100: Fix section mismatches
      IB/ipath: Fix typo in pma_counter_select subscript
      IB: Convert kmem_cache_t -> struct kmem_cache
      RDMA/addr: list_move() cleanups

Sean Hefty (1):
      IB/cm: Fix automatic path migration support

Vu Pham (1):
      IB/srp: Fix memory leak on reconnect

 drivers/infiniband/core/addr.c                 |   19 ++--
 drivers/infiniband/core/cm.c                   |  121 ++++++++++++++++++------
 drivers/infiniband/core/cma.c                  |   49 ++++------
 drivers/infiniband/core/iwcm.c                 |   43 +++++----
 drivers/infiniband/core/mad.c                  |    2 +-
 drivers/infiniband/core/ucm.c                  |   20 ++--
 drivers/infiniband/hw/amso1100/c2.h            |    2 +-
 drivers/infiniband/hw/amso1100/c2_qp.c         |   36 ++++++--
 drivers/infiniband/hw/amso1100/c2_rnic.c       |    4 +-
 drivers/infiniband/hw/ehca/ehca_main.c         |    4 +-
 drivers/infiniband/hw/ehca/ehca_qp.c           |   22 ++---
 drivers/infiniband/hw/ehca/ipz_pt_fn.c         |   13 +++
 drivers/infiniband/hw/ehca/ipz_pt_fn.h         |   15 +++
 drivers/infiniband/hw/ipath/ipath_verbs.c      |    2 +-
 drivers/infiniband/hw/mthca/mthca_av.c         |    3 +-
 drivers/infiniband/hw/mthca/mthca_cq.c         |    3 +-
 drivers/infiniband/hw/mthca/mthca_eq.c         |   21 ++--
 drivers/infiniband/hw/mthca/mthca_mad.c        |    2 +-
 drivers/infiniband/hw/mthca/mthca_main.c       |   29 +++---
 drivers/infiniband/hw/mthca/mthca_mcg.c        |    3 +-
 drivers/infiniband/hw/mthca/mthca_mr.c         |    5 +-
 drivers/infiniband/hw/mthca/mthca_pd.c         |    3 +-
 drivers/infiniband/hw/mthca/mthca_provider.c   |    3 +-
 drivers/infiniband/hw/mthca/mthca_qp.c         |    3 +-
 drivers/infiniband/hw/mthca/mthca_srq.c        |    4 +-
 drivers/infiniband/ulp/ipoib/ipoib.h           |    2 +-
 drivers/infiniband/ulp/ipoib/ipoib_main.c      |   19 +++-
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c |    2 +-
 drivers/infiniband/ulp/iser/iscsi_iser.h       |    2 +-
 drivers/infiniband/ulp/srp/ib_srp.c            |   11 ++-
 include/rdma/ib_cm.h                           |   16 +++-
 include/rdma/ib_user_cm.h                      |    7 +-
 32 files changed, 297 insertions(+), 193 deletions(-)


diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
index e11187e..7767a11 100644
--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -139,7 +139,7 @@ static void queue_req(struct addr_req *r
 
 	mutex_lock(&lock);
 	list_for_each_entry_reverse(temp_req, &req_list, list) {
-		if (time_after(req->timeout, temp_req->timeout))
+		if (time_after_eq(req->timeout, temp_req->timeout))
 			break;
 	}
 
@@ -225,19 +225,17 @@ static void process_req(void *data)
 
 	mutex_lock(&lock);
 	list_for_each_entry_safe(req, temp_req, &req_list, list) {
-		if (req->status) {
+		if (req->status == -ENODATA) {
 			src_in = (struct sockaddr_in *) &req->src_addr;
 			dst_in = (struct sockaddr_in *) &req->dst_addr;
 			req->status = addr_resolve_remote(src_in, dst_in,
 							  req->addr);
+			if (req->status && time_after_eq(jiffies, req->timeout))
+				req->status = -ETIMEDOUT;
+			else if (req->status == -ENODATA)
+				continue;
 		}
-		if (req->status && time_after(jiffies, req->timeout))
-			req->status = -ETIMEDOUT;
-		else if (req->status == -ENODATA)
-			continue;
-
-		list_del(&req->list);
-		list_add_tail(&req->list, &done_list);
+		list_move_tail(&req->list, &done_list);
 	}
 
 	if (!list_empty(&req_list)) {
@@ -347,8 +345,7 @@ void rdma_addr_cancel(struct rdma_dev_ad
 		if (req->addr == addr) {
 			req->status = -ECANCELED;
 			req->timeout = jiffies;
-			list_del(&req->list);
-			list_add(&req->list, &req_list);
+			list_move(&req->list, &req_list);
 			set_timeout(req->timeout);
 			break;
 		}
diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 25b1018..e5dc453 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -147,12 +147,12 @@ struct cm_id_private {
 	__be32 rq_psn;
 	int timeout_ms;
 	enum ib_mtu path_mtu;
+	__be16 pkey;
 	u8 private_data_len;
 	u8 max_cm_retries;
 	u8 peer_to_peer;
 	u8 responder_resources;
 	u8 initiator_depth;
-	u8 local_ack_timeout;
 	u8 retry_count;
 	u8 rnr_retry_count;
 	u8 service_timeout;
@@ -240,11 +240,10 @@ static void * cm_copy_private_data(const
 	if (!private_data || !private_data_len)
 		return NULL;
 
-	data = kmalloc(private_data_len, GFP_KERNEL);
+	data = kmemdup(private_data, private_data_len, GFP_KERNEL);
 	if (!data)
 		return ERR_PTR(-ENOMEM);
 
-	memcpy(data, private_data, private_data_len);
 	return data;
 }
 
@@ -691,7 +690,7 @@ static void cm_enter_timewait(struct cm_
 	 * timewait before notifying the user that we've exited timewait.
 	 */
 	cm_id_priv->id.state = IB_CM_TIMEWAIT;
-	wait_time = cm_convert_to_ms(cm_id_priv->local_ack_timeout);
+	wait_time = cm_convert_to_ms(cm_id_priv->av.packet_life_time + 1);
 	queue_delayed_work(cm.wq, &cm_id_priv->timewait_info->work.work,
 			   msecs_to_jiffies(wait_time));
 	cm_id_priv->timewait_info = NULL;
@@ -1010,6 +1009,7 @@ int ib_send_cm_req(struct ib_cm_id *cm_i
 	cm_id_priv->responder_resources = param->responder_resources;
 	cm_id_priv->retry_count = param->retry_count;
 	cm_id_priv->path_mtu = param->primary_path->mtu;
+	cm_id_priv->pkey = param->primary_path->pkey;
 	cm_id_priv->qp_type = param->qp_type;
 
 	ret = cm_alloc_msg(cm_id_priv, &cm_id_priv->msg);
@@ -1024,8 +1024,6 @@ int ib_send_cm_req(struct ib_cm_id *cm_i
 
 	cm_id_priv->local_qpn = cm_req_get_local_qpn(req_msg);
 	cm_id_priv->rq_psn = cm_req_get_starting_psn(req_msg);
-	cm_id_priv->local_ack_timeout =
-				cm_req_get_primary_local_ack_timeout(req_msg);
 
 	spin_lock_irqsave(&cm_id_priv->lock, flags);
 	ret = ib_post_send_mad(cm_id_priv->msg, NULL);
@@ -1410,9 +1408,8 @@ static int cm_req_handler(struct cm_work
 	cm_id_priv->initiator_depth = cm_req_get_resp_res(req_msg);
 	cm_id_priv->responder_resources = cm_req_get_init_depth(req_msg);
 	cm_id_priv->path_mtu = cm_req_get_path_mtu(req_msg);
+	cm_id_priv->pkey = req_msg->pkey;
 	cm_id_priv->sq_psn = cm_req_get_starting_psn(req_msg);
-	cm_id_priv->local_ack_timeout =
-				cm_req_get_primary_local_ack_timeout(req_msg);
 	cm_id_priv->retry_count = cm_req_get_retry_count(req_msg);
 	cm_id_priv->rnr_retry_count = cm_req_get_rnr_retry_count(req_msg);
 	cm_id_priv->qp_type = cm_req_get_qp_type(req_msg);
@@ -1716,7 +1713,7 @@ static int cm_establish_handler(struct c
 	unsigned long flags;
 	int ret;
 
-	/* See comment in ib_cm_establish about lookup. */
+	/* See comment in cm_establish about lookup. */
 	cm_id_priv = cm_acquire_id(work->local_id, work->remote_id);
 	if (!cm_id_priv)
 		return -EINVAL;
@@ -2402,11 +2399,16 @@ int ib_send_cm_lap(struct ib_cm_id *cm_i
 	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
 	spin_lock_irqsave(&cm_id_priv->lock, flags);
 	if (cm_id->state != IB_CM_ESTABLISHED ||
-	    cm_id->lap_state != IB_CM_LAP_IDLE) {
+	    (cm_id->lap_state != IB_CM_LAP_UNINIT &&
+	     cm_id->lap_state != IB_CM_LAP_IDLE)) {
 		ret = -EINVAL;
 		goto out;
 	}
 
+	ret = cm_init_av_by_path(alternate_path, &cm_id_priv->alt_av);
+	if (ret)
+		goto out;
+
 	ret = cm_alloc_msg(cm_id_priv, &msg);
 	if (ret)
 		goto out;
@@ -2431,7 +2433,8 @@ out:	spin_unlock_irqrestore(&cm_id_priv-
 }
 EXPORT_SYMBOL(ib_send_cm_lap);
 
-static void cm_format_path_from_lap(struct ib_sa_path_rec *path,
+static void cm_format_path_from_lap(struct cm_id_private *cm_id_priv,
+				    struct ib_sa_path_rec *path,
 				    struct cm_lap_msg *lap_msg)
 {
 	memset(path, 0, sizeof *path);
@@ -2443,10 +2446,10 @@ static void cm_format_path_from_lap(stru
 	path->hop_limit = lap_msg->alt_hop_limit;
 	path->traffic_class = cm_lap_get_traffic_class(lap_msg);
 	path->reversible = 1;
-	/* pkey is same as in REQ */
+	path->pkey = cm_id_priv->pkey;
 	path->sl = cm_lap_get_sl(lap_msg);
 	path->mtu_selector = IB_SA_EQ;
-	/* mtu is same as in REQ */
+	path->mtu = cm_id_priv->path_mtu;
 	path->rate_selector = IB_SA_EQ;
 	path->rate = cm_lap_get_packet_rate(lap_msg);
 	path->packet_life_time_selector = IB_SA_EQ;
@@ -2472,7 +2475,7 @@ static int cm_lap_handler(struct cm_work
 
 	param = &work->cm_event.param.lap_rcvd;
 	param->alternate_path = &work->path[0];
-	cm_format_path_from_lap(param->alternate_path, lap_msg);
+	cm_format_path_from_lap(cm_id_priv, param->alternate_path, lap_msg);
 	work->cm_event.private_data = &lap_msg->private_data;
 
 	spin_lock_irqsave(&cm_id_priv->lock, flags);
@@ -2480,6 +2483,7 @@ static int cm_lap_handler(struct cm_work
 		goto unlock;
 
 	switch (cm_id_priv->id.lap_state) {
+	case IB_CM_LAP_UNINIT:
 	case IB_CM_LAP_IDLE:
 		break;
 	case IB_CM_MRA_LAP_SENT:
@@ -2502,6 +2506,10 @@ static int cm_lap_handler(struct cm_work
 
 	cm_id_priv->id.lap_state = IB_CM_LAP_RCVD;
 	cm_id_priv->tid = lap_msg->hdr.tid;
+	cm_init_av_for_response(work->port, work->mad_recv_wc->wc,
+				work->mad_recv_wc->recv_buf.grh,
+				&cm_id_priv->av);
+	cm_init_av_by_path(param->alternate_path, &cm_id_priv->alt_av);
 	ret = atomic_inc_and_test(&cm_id_priv->work_count);
 	if (!ret)
 		list_add_tail(&work->list, &cm_id_priv->work_list);
@@ -3040,7 +3048,7 @@ static void cm_work_handler(void *data)
 		cm_free_work(work);
 }
 
-int ib_cm_establish(struct ib_cm_id *cm_id)
+static int cm_establish(struct ib_cm_id *cm_id)
 {
 	struct cm_id_private *cm_id_priv;
 	struct cm_work *work;
@@ -3088,7 +3096,44 @@ int ib_cm_establish(struct ib_cm_id *cm_
 out:
 	return ret;
 }
-EXPORT_SYMBOL(ib_cm_establish);
+
+static int cm_migrate(struct ib_cm_id *cm_id)
+{
+	struct cm_id_private *cm_id_priv;
+	unsigned long flags;
+	int ret = 0;
+
+	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
+	spin_lock_irqsave(&cm_id_priv->lock, flags);
+	if (cm_id->state == IB_CM_ESTABLISHED &&
+	    (cm_id->lap_state == IB_CM_LAP_UNINIT ||
+	     cm_id->lap_state == IB_CM_LAP_IDLE)) {
+		cm_id->lap_state = IB_CM_LAP_IDLE;
+		cm_id_priv->av = cm_id_priv->alt_av;
+	} else
+		ret = -EINVAL;
+	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
+
+	return ret;
+}
+
+int ib_cm_notify(struct ib_cm_id *cm_id, enum ib_event_type event)
+{
+	int ret;
+
+	switch (event) {
+	case IB_EVENT_COMM_EST:
+		ret = cm_establish(cm_id);
+		break;
+	case IB_EVENT_PATH_MIG:
+		ret = cm_migrate(cm_id);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+	return ret;
+}
+EXPORT_SYMBOL(ib_cm_notify);
 
 static void cm_recv_handler(struct ib_mad_agent *mad_agent,
 			    struct ib_mad_recv_wc *mad_recv_wc)
@@ -3173,8 +3218,7 @@ static int cm_init_qp_init_attr(struct c
 	case IB_CM_ESTABLISHED:
 		*qp_attr_mask = IB_QP_STATE | IB_QP_ACCESS_FLAGS |
 				IB_QP_PKEY_INDEX | IB_QP_PORT;
-		qp_attr->qp_access_flags = IB_ACCESS_LOCAL_WRITE |
-					   IB_ACCESS_REMOTE_WRITE;
+		qp_attr->qp_access_flags = IB_ACCESS_REMOTE_WRITE;
 		if (cm_id_priv->responder_resources)
 			qp_attr->qp_access_flags |= IB_ACCESS_REMOTE_READ |
 						    IB_ACCESS_REMOTE_ATOMIC;
@@ -3222,6 +3266,9 @@ static int cm_init_qp_rtr_attr(struct cm
 		if (cm_id_priv->alt_av.ah_attr.dlid) {
 			*qp_attr_mask |= IB_QP_ALT_PATH;
 			qp_attr->alt_port_num = cm_id_priv->alt_av.port->port_num;
+			qp_attr->alt_pkey_index = cm_id_priv->alt_av.pkey_index;
+			qp_attr->alt_timeout =
+					cm_id_priv->alt_av.packet_life_time + 1;
 			qp_attr->alt_ah_attr = cm_id_priv->alt_av.ah_attr;
 		}
 		ret = 0;
@@ -3248,19 +3295,31 @@ static int cm_init_qp_rts_attr(struct cm
 	case IB_CM_REP_SENT:
 	case IB_CM_MRA_REP_RCVD:
 	case IB_CM_ESTABLISHED:
-		*qp_attr_mask = IB_QP_STATE | IB_QP_SQ_PSN;
-		qp_attr->sq_psn = be32_to_cpu(cm_id_priv->sq_psn);
-		if (cm_id_priv->qp_type == IB_QPT_RC) {
-			*qp_attr_mask |= IB_QP_TIMEOUT | IB_QP_RETRY_CNT |
-					 IB_QP_RNR_RETRY |
-					 IB_QP_MAX_QP_RD_ATOMIC;
-			qp_attr->timeout = cm_id_priv->local_ack_timeout;
-			qp_attr->retry_cnt = cm_id_priv->retry_count;
-			qp_attr->rnr_retry = cm_id_priv->rnr_retry_count;
-			qp_attr->max_rd_atomic = cm_id_priv->initiator_depth;
-		}
-		if (cm_id_priv->alt_av.ah_attr.dlid) {
-			*qp_attr_mask |= IB_QP_PATH_MIG_STATE;
+		if (cm_id_priv->id.lap_state == IB_CM_LAP_UNINIT) {
+			*qp_attr_mask = IB_QP_STATE | IB_QP_SQ_PSN;
+			qp_attr->sq_psn = be32_to_cpu(cm_id_priv->sq_psn);
+			if (cm_id_priv->qp_type == IB_QPT_RC) {
+				*qp_attr_mask |= IB_QP_TIMEOUT | IB_QP_RETRY_CNT |
+						 IB_QP_RNR_RETRY |
+						 IB_QP_MAX_QP_RD_ATOMIC;
+				qp_attr->timeout =
+					cm_id_priv->av.packet_life_time + 1;
+				qp_attr->retry_cnt = cm_id_priv->retry_count;
+				qp_attr->rnr_retry = cm_id_priv->rnr_retry_count;
+				qp_attr->max_rd_atomic =
+					cm_id_priv->initiator_depth;
+			}
+			if (cm_id_priv->alt_av.ah_attr.dlid) {
+				*qp_attr_mask |= IB_QP_PATH_MIG_STATE;
+				qp_attr->path_mig_state = IB_MIG_REARM;
+			}
+		} else {
+			*qp_attr_mask = IB_QP_ALT_PATH | IB_QP_PATH_MIG_STATE;
+			qp_attr->alt_port_num = cm_id_priv->alt_av.port->port_num;
+			qp_attr->alt_pkey_index = cm_id_priv->alt_av.pkey_index;
+			qp_attr->alt_timeout =
+				cm_id_priv->alt_av.packet_life_time + 1;
+			qp_attr->alt_ah_attr = cm_id_priv->alt_av.ah_attr;
 			qp_attr->path_mig_state = IB_MIG_REARM;
 		}
 		ret = 0;
diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 845090b..cf48f26 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -344,7 +344,7 @@ static int cma_init_ib_qp(struct rdma_id
 		return ret;
 
 	qp_attr.qp_state = IB_QPS_INIT;
-	qp_attr.qp_access_flags = IB_ACCESS_LOCAL_WRITE;
+	qp_attr.qp_access_flags = 0;
 	qp_attr.port_num = id_priv->id.port_num;
 	return ib_modify_qp(qp, &qp_attr, IB_QP_STATE | IB_QP_ACCESS_FLAGS |
 					  IB_QP_PKEY_INDEX | IB_QP_PORT);
@@ -935,13 +935,8 @@ static int cma_req_handler(struct ib_cm_
 	mutex_lock(&lock);
 	ret = cma_acquire_dev(conn_id);
 	mutex_unlock(&lock);
-	if (ret) {
-		ret = -ENODEV;
-		cma_exch(conn_id, CMA_DESTROYING);
-		cma_release_remove(conn_id);
-		rdma_destroy_id(&conn_id->id);
-		goto out;
-	}
+	if (ret)
+		goto release_conn_id;
 
 	conn_id->cm_id.ib = cm_id;
 	cm_id->context = conn_id;
@@ -951,13 +946,17 @@ static int cma_req_handler(struct ib_cm_
 	ret = cma_notify_user(conn_id, RDMA_CM_EVENT_CONNECT_REQUEST, 0,
 			      ib_event->private_data + offset,
 			      IB_CM_REQ_PRIVATE_DATA_SIZE - offset);
-	if (ret) {
-		/* Destroy the CM ID by returning a non-zero value. */
-		conn_id->cm_id.ib = NULL;
-		cma_exch(conn_id, CMA_DESTROYING);
-		cma_release_remove(conn_id);
-		rdma_destroy_id(&conn_id->id);
-	}
+	if (!ret)
+		goto out;
+
+	/* Destroy the CM ID by returning a non-zero value. */
+	conn_id->cm_id.ib = NULL;
+
+release_conn_id:
+	cma_exch(conn_id, CMA_DESTROYING);
+	cma_release_remove(conn_id);
+	rdma_destroy_id(&conn_id->id);
+
 out:
 	cma_release_remove(listen_id);
 	return ret;
@@ -1481,19 +1480,18 @@ static int cma_bind_loopback(struct rdma
 	u8 p;
 
 	mutex_lock(&lock);
+	if (list_empty(&dev_list)) {
+		ret = -ENODEV;
+		goto out;
+	}
 	list_for_each_entry(cma_dev, &dev_list, list)
 		for (p = 1; p <= cma_dev->device->phys_port_cnt; ++p)
-			if (!ib_query_port (cma_dev->device, p, &port_attr) &&
+			if (!ib_query_port(cma_dev->device, p, &port_attr) &&
 			    port_attr.state == IB_PORT_ACTIVE)
 				goto port_found;
 
-	if (!list_empty(&dev_list)) {
-		p = 1;
-		cma_dev = list_entry(dev_list.next, struct cma_device, list);
-	} else {
-		ret = -ENODEV;
-		goto out;
-	}
+	p = 1;
+	cma_dev = list_entry(dev_list.next, struct cma_device, list);
 
 port_found:
 	ret = ib_get_cached_gid(cma_dev->device, p, 0, &gid);
@@ -2123,8 +2121,6 @@ static void cma_add_one(struct ib_device
 
 	cma_dev->device = device;
 	cma_dev->node_guid = device->node_guid;
-	if (!cma_dev->node_guid)
-		goto err;
 
 	init_completion(&cma_dev->comp);
 	atomic_set(&cma_dev->refcount, 1);
@@ -2136,9 +2132,6 @@ static void cma_add_one(struct ib_device
 	list_for_each_entry(id_priv, &listen_any_list, list)
 		cma_listen_on_dev(id_priv, cma_dev);
 	mutex_unlock(&lock);
-	return;
-err:
-	kfree(cma_dev);
 }
 
 static int cma_remove_id_dev(struct rdma_id_private *id_priv)
diff --git a/drivers/infiniband/core/iwcm.c b/drivers/infiniband/core/iwcm.c
index c3fb304..cf797d7 100644
--- a/drivers/infiniband/core/iwcm.c
+++ b/drivers/infiniband/core/iwcm.c
@@ -80,7 +80,7 @@ struct iwcm_work {
  * 1) in the event upcall, cm_event_handler(), for a listening cm_id.  If
  *    the backlog is exceeded, then no more connection request events will
  *    be processed.  cm_event_handler() returns -ENOMEM in this case.  Its up
- *    to the provider to reject the connectino request.
+ *    to the provider to reject the connection request.
  * 2) in the connection request workqueue handler, cm_conn_req_handler().
  *    If work elements cannot be allocated for the new connect request cm_id,
  *    then IWCM will call the provider reject method.  This is ok since
@@ -131,26 +131,25 @@ static int alloc_work_entries(struct iwc
 }
 
 /*
- * Save private data from incoming connection requests in the
- * cm_id_priv so the low level driver doesn't have to.  Adjust
+ * Save private data from incoming connection requests to
+ * iw_cm_event, so the low level driver doesn't have to. Adjust
  * the event ptr to point to the local copy.
  */
-static int copy_private_data(struct iwcm_id_private *cm_id_priv,
-		       struct iw_cm_event *event)
+static int copy_private_data(struct iw_cm_event *event)
 {
 	void *p;
 
-	p = kmalloc(event->private_data_len, GFP_ATOMIC);
+	p = kmemdup(event->private_data, event->private_data_len, GFP_ATOMIC);
 	if (!p)
 		return -ENOMEM;
-	memcpy(p, event->private_data, event->private_data_len);
 	event->private_data = p;
 	return 0;
 }
 
 /*
- * Release a reference on cm_id. If the last reference is being removed
- * and iw_destroy_cm_id is waiting, wake up the waiting thread.
+ * Release a reference on cm_id. If the last reference is being
+ * released, enable the waiting thread (in iw_destroy_cm_id) to
+ * get woken up, and return 1 if a thread is already waiting.
  */
 static int iwcm_deref_id(struct iwcm_id_private *cm_id_priv)
 {
@@ -243,7 +242,7 @@ static int iwcm_modify_qp_sqd(struct ib_
 /*
  * CM_ID <-- CLOSING
  *
- * Block if a passive or active connection is currenlty being processed. Then
+ * Block if a passive or active connection is currently being processed. Then
  * process the event as follows:
  * - If we are ESTABLISHED, move to CLOSING and modify the QP state
  *   based on the abrupt flag
@@ -408,7 +407,7 @@ int iw_cm_listen(struct iw_cm_id *cm_id,
 {
 	struct iwcm_id_private *cm_id_priv;
 	unsigned long flags;
-	int ret = 0;
+	int ret;
 
 	cm_id_priv = container_of(cm_id, struct iwcm_id_private, id);
 
@@ -535,7 +534,7 @@ EXPORT_SYMBOL(iw_cm_accept);
 int iw_cm_connect(struct iw_cm_id *cm_id, struct iw_cm_conn_param *iw_param)
 {
 	struct iwcm_id_private *cm_id_priv;
-	int ret = 0;
+	int ret;
 	unsigned long flags;
 	struct ib_qp *qp;
 
@@ -620,7 +619,7 @@ static void cm_conn_req_handler(struct i
 	spin_lock_irqsave(&listen_id_priv->lock, flags);
 	if (listen_id_priv->state != IW_CM_STATE_LISTEN) {
 		spin_unlock_irqrestore(&listen_id_priv->lock, flags);
-		return;
+		goto out;
 	}
 	spin_unlock_irqrestore(&listen_id_priv->lock, flags);
 
@@ -629,7 +628,7 @@ static void cm_conn_req_handler(struct i
 				listen_id_priv->id.context);
 	/* If the cm_id could not be created, ignore the request */
 	if (IS_ERR(cm_id))
-		return;
+		goto out;
 
 	cm_id->provider_data = iw_event->provider_data;
 	cm_id->local_addr = iw_event->local_addr;
@@ -642,7 +641,7 @@ static void cm_conn_req_handler(struct i
 	if (ret) {
 		iw_cm_reject(cm_id, NULL, 0);
 		iw_destroy_cm_id(cm_id);
-		return;
+		goto out;
 	}
 
 	/* Call the client CM handler */
@@ -654,6 +653,7 @@ static void cm_conn_req_handler(struct i
 			kfree(cm_id);
 	}
 
+out:
 	if (iw_event->private_data_len)
 		kfree(iw_event->private_data);
 }
@@ -674,7 +674,7 @@ static int cm_conn_est_handler(struct iw
 			       struct iw_cm_event *iw_event)
 {
 	unsigned long flags;
-	int ret = 0;
+	int ret;
 
 	spin_lock_irqsave(&cm_id_priv->lock, flags);
 
@@ -704,7 +704,7 @@ static int cm_conn_rep_handler(struct iw
 			       struct iw_cm_event *iw_event)
 {
 	unsigned long flags;
-	int ret = 0;
+	int ret;
 
 	spin_lock_irqsave(&cm_id_priv->lock, flags);
 	/*
@@ -830,7 +830,8 @@ static int process_event(struct iwcm_id_
  */
 static void cm_work_handler(void *arg)
 {
-	struct iwcm_work *work = arg, lwork;
+	struct iwcm_work *work = arg;
+	struct iw_cm_event levent;
 	struct iwcm_id_private *cm_id_priv = work->cm_id;
 	unsigned long flags;
 	int empty;
@@ -843,11 +844,11 @@ static void cm_work_handler(void *arg)
 				  struct iwcm_work, list);
 		list_del_init(&work->list);
 		empty = list_empty(&cm_id_priv->work_list);
-		lwork = *work;
+		levent = work->event;
 		put_work(work);
 		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
 
-		ret = process_event(cm_id_priv, &work->event);
+		ret = process_event(cm_id_priv, &levent);
 		if (ret) {
 			set_bit(IWCM_F_CALLBACK_DESTROY, &cm_id_priv->flags);
 			destroy_cm_id(&cm_id_priv->id);
@@ -906,7 +907,7 @@ static int cm_event_handler(struct iw_cm
 	if ((work->event.event == IW_CM_EVENT_CONNECT_REQUEST ||
 	     work->event.event == IW_CM_EVENT_CONNECT_REPLY) &&
 	    work->event.private_data_len) {
-		ret = copy_private_data(cm_id_priv, &work->event);
+		ret = copy_private_data(&work->event);
 		if (ret) {
 			put_work(work);
 			goto out;
diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index a72bcea..3f9c162 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -46,7 +46,7 @@ MODULE_DESCRIPTION("kernel IB MAD API");
 MODULE_AUTHOR("Hal Rosenstock");
 MODULE_AUTHOR("Sean Hefty");
 
-static kmem_cache_t *ib_mad_cache;
+static struct kmem_cache *ib_mad_cache;
 
 static struct list_head ib_mad_port_list;
 static u32 ib_mad_client_id = 0;
diff --git a/drivers/infiniband/core/ucm.c b/drivers/infiniband/core/ucm.c
index ad4f4d5..f15220a 100644
--- a/drivers/infiniband/core/ucm.c
+++ b/drivers/infiniband/core/ucm.c
@@ -161,12 +161,14 @@ static void ib_ucm_cleanup_events(struct
 				    struct ib_ucm_event, ctx_list);
 		list_del(&uevent->file_list);
 		list_del(&uevent->ctx_list);
+		mutex_unlock(&ctx->file->file_mutex);
 
 		/* clear incoming connections. */
 		if (ib_ucm_new_cm_id(uevent->resp.event))
 			ib_destroy_cm_id(uevent->cm_id);
 
 		kfree(uevent);
+		mutex_lock(&ctx->file->file_mutex);
 	}
 	mutex_unlock(&ctx->file->file_mutex);
 }
@@ -328,20 +330,18 @@ static int ib_ucm_event_process(struct i
 	}
 
 	if (uvt->data_len) {
-		uvt->data = kmalloc(uvt->data_len, GFP_KERNEL);
+		uvt->data = kmemdup(evt->private_data, uvt->data_len, GFP_KERNEL);
 		if (!uvt->data)
 			goto err1;
 
-		memcpy(uvt->data, evt->private_data, uvt->data_len);
 		uvt->resp.present |= IB_UCM_PRES_DATA;
 	}
 
 	if (uvt->info_len) {
-		uvt->info = kmalloc(uvt->info_len, GFP_KERNEL);
+		uvt->info = kmemdup(info, uvt->info_len, GFP_KERNEL);
 		if (!uvt->info)
 			goto err2;
 
-		memcpy(uvt->info, info, uvt->info_len);
 		uvt->resp.present |= IB_UCM_PRES_INFO;
 	}
 	return 0;
@@ -685,11 +685,11 @@ out:
 	return result;
 }
 
-static ssize_t ib_ucm_establish(struct ib_ucm_file *file,
-				const char __user *inbuf,
-				int in_len, int out_len)
+static ssize_t ib_ucm_notify(struct ib_ucm_file *file,
+			     const char __user *inbuf,
+			     int in_len, int out_len)
 {
-	struct ib_ucm_establish cmd;
+	struct ib_ucm_notify cmd;
 	struct ib_ucm_context *ctx;
 	int result;
 
@@ -700,7 +700,7 @@ static ssize_t ib_ucm_establish(struct i
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
 
-	result = ib_cm_establish(ctx->cm_id);
+	result = ib_cm_notify(ctx->cm_id, (enum ib_event_type) cmd.event);
 	ib_ucm_ctx_put(ctx);
 	return result;
 }
@@ -1107,7 +1107,7 @@ static ssize_t (*ucm_cmd_table[])(struct
 	[IB_USER_CM_CMD_DESTROY_ID]    = ib_ucm_destroy_id,
 	[IB_USER_CM_CMD_ATTR_ID]       = ib_ucm_attr_id,
 	[IB_USER_CM_CMD_LISTEN]        = ib_ucm_listen,
-	[IB_USER_CM_CMD_ESTABLISH]     = ib_ucm_establish,
+	[IB_USER_CM_CMD_NOTIFY]        = ib_ucm_notify,
 	[IB_USER_CM_CMD_SEND_REQ]      = ib_ucm_send_req,
 	[IB_USER_CM_CMD_SEND_REP]      = ib_ucm_send_rep,
 	[IB_USER_CM_CMD_SEND_RTU]      = ib_ucm_send_rtu,
diff --git a/drivers/infiniband/hw/amso1100/c2.h b/drivers/infiniband/hw/amso1100/c2.h
index 1b17dcd..04a9db5 100644
--- a/drivers/infiniband/hw/amso1100/c2.h
+++ b/drivers/infiniband/hw/amso1100/c2.h
@@ -302,7 +302,7 @@ struct c2_dev {
 	unsigned long pa;	/* PA device memory */
 	void **qptr_array;
 
-	kmem_cache_t *host_msg_cache;
+	struct kmem_cache *host_msg_cache;
 
 	struct list_head cca_link;		/* adapter list */
 	struct list_head eh_wakeup_list;	/* event wakeup list */
diff --git a/drivers/infiniband/hw/amso1100/c2_qp.c b/drivers/infiniband/hw/amso1100/c2_qp.c
index 5bcf697..179d005 100644
--- a/drivers/infiniband/hw/amso1100/c2_qp.c
+++ b/drivers/infiniband/hw/amso1100/c2_qp.c
@@ -564,6 +564,32 @@ int c2_alloc_qp(struct c2_dev *c2dev,
 	return err;
 }
 
+static inline void c2_lock_cqs(struct c2_cq *send_cq, struct c2_cq *recv_cq)
+{
+	if (send_cq == recv_cq)
+		spin_lock_irq(&send_cq->lock);
+	else if (send_cq > recv_cq) {
+		spin_lock_irq(&send_cq->lock);
+		spin_lock_nested(&recv_cq->lock, SINGLE_DEPTH_NESTING);
+	} else {
+		spin_lock_irq(&recv_cq->lock);
+		spin_lock_nested(&send_cq->lock, SINGLE_DEPTH_NESTING);
+	}
+}
+
+static inline void c2_unlock_cqs(struct c2_cq *send_cq, struct c2_cq *recv_cq)
+{
+	if (send_cq == recv_cq)
+		spin_unlock_irq(&send_cq->lock);
+	else if (send_cq > recv_cq) {
+		spin_unlock(&recv_cq->lock);
+		spin_unlock_irq(&send_cq->lock);
+	} else {
+		spin_unlock(&send_cq->lock);
+		spin_unlock_irq(&recv_cq->lock);
+	}
+}
+
 void c2_free_qp(struct c2_dev *c2dev, struct c2_qp *qp)
 {
 	struct c2_cq *send_cq;
@@ -576,15 +602,9 @@ void c2_free_qp(struct c2_dev *c2dev, st
 	 * Lock CQs here, so that CQ polling code can do QP lookup
 	 * without taking a lock.
 	 */
-	spin_lock_irq(&send_cq->lock);
-	if (send_cq != recv_cq)
-		spin_lock(&recv_cq->lock);
-
+	c2_lock_cqs(send_cq, recv_cq);
 	c2_free_qpn(c2dev, qp->qpn);
-
-	if (send_cq != recv_cq)
-		spin_unlock(&recv_cq->lock);
-	spin_unlock_irq(&send_cq->lock);
+	c2_unlock_cqs(send_cq, recv_cq);
 
 	/*
 	 * Destory qp in the rnic...
diff --git a/drivers/infiniband/hw/amso1100/c2_rnic.c b/drivers/infiniband/hw/amso1100/c2_rnic.c
index 623dc95..1687c51 100644
--- a/drivers/infiniband/hw/amso1100/c2_rnic.c
+++ b/drivers/infiniband/hw/amso1100/c2_rnic.c
@@ -441,7 +441,7 @@ static int c2_rnic_close(struct c2_dev *
  * involves initalizing the various limits and resouce pools that
  * comprise the RNIC instance.
  */
-int c2_rnic_init(struct c2_dev *c2dev)
+int __devinit c2_rnic_init(struct c2_dev *c2dev)
 {
 	int err;
 	u32 qsize, msgsize;
@@ -611,7 +611,7 @@ int c2_rnic_init(struct c2_dev *c2dev)
 /*
  * Called by c2_remove to cleanup the RNIC resources.
  */
-void c2_rnic_term(struct c2_dev *c2dev)
+void __devexit c2_rnic_term(struct c2_dev *c2dev)
 {
 
 	/* Close the open adapter instance */
diff --git a/drivers/infiniband/hw/ehca/ehca_main.c b/drivers/infiniband/hw/ehca/ehca_main.c
index 01f5aa9..3d1c1c5 100644
--- a/drivers/infiniband/hw/ehca/ehca_main.c
+++ b/drivers/infiniband/hw/ehca/ehca_main.c
@@ -52,7 +52,7 @@ #include "hcp_if.h"
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Christoph Raisch <raisch@de.ibm.com>");
 MODULE_DESCRIPTION("IBM eServer HCA InfiniBand Device Driver");
-MODULE_VERSION("SVNEHCA_0018");
+MODULE_VERSION("SVNEHCA_0019");
 
 int ehca_open_aqp1     = 0;
 int ehca_debug_level   = 0;
@@ -790,7 +790,7 @@ int __init ehca_module_init(void)
 	int ret;
 
 	printk(KERN_INFO "eHCA Infiniband Device Driver "
-	                 "(Rel.: SVNEHCA_0018)\n");
+	                 "(Rel.: SVNEHCA_0019)\n");
 	idr_init(&ehca_qp_idr);
 	idr_init(&ehca_cq_idr);
 	spin_lock_init(&ehca_qp_idr_lock);
diff --git a/drivers/infiniband/hw/ehca/ehca_qp.c b/drivers/infiniband/hw/ehca/ehca_qp.c
index cf3e50e..8682aa5 100644
--- a/drivers/infiniband/hw/ehca/ehca_qp.c
+++ b/drivers/infiniband/hw/ehca/ehca_qp.c
@@ -732,8 +732,7 @@ static int prepare_sqe_rts(struct ehca_q
 	u64 h_ret;
 	struct ipz_queue *squeue;
 	void *bad_send_wqe_p, *bad_send_wqe_v;
-	void *squeue_start_p, *squeue_end_p;
-	void *squeue_start_v, *squeue_end_v;
+	u64 q_ofs;
 	struct ehca_wqe *wqe;
 	int qp_num = my_qp->ib_qp.qp_num;
 
@@ -755,26 +754,23 @@ static int prepare_sqe_rts(struct ehca_q
 	if (ehca_debug_level)
 		ehca_dmp(bad_send_wqe_v, 32, "qp_num=%x bad_wqe", qp_num);
 	squeue = &my_qp->ipz_squeue;
-	squeue_start_p = (void*)virt_to_abs(ipz_qeit_calc(squeue, 0L));
-	squeue_end_p = squeue_start_p+squeue->queue_length;
-	squeue_start_v = abs_to_virt((u64)squeue_start_p);
-	squeue_end_v = abs_to_virt((u64)squeue_end_p);
-	ehca_dbg(&shca->ib_device, "qp_num=%x squeue_start_v=%p squeue_end_v=%p",
-		 qp_num, squeue_start_v, squeue_end_v);
+	if (ipz_queue_abs_to_offset(squeue, (u64)bad_send_wqe_p, &q_ofs)) {
+		ehca_err(&shca->ib_device, "failed to get wqe offset qp_num=%x"
+			 " bad_send_wqe_p=%p", qp_num, bad_send_wqe_p);
+		return -EFAULT;
+	}
 
 	/* loop sets wqe's purge bit */
-	wqe = (struct ehca_wqe*)bad_send_wqe_v;
+	wqe = (struct ehca_wqe*)ipz_qeit_calc(squeue, q_ofs);
 	*bad_wqe_cnt = 0;
 	while (wqe->optype != 0xff && wqe->wqef != 0xff) {
 		if (ehca_debug_level)
 			ehca_dmp(wqe, 32, "qp_num=%x wqe", qp_num);
 		wqe->nr_of_data_seg = 0; /* suppress data access */
 		wqe->wqef = WQEF_PURGE; /* WQE to be purged */
-		wqe = (struct ehca_wqe*)((u8*)wqe+squeue->qe_size);
+		q_ofs = ipz_queue_advance_offset(squeue, q_ofs);
+		wqe = (struct ehca_wqe*)ipz_qeit_calc(squeue, q_ofs);
 		*bad_wqe_cnt = (*bad_wqe_cnt)+1;
-		if ((void*)wqe >= squeue_end_v) {
-			wqe = squeue_start_v;
-		}
 	}
 	/*
 	 * bad wqe will be reprocessed and ignored when pol_cq() is called,
diff --git a/drivers/infiniband/hw/ehca/ipz_pt_fn.c b/drivers/infiniband/hw/ehca/ipz_pt_fn.c
index e028ff1..bf7a400 100644
--- a/drivers/infiniband/hw/ehca/ipz_pt_fn.c
+++ b/drivers/infiniband/hw/ehca/ipz_pt_fn.c
@@ -70,6 +70,19 @@ void *ipz_qeit_eq_get_inc(struct ipz_que
 	return ret;
 }
 
+int ipz_queue_abs_to_offset(struct ipz_queue *queue, u64 addr, u64 *q_offset)
+{
+	int i;
+	for (i = 0; i < queue->queue_length / queue->pagesize; i++) {
+		u64 page = (u64)virt_to_abs(queue->queue_pages[i]);
+		if (addr >= page && addr < page + queue->pagesize) {
+			*q_offset = addr - page + i * queue->pagesize;
+			return 0;
+		}
+	}
+	return -EINVAL;
+}
+
 int ipz_queue_ctor(struct ipz_queue *queue,
 		   const u32 nr_of_pages,
 		   const u32 pagesize, const u32 qe_size, const u32 nr_of_sg)
diff --git a/drivers/infiniband/hw/ehca/ipz_pt_fn.h b/drivers/infiniband/hw/ehca/ipz_pt_fn.h
index 2f13509..dc3bda2 100644
--- a/drivers/infiniband/hw/ehca/ipz_pt_fn.h
+++ b/drivers/infiniband/hw/ehca/ipz_pt_fn.h
@@ -150,6 +150,21 @@ static inline void *ipz_qeit_reset(struc
 	return ipz_qeit_get(queue);
 }
 
+/*
+ * return the q_offset corresponding to an absolute address
+ */
+int ipz_queue_abs_to_offset(struct ipz_queue *queue, u64 addr, u64 *q_offset);
+
+/*
+ * return the next queue offset. don't modify the queue.
+ */
+static inline u64 ipz_queue_advance_offset(struct ipz_queue *queue, u64 offset)
+{
+	offset += queue->qe_size;
+	if (offset >= queue->queue_length) offset = 0;
+	return offset;
+}
+
 /* struct generic page table */
 struct ipz_pt {
 	u64 entries[EHCA_PT_ENTRIES];
diff --git a/drivers/infiniband/hw/ipath/ipath_verbs.c b/drivers/infiniband/hw/ipath/ipath_verbs.c
index a545610..acdee33 100644
--- a/drivers/infiniband/hw/ipath/ipath_verbs.c
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.c
@@ -1487,7 +1487,7 @@ int ipath_register_ib_device(struct ipat
 	idev->pma_counter_select[1] = IB_PMA_PORT_RCV_DATA;
 	idev->pma_counter_select[2] = IB_PMA_PORT_XMIT_PKTS;
 	idev->pma_counter_select[3] = IB_PMA_PORT_RCV_PKTS;
-	idev->pma_counter_select[5] = IB_PMA_PORT_XMIT_WAIT;
+	idev->pma_counter_select[4] = IB_PMA_PORT_XMIT_WAIT;
 	idev->link_width_enabled = 3;	/* 1x or 4x */
 
 	/* Snapshot current HW counters to "clear" them. */
diff --git a/drivers/infiniband/hw/mthca/mthca_av.c b/drivers/infiniband/hw/mthca/mthca_av.c
index 6959945..57cdc1b 100644
--- a/drivers/infiniband/hw/mthca/mthca_av.c
+++ b/drivers/infiniband/hw/mthca/mthca_av.c
@@ -33,7 +33,6 @@
  * $Id: mthca_av.c 1349 2004-12-16 21:09:43Z roland $
  */
 
-#include <linux/init.h>
 #include <linux/string.h>
 #include <linux/slab.h>
 
@@ -323,7 +322,7 @@ int mthca_ah_query(struct ib_ah *ibah, s
 	return 0;
 }
 
-int __devinit mthca_init_av_table(struct mthca_dev *dev)
+int mthca_init_av_table(struct mthca_dev *dev)
 {
 	int err;
 
diff --git a/drivers/infiniband/hw/mthca/mthca_cq.c b/drivers/infiniband/hw/mthca/mthca_cq.c
index 149b369..283d50b 100644
--- a/drivers/infiniband/hw/mthca/mthca_cq.c
+++ b/drivers/infiniband/hw/mthca/mthca_cq.c
@@ -36,7 +36,6 @@
  * $Id: mthca_cq.c 1369 2004-12-20 16:17:07Z roland $
  */
 
-#include <linux/init.h>
 #include <linux/hardirq.h>
 
 #include <asm/io.h>
@@ -970,7 +969,7 @@ void mthca_free_cq(struct mthca_dev *dev
 	mthca_free_mailbox(dev, mailbox);
 }
 
-int __devinit mthca_init_cq_table(struct mthca_dev *dev)
+int mthca_init_cq_table(struct mthca_dev *dev)
 {
 	int err;
 
diff --git a/drivers/infiniband/hw/mthca/mthca_eq.c b/drivers/infiniband/hw/mthca/mthca_eq.c
index e284e06..8ec9fa1 100644
--- a/drivers/infiniband/hw/mthca/mthca_eq.c
+++ b/drivers/infiniband/hw/mthca/mthca_eq.c
@@ -33,7 +33,6 @@
  * $Id: mthca_eq.c 1382 2004-12-24 02:21:02Z roland $
  */
 
-#include <linux/init.h>
 #include <linux/errno.h>
 #include <linux/interrupt.h>
 #include <linux/pci.h>
@@ -479,10 +478,10 @@ static irqreturn_t mthca_arbel_msi_x_int
 	return IRQ_HANDLED;
 }
 
-static int __devinit mthca_create_eq(struct mthca_dev *dev,
-				     int nent,
-				     u8 intr,
-				     struct mthca_eq *eq)
+static int mthca_create_eq(struct mthca_dev *dev,
+			   int nent,
+			   u8 intr,
+			   struct mthca_eq *eq)
 {
 	int npages;
 	u64 *dma_list = NULL;
@@ -664,9 +663,9 @@ static void mthca_free_irqs(struct mthca
 				 dev->eq_table.eq + i);
 }
 
-static int __devinit mthca_map_reg(struct mthca_dev *dev,
-				   unsigned long offset, unsigned long size,
-				   void __iomem **map)
+static int mthca_map_reg(struct mthca_dev *dev,
+			 unsigned long offset, unsigned long size,
+			 void __iomem **map)
 {
 	unsigned long base = pci_resource_start(dev->pdev, 0);
 
@@ -691,7 +690,7 @@ static void mthca_unmap_reg(struct mthca
 	iounmap(map);
 }
 
-static int __devinit mthca_map_eq_regs(struct mthca_dev *dev)
+static int mthca_map_eq_regs(struct mthca_dev *dev)
 {
 	if (mthca_is_memfree(dev)) {
 		/*
@@ -781,7 +780,7 @@ static void mthca_unmap_eq_regs(struct m
 	}
 }
 
-int __devinit mthca_map_eq_icm(struct mthca_dev *dev, u64 icm_virt)
+int mthca_map_eq_icm(struct mthca_dev *dev, u64 icm_virt)
 {
 	int ret;
 	u8 status;
@@ -825,7 +824,7 @@ void mthca_unmap_eq_icm(struct mthca_dev
 	__free_page(dev->eq_table.icm_page);
 }
 
-int __devinit mthca_init_eq_table(struct mthca_dev *dev)
+int mthca_init_eq_table(struct mthca_dev *dev)
 {
 	int err;
 	u8 status;
diff --git a/drivers/infiniband/hw/mthca/mthca_mad.c b/drivers/infiniband/hw/mthca/mthca_mad.c
index 45e106f..acfa41d 100644
--- a/drivers/infiniband/hw/mthca/mthca_mad.c
+++ b/drivers/infiniband/hw/mthca/mthca_mad.c
@@ -317,7 +317,7 @@ err:
 	return ret;
 }
 
-void __devexit mthca_free_agents(struct mthca_dev *dev)
+void mthca_free_agents(struct mthca_dev *dev)
 {
 	struct ib_mad_agent *agent;
 	int p, q;
diff --git a/drivers/infiniband/hw/mthca/mthca_main.c b/drivers/infiniband/hw/mthca/mthca_main.c
index 47ea021..0491ec7 100644
--- a/drivers/infiniband/hw/mthca/mthca_main.c
+++ b/drivers/infiniband/hw/mthca/mthca_main.c
@@ -98,7 +98,7 @@ static struct mthca_profile default_prof
 	.uarc_size	   = 1 << 18,	/* Arbel only */
 };
 
-static int __devinit mthca_tune_pci(struct mthca_dev *mdev)
+static int mthca_tune_pci(struct mthca_dev *mdev)
 {
 	int cap;
 	u16 val;
@@ -143,7 +143,7 @@ static int __devinit mthca_tune_pci(stru
 	return 0;
 }
 
-static int __devinit mthca_dev_lim(struct mthca_dev *mdev, struct mthca_dev_lim *dev_lim)
+static int mthca_dev_lim(struct mthca_dev *mdev, struct mthca_dev_lim *dev_lim)
 {
 	int err;
 	u8 status;
@@ -255,7 +255,7 @@ static int __devinit mthca_dev_lim(struc
 	return 0;
 }
 
-static int __devinit mthca_init_tavor(struct mthca_dev *mdev)
+static int mthca_init_tavor(struct mthca_dev *mdev)
 {
 	u8 status;
 	int err;
@@ -333,7 +333,7 @@ err_disable:
 	return err;
 }
 
-static int __devinit mthca_load_fw(struct mthca_dev *mdev)
+static int mthca_load_fw(struct mthca_dev *mdev)
 {
 	u8 status;
 	int err;
@@ -379,10 +379,10 @@ err_free:
 	return err;
 }
 
-static int __devinit mthca_init_icm(struct mthca_dev *mdev,
-				    struct mthca_dev_lim *dev_lim,
-				    struct mthca_init_hca_param *init_hca,
-				    u64 icm_size)
+static int mthca_init_icm(struct mthca_dev *mdev,
+			  struct mthca_dev_lim *dev_lim,
+			  struct mthca_init_hca_param *init_hca,
+			  u64 icm_size)
 {
 	u64 aux_pages;
 	u8 status;
@@ -575,7 +575,7 @@ static void mthca_free_icms(struct mthca
 	mthca_free_icm(mdev, mdev->fw.arbel.aux_icm);
 }
 
-static int __devinit mthca_init_arbel(struct mthca_dev *mdev)
+static int mthca_init_arbel(struct mthca_dev *mdev)
 {
 	struct mthca_dev_lim        dev_lim;
 	struct mthca_profile        profile;
@@ -683,7 +683,7 @@ static void mthca_close_hca(struct mthca
 		mthca_SYS_DIS(mdev, &status);
 }
 
-static int __devinit mthca_init_hca(struct mthca_dev *mdev)
+static int mthca_init_hca(struct mthca_dev *mdev)
 {
 	u8 status;
 	int err;
@@ -720,7 +720,7 @@ err_close:
 	return err;
 }
 
-static int __devinit mthca_setup_hca(struct mthca_dev *dev)
+static int mthca_setup_hca(struct mthca_dev *dev)
 {
 	int err;
 	u8 status;
@@ -875,8 +875,7 @@ err_uar_table_free:
 	return err;
 }
 
-static int __devinit mthca_request_regions(struct pci_dev *pdev,
-					   int ddr_hidden)
+static int mthca_request_regions(struct pci_dev *pdev, int ddr_hidden)
 {
 	int err;
 
@@ -928,7 +927,7 @@ static void mthca_release_regions(struct
 			   MTHCA_HCR_SIZE);
 }
 
-static int __devinit mthca_enable_msi_x(struct mthca_dev *mdev)
+static int mthca_enable_msi_x(struct mthca_dev *mdev)
 {
 	struct msix_entry entries[3];
 	int err;
@@ -1213,7 +1212,7 @@ int __mthca_restart_one(struct pci_dev *
 }
 
 static int __devinit mthca_init_one(struct pci_dev *pdev,
-			     const struct pci_device_id *id)
+				    const struct pci_device_id *id)
 {
 	static int mthca_version_printed = 0;
 	int ret;
diff --git a/drivers/infiniband/hw/mthca/mthca_mcg.c b/drivers/infiniband/hw/mthca/mthca_mcg.c
index 47ca8a9..a8ad072 100644
--- a/drivers/infiniband/hw/mthca/mthca_mcg.c
+++ b/drivers/infiniband/hw/mthca/mthca_mcg.c
@@ -32,7 +32,6 @@
  * $Id: mthca_mcg.c 1349 2004-12-16 21:09:43Z roland $
  */
 
-#include <linux/init.h>
 #include <linux/string.h>
 #include <linux/slab.h>
 
@@ -371,7 +370,7 @@ int mthca_multicast_detach(struct ib_qp
 	return err;
 }
 
-int __devinit mthca_init_mcg_table(struct mthca_dev *dev)
+int mthca_init_mcg_table(struct mthca_dev *dev)
 {
 	int err;
 	int table_size = dev->limits.num_mgms + dev->limits.num_amgms;
diff --git a/drivers/infiniband/hw/mthca/mthca_mr.c b/drivers/infiniband/hw/mthca/mthca_mr.c
index a486dec..f71ffa8 100644
--- a/drivers/infiniband/hw/mthca/mthca_mr.c
+++ b/drivers/infiniband/hw/mthca/mthca_mr.c
@@ -34,7 +34,6 @@
  */
 
 #include <linux/slab.h>
-#include <linux/init.h>
 #include <linux/errno.h>
 
 #include "mthca_dev.h"
@@ -135,7 +134,7 @@ static void mthca_buddy_free(struct mthc
 	spin_unlock(&buddy->lock);
 }
 
-static int __devinit mthca_buddy_init(struct mthca_buddy *buddy, int max_order)
+static int mthca_buddy_init(struct mthca_buddy *buddy, int max_order)
 {
 	int i, s;
 
@@ -759,7 +758,7 @@ void mthca_arbel_fmr_unmap(struct mthca_
 	*(u8 *) fmr->mem.arbel.mpt = MTHCA_MPT_STATUS_SW;
 }
 
-int __devinit mthca_init_mr_table(struct mthca_dev *dev)
+int mthca_init_mr_table(struct mthca_dev *dev)
 {
 	unsigned long addr;
 	int err, i;
diff --git a/drivers/infiniband/hw/mthca/mthca_pd.c b/drivers/infiniband/hw/mthca/mthca_pd.c
index 59df516..c1e9507 100644
--- a/drivers/infiniband/hw/mthca/mthca_pd.c
+++ b/drivers/infiniband/hw/mthca/mthca_pd.c
@@ -34,7 +34,6 @@
  * $Id: mthca_pd.c 1349 2004-12-16 21:09:43Z roland $
  */
 
-#include <linux/init.h>
 #include <linux/errno.h>
 
 #include "mthca_dev.h"
@@ -69,7 +68,7 @@ void mthca_pd_free(struct mthca_dev *dev
 	mthca_free(&dev->pd_table.alloc, pd->pd_num);
 }
 
-int __devinit mthca_init_pd_table(struct mthca_dev *dev)
+int mthca_init_pd_table(struct mthca_dev *dev)
 {
 	return mthca_alloc_init(&dev->pd_table.alloc,
 				dev->limits.num_pds,
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index fc67f78..21422a3 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -1100,11 +1100,10 @@ static struct ib_fmr *mthca_alloc_fmr(st
 	struct mthca_fmr *fmr;
 	int err;
 
-	fmr = kmalloc(sizeof *fmr, GFP_KERNEL);
+	fmr = kmemdup(fmr_attr, sizeof *fmr, GFP_KERNEL);
 	if (!fmr)
 		return ERR_PTR(-ENOMEM);
 
-	memcpy(&fmr->attr, fmr_attr, sizeof *fmr_attr);
 	err = mthca_fmr_alloc(to_mdev(pd->device), to_mpd(pd)->pd_num,
 			     convert_access(mr_access_flags), fmr);
 
diff --git a/drivers/infiniband/hw/mthca/mthca_qp.c b/drivers/infiniband/hw/mthca/mthca_qp.c
index 6a7822e..33e3ba7 100644
--- a/drivers/infiniband/hw/mthca/mthca_qp.c
+++ b/drivers/infiniband/hw/mthca/mthca_qp.c
@@ -35,7 +35,6 @@
  * $Id: mthca_qp.c 1355 2004-12-17 15:23:43Z roland $
  */
 
-#include <linux/init.h>
 #include <linux/string.h>
 #include <linux/slab.h>
 
@@ -2241,7 +2240,7 @@ void mthca_free_err_wqe(struct mthca_dev
 		*new_wqe = 0;
 }
 
-int __devinit mthca_init_qp_table(struct mthca_dev *dev)
+int mthca_init_qp_table(struct mthca_dev *dev)
 {
 	int err;
 	u8 status;
diff --git a/drivers/infiniband/hw/mthca/mthca_srq.c b/drivers/infiniband/hw/mthca/mthca_srq.c
index f5d7677..34d2c47 100644
--- a/drivers/infiniband/hw/mthca/mthca_srq.c
+++ b/drivers/infiniband/hw/mthca/mthca_srq.c
@@ -120,7 +120,7 @@ static void mthca_arbel_init_srq_context
 
 	memset(context, 0, sizeof *context);
 
-	logsize = long_log2(srq->max) + srq->wqe_shift;
+	logsize = long_log2(srq->max);
 	context->state_logsize_srqn = cpu_to_be32(logsize << 24 | srq->srqn);
 	context->lkey = cpu_to_be32(srq->mr.ibmr.lkey);
 	context->db_index = cpu_to_be32(srq->db_index);
@@ -715,7 +715,7 @@ int mthca_max_srq_sge(struct mthca_dev *
 		     sizeof (struct mthca_data_seg));
 }
 
-int __devinit mthca_init_srq_table(struct mthca_dev *dev)
+int mthca_init_srq_table(struct mthca_dev *dev)
 {
 	int err;
 
diff --git a/drivers/infiniband/ulp/ipoib/ipoib.h b/drivers/infiniband/ulp/ipoib/ipoib.h
index 0b8a79d..f2b6185 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib.h
+++ b/drivers/infiniband/ulp/ipoib/ipoib.h
@@ -233,7 +233,7 @@ static inline struct ipoib_neigh **to_ip
 }
 
 struct ipoib_neigh *ipoib_neigh_alloc(struct neighbour *neigh);
-void ipoib_neigh_free(struct ipoib_neigh *neigh);
+void ipoib_neigh_free(struct net_device *dev, struct ipoib_neigh *neigh);
 
 extern struct workqueue_struct *ipoib_workqueue;
 
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index 85522da..5ba3154 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -264,7 +264,7 @@ static void path_free(struct net_device
 		if (neigh->ah)
 			ipoib_put_ah(neigh->ah);
 
-		ipoib_neigh_free(neigh);
+		ipoib_neigh_free(dev, neigh);
 	}
 
 	spin_unlock_irqrestore(&priv->lock, flags);
@@ -525,10 +525,11 @@ static void neigh_add_path(struct sk_buf
 		ipoib_send(dev, skb, path->ah, IPOIB_QPN(skb->dst->neighbour->ha));
 	} else {
 		neigh->ah  = NULL;
-		__skb_queue_tail(&neigh->queue, skb);
 
 		if (!path->query && path_rec_start(dev, path))
 			goto err_list;
+
+		__skb_queue_tail(&neigh->queue, skb);
 	}
 
 	spin_unlock(&priv->lock);
@@ -538,7 +539,7 @@ err_list:
 	list_del(&neigh->list);
 
 err_path:
-	ipoib_neigh_free(neigh);
+	ipoib_neigh_free(dev, neigh);
 	++priv->stats.tx_dropped;
 	dev_kfree_skb_any(skb);
 
@@ -655,7 +656,7 @@ static int ipoib_start_xmit(struct sk_bu
 				 */
 				ipoib_put_ah(neigh->ah);
 				list_del(&neigh->list);
-				ipoib_neigh_free(neigh);
+				ipoib_neigh_free(dev, neigh);
 				spin_unlock(&priv->lock);
 				ipoib_path_lookup(skb, dev);
 				goto out;
@@ -786,7 +787,7 @@ static void ipoib_neigh_destructor(struc
 		if (neigh->ah)
 			ah = neigh->ah;
 		list_del(&neigh->list);
-		ipoib_neigh_free(neigh);
+		ipoib_neigh_free(n->dev, neigh);
 	}
 
 	spin_unlock_irqrestore(&priv->lock, flags);
@@ -809,9 +810,15 @@ struct ipoib_neigh *ipoib_neigh_alloc(st
 	return neigh;
 }
 
-void ipoib_neigh_free(struct ipoib_neigh *neigh)
+void ipoib_neigh_free(struct net_device *dev, struct ipoib_neigh *neigh)
 {
+	struct ipoib_dev_priv *priv = netdev_priv(dev);
+	struct sk_buff *skb;
 	*to_ipoib_neigh(neigh->neighbour) = NULL;
+	while ((skb = __skb_dequeue(&neigh->queue))) {
+		++priv->stats.tx_dropped;
+		dev_kfree_skb_any(skb);
+	}
 	kfree(neigh);
 }
 
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
index 3faa182..d282d65 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
@@ -114,7 +114,7 @@ static void ipoib_mcast_free(struct ipoi
 		 */
 		if (neigh->ah)
 			ipoib_put_ah(neigh->ah);
-		ipoib_neigh_free(neigh);
+		ipoib_neigh_free(dev, neigh);
 	}
 
 	spin_unlock_irqrestore(&priv->lock, flags);
diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.h b/drivers/infiniband/ulp/iser/iscsi_iser.h
index 9c53916..234e5b0 100644
--- a/drivers/infiniband/ulp/iser/iscsi_iser.h
+++ b/drivers/infiniband/ulp/iser/iscsi_iser.h
@@ -283,7 +283,7 @@ struct iser_global {
 	struct mutex      connlist_mutex;
 	struct list_head  connlist;		/* all iSER IB connections */
 
-	kmem_cache_t *desc_cache;
+	struct kmem_cache *desc_cache;
 };
 
 extern struct iser_global ig;
diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 4b09147..64ab5fc 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -1176,9 +1176,11 @@ static int srp_cm_handler(struct ib_cm_i
 			break;
 		}
 
-		target->status = srp_alloc_iu_bufs(target);
-		if (target->status)
-			break;
+		if (!target->rx_ring[0]) {
+			target->status = srp_alloc_iu_bufs(target);
+			if (target->status)
+				break;
+		}
 
 		qp_attr = kmalloc(sizeof *qp_attr, GFP_KERNEL);
 		if (!qp_attr) {
@@ -1716,7 +1718,8 @@ static ssize_t srp_create_target(struct
 	if (!target_host)
 		return -ENOMEM;
 
-	target_host->max_lun = SRP_MAX_LUN;
+	target_host->max_lun     = SRP_MAX_LUN;
+	target_host->max_cmd_len = sizeof ((struct srp_cmd *) (void *) 0L)->cdb;
 
 	target = host_to_target(target_host);
 
diff --git a/include/rdma/ib_cm.h b/include/rdma/ib_cm.h
index c9b4738..5c07017 100644
--- a/include/rdma/ib_cm.h
+++ b/include/rdma/ib_cm.h
@@ -60,6 +60,7 @@ enum ib_cm_state {
 };
 
 enum ib_cm_lap_state {
+	IB_CM_LAP_UNINIT,
 	IB_CM_LAP_IDLE,
 	IB_CM_LAP_SENT,
 	IB_CM_LAP_RCVD,
@@ -443,13 +444,20 @@ int ib_send_cm_drep(struct ib_cm_id *cm_
 		    u8 private_data_len);
 
 /**
- * ib_cm_establish - Forces a connection state to established.
+ * ib_cm_notify - Notifies the CM of an event reported to the consumer.
  * @cm_id: Connection identifier to transition to established.
+ * @event: Type of event.
  *
- * This routine should be invoked by users who receive messages on a
- * connected QP before an RTU has been received.
+ * This routine should be invoked by users to notify the CM of relevant
+ * communication events.  Events that should be reported to the CM and
+ * when to report them are:
+ *
+ * IB_EVENT_COMM_EST - Used when a message is received on a connected
+ *    QP before an RTU has been received.
+ * IB_EVENT_PATH_MIG - Notifies the CM that the connection has failed over
+ *   to the alternate path.
  */
-int ib_cm_establish(struct ib_cm_id *cm_id);
+int ib_cm_notify(struct ib_cm_id *cm_id, enum ib_event_type event);
 
 /**
  * ib_send_cm_rej - Sends a connection rejection message to the
diff --git a/include/rdma/ib_user_cm.h b/include/rdma/ib_user_cm.h
index 066c20b..37650af 100644
--- a/include/rdma/ib_user_cm.h
+++ b/include/rdma/ib_user_cm.h
@@ -38,7 +38,7 @@ #define IB_USER_CM_H
 
 #include <rdma/ib_user_sa.h>
 
-#define IB_USER_CM_ABI_VERSION 4
+#define IB_USER_CM_ABI_VERSION 5
 
 enum {
 	IB_USER_CM_CMD_CREATE_ID,
@@ -46,7 +46,7 @@ enum {
 	IB_USER_CM_CMD_ATTR_ID,
 
 	IB_USER_CM_CMD_LISTEN,
-	IB_USER_CM_CMD_ESTABLISH,
+	IB_USER_CM_CMD_NOTIFY,
 
 	IB_USER_CM_CMD_SEND_REQ,
 	IB_USER_CM_CMD_SEND_REP,
@@ -117,8 +117,9 @@ struct ib_ucm_listen {
 	__u32 reserved;
 };
 
-struct ib_ucm_establish {
+struct ib_ucm_notify {
 	__u32 id;
+	__u32 event;
 };
 
 struct ib_ucm_private_data {
