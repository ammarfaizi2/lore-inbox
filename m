Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbWC1NDR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbWC1NDR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 08:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbWC1NDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 08:03:17 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:44258 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751284AbWC1NDQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 08:03:16 -0500
Date: Tue, 28 Mar 2006 07:02:53 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>, linux-security-module@vger.kernel.org,
       Xiaolan Zhang <cxzhang@us.ibm.com>
Subject: [PATCH] fix up security_socket_getpeersec_* documentation
Message-ID: <20060328130253.GA19243@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update the security_socket_peersec documentation in
include/linux/security.h.  security_socket_peersec has been split
into two functions - _stream and _dgram, with new capabilities.

Signed-off-by: Serge Hallyn <serue@us.ibm.com>

--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -782,9 +782,11 @@ struct swap_info_struct;
  *	incoming sk_buff @skb has been associated with a particular socket, @sk.
  *	@sk contains the sock (not socket) associated with the incoming sk_buff.
  *	@skb contains the incoming network data.
- * @socket_getpeersec:
+ * @socket_getpeersec_stream:
  *	This hook allows the security module to provide peer socket security
- *	state to userspace via getsockopt SO_GETPEERSEC.
+ *	state for unix or connected tcp sockets to userspace via getsockopt
+ *	SO_GETPEERSEC.  For tcp sockets this can be meaningful if the
+ *	socket is associated with an ipsec SA.
  *	@sock is the local socket.
  *	@optval userspace memory where the security state is to be copied.
  *	@optlen userspace int where the module should copy the actual length
@@ -793,6 +795,17 @@ struct swap_info_struct;
  *	by the caller.
  *	Return 0 if all is well, otherwise, typical getsockopt return
  *	values.
+ * @socket_getpeersec_dgram:
+ * 	This hook allows the security module to provide peer socket security
+ * 	state for udp sockets on a per-packet basis to userspace via
+ * 	getsockopt SO_GETPEERSEC.  The application must first have indicated
+ * 	the IP_PASSSEC option via getsockopt.  It can then retrieve the
+ * 	security state returned by this hook for a packet via the SCM_SECURITY
+ * 	ancillary message type.
+ * 	@skb is the skbuff for the packet being queried
+ * 	@secdata is a pointer to a buffer in which to copy the security data
+ * 	@seclen is the maximum length for @secdata
+ * 	Return 0 on success, error on failure.
  * @sk_alloc_security:
  *      Allocate and attach a security structure to the sk->sk_security field,
  *      which is used to copy security attributes between local stream sockets.
