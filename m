Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161173AbWJOV3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161173AbWJOV3N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 17:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161174AbWJOV3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 17:29:13 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:30083 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1161173AbWJOV3M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 17:29:12 -0400
Date: Sun, 15 Oct 2006 22:29:05 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] l2cap endianness annotations
Message-ID: <20061015212905.GR29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/net/bluetooth/l2cap.h |   50 +++++++++++++++++++++--------------------
 net/bluetooth/l2cap.c         |   40 +++++++++++++++++----------------
 2 files changed, 46 insertions(+), 44 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 8242a0e..104e23b 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -34,7 +34,7 @@ #define L2CAP_CONN_TIMEOUT	(HZ * 40)
 /* L2CAP socket address */
 struct sockaddr_l2 {
 	sa_family_t	l2_family;
-	unsigned short	l2_psm;
+	__le16		l2_psm;
 	bdaddr_t	l2_bdaddr;
 };
 
@@ -76,32 +76,32 @@ #define L2CAP_INFO_RSP    0x0b
 
 /* L2CAP structures */
 struct l2cap_hdr {
-	__u16      len;
-	__u16      cid;
+	__le16      len;
+	__le16      cid;
 } __attribute__ ((packed));
 #define L2CAP_HDR_SIZE		4
 
 struct l2cap_cmd_hdr {
 	__u8       code;
 	__u8       ident;
-	__u16      len;
+	__le16     len;
 } __attribute__ ((packed));
 #define L2CAP_CMD_HDR_SIZE	4
 
 struct l2cap_cmd_rej {
-	__u16      reason;
+	__le16      reason;
 } __attribute__ ((packed));
 
 struct l2cap_conn_req {
-	__u16      psm;
-	__u16      scid;
+	__le16      psm;
+	__le16      scid;
 } __attribute__ ((packed));
 
 struct l2cap_conn_rsp {
-	__u16      dcid;
-	__u16      scid;
-	__u16      result;
-	__u16      status;
+	__le16      dcid;
+	__le16      scid;
+	__le16      result;
+	__le16      status;
 } __attribute__ ((packed));
 
 /* connect result */
@@ -117,15 +117,15 @@ #define L2CAP_CS_AUTHEN_PEND  0x0001
 #define L2CAP_CS_AUTHOR_PEND  0x0002
 
 struct l2cap_conf_req {
-	__u16      dcid;
-	__u16      flags;
+	__le16      dcid;
+	__le16      flags;
 	__u8       data[0];
 } __attribute__ ((packed));
 
 struct l2cap_conf_rsp {
-	__u16      scid;
-	__u16      flags;
-	__u16      result;
+	__le16      scid;
+	__le16      flags;
+	__le16      result;
 	__u8       data[0];
 } __attribute__ ((packed));
 
@@ -147,23 +147,23 @@ #define L2CAP_CONF_RFC		0x04
 #define L2CAP_CONF_MAX_SIZE	22
 
 struct l2cap_disconn_req {
-	__u16      dcid;
-	__u16      scid;
+	__le16      dcid;
+	__le16      scid;
 } __attribute__ ((packed));
 
 struct l2cap_disconn_rsp {
-	__u16      dcid;
-	__u16      scid;
+	__le16      dcid;
+	__le16      scid;
 } __attribute__ ((packed));
 
 struct l2cap_info_req {
-	__u16       type;
+	__le16       type;
 	__u8        data[0];
 } __attribute__ ((packed));
 
 struct l2cap_info_rsp {
-	__u16       type;
-	__u16       result;
+	__le16       type;
+	__le16       result;
 	__u8        data[0];
 } __attribute__ ((packed));
 
@@ -205,7 +205,7 @@ #define l2cap_pi(sk) ((struct l2cap_pinf
 
 struct l2cap_pinfo {
 	struct bt_sock	bt;
-	__u16		psm;
+	__le16		psm;
 	__u16		dcid;
 	__u16		scid;
 
@@ -221,7 +221,7 @@ struct l2cap_pinfo {
 
 	__u8		ident;
 
-	__u16		sport;
+	__le16		sport;
 
 	struct l2cap_conn	*conn;
 	struct sock		*next_c;
diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index d56f60b..0995420 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -353,7 +353,7 @@ static inline int l2cap_send_cmd(struct 
 }
 
 /* ---- Socket interface ---- */
-static struct sock *__l2cap_get_sock_by_addr(u16 psm, bdaddr_t *src)
+static struct sock *__l2cap_get_sock_by_addr(__le16 psm, bdaddr_t *src)
 {
 	struct sock *sk;
 	struct hlist_node *node;
@@ -368,7 +368,7 @@ found:
 /* Find socket with psm and source bdaddr.
  * Returns closest match.
  */
-static struct sock *__l2cap_get_sock_by_psm(int state, u16 psm, bdaddr_t *src)
+static struct sock *__l2cap_get_sock_by_psm(int state, __le16 psm, bdaddr_t *src)
 {
 	struct sock *sk = NULL, *sk1 = NULL;
 	struct hlist_node *node;
@@ -392,7 +392,7 @@ static struct sock *__l2cap_get_sock_by_
 
 /* Find socket with given address (psm, src).
  * Returns locked socket */
-static inline struct sock *l2cap_get_sock_by_psm(int state, u16 psm, bdaddr_t *src)
+static inline struct sock *l2cap_get_sock_by_psm(int state, __le16 psm, bdaddr_t *src)
 {
 	struct sock *s;
 	read_lock(&l2cap_sk_list.lock);
@@ -866,7 +866,7 @@ static inline int l2cap_do_send(struct s
 	lh->len = __cpu_to_le16(len + (hlen - L2CAP_HDR_SIZE));
 
 	if (sk->sk_type == SOCK_DGRAM)
-		put_unaligned(l2cap_pi(sk)->psm, (u16 *) skb_put(skb, 2));
+		put_unaligned(l2cap_pi(sk)->psm, (__le16 *) skb_put(skb, 2));
 
 	if (memcpy_fromiovec(skb_put(skb, count), msg->msg_iov, count)) {
 		err = -EFAULT;
@@ -1243,11 +1243,11 @@ static inline int l2cap_get_conf_opt(voi
 		break;
 
 	case 2:
-		*val = __le16_to_cpu(*((u16 *)opt->val));
+		*val = __le16_to_cpu(*((__le16 *)opt->val));
 		break;
 
 	case 4:
-		*val = __le32_to_cpu(*((u32 *)opt->val));
+		*val = __le32_to_cpu(*((__le32 *)opt->val));
 		break;
 
 	default:
@@ -1310,11 +1310,11 @@ static void l2cap_add_conf_opt(void **pt
 		break;
 
 	case 2:
-		*((u16 *) opt->val) = __cpu_to_le16(val);
+		*((__le16 *) opt->val) = __cpu_to_le16(val);
 		break;
 
 	case 4:
-		*((u32 *) opt->val) = __cpu_to_le32(val);
+		*((__le32 *) opt->val) = __cpu_to_le32(val);
 		break;
 
 	default:
@@ -1393,7 +1393,7 @@ static inline int l2cap_connect_req(stru
 	int result = 0, status = 0;
 
 	u16 dcid = 0, scid = __le16_to_cpu(req->scid);
-	u16 psm  = req->psm;
+	__le16 psm  = req->psm;
 
 	BT_DBG("psm 0x%2.2x scid 0x%4.4x", psm, scid);
 
@@ -1533,7 +1533,7 @@ static inline int l2cap_config_req(struc
 	if (!(sk = l2cap_get_chan_by_scid(&conn->chan_list, dcid)))
 		return -ENOENT;
 
-	l2cap_parse_conf_req(sk, req->data, cmd->len - sizeof(*req));
+	l2cap_parse_conf_req(sk, req->data, __le16_to_cpu(cmd->len) - sizeof(*req));
 
 	if (flags & 0x0001) {
 		/* Incomplete config. Send empty response. */
@@ -1717,15 +1717,16 @@ static inline void l2cap_sig_channel(str
 	l2cap_raw_recv(conn, skb);
 
 	while (len >= L2CAP_CMD_HDR_SIZE) {
+		int this_len;
 		memcpy(&cmd, data, L2CAP_CMD_HDR_SIZE);
 		data += L2CAP_CMD_HDR_SIZE;
 		len  -= L2CAP_CMD_HDR_SIZE;
 
-		cmd.len = __le16_to_cpu(cmd.len);
+		this_len = __le16_to_cpu(cmd.len);
 
-		BT_DBG("code 0x%2.2x len %d id 0x%2.2x", cmd.code, cmd.len, cmd.ident);
+		BT_DBG("code 0x%2.2x len %d id 0x%2.2x", cmd.code, this_len, cmd.ident);
 
-		if (cmd.len > len || !cmd.ident) {
+		if (this_len > len || !cmd.ident) {
 			BT_DBG("corrupted command");
 			break;
 		}
@@ -1760,7 +1761,7 @@ static inline void l2cap_sig_channel(str
 			break;
 
 		case L2CAP_ECHO_REQ:
-			l2cap_send_cmd(conn, cmd.ident, L2CAP_ECHO_RSP, cmd.len, data);
+			l2cap_send_cmd(conn, cmd.ident, L2CAP_ECHO_RSP, this_len, data);
 			break;
 
 		case L2CAP_ECHO_RSP:
@@ -1789,8 +1790,8 @@ static inline void l2cap_sig_channel(str
 			l2cap_send_cmd(conn, cmd.ident, L2CAP_COMMAND_REJ, sizeof(rej), &rej);
 		}
 
-		data += cmd.len;
-		len  -= cmd.len;
+		data += this_len;
+		len  -= this_len;
 	}
 
 	kfree_skb(skb);
@@ -1832,7 +1833,7 @@ done:
 	return 0;
 }
 
-static inline int l2cap_conless_channel(struct l2cap_conn *conn, u16 psm, struct sk_buff *skb)
+static inline int l2cap_conless_channel(struct l2cap_conn *conn, __le16 psm, struct sk_buff *skb)
 {
 	struct sock *sk;
 
@@ -1862,7 +1863,8 @@ done:
 static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	struct l2cap_hdr *lh = (void *) skb->data;
-	u16 cid, psm, len;
+	u16 cid, len;
+	__le16 psm;
 
 	skb_pull(skb, L2CAP_HDR_SIZE);
 	cid = __le16_to_cpu(lh->cid);
@@ -1876,7 +1878,7 @@ static void l2cap_recv_frame(struct l2ca
 		break;
 
 	case 0x0002:
-		psm = get_unaligned((u16 *) skb->data);
+		psm = get_unaligned((__le16 *) skb->data);
 		skb_pull(skb, 2);
 		l2cap_conless_channel(conn, psm, skb);
 		break;
-- 
1.4.2.GIT

