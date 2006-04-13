Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbWDMQ1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbWDMQ1N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 12:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932114AbWDMQ1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 12:27:13 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:1041 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932074AbWDMQ1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 12:27:12 -0400
Date: Thu, 13 Apr 2006 18:27:10 +0200
From: Adrian Bunk <bunk@stusta.de>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] net/netlink/: possible cleanups
Message-ID: <20060413162710.GE4162@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups plus changes related 
to them:
- make the following needlessly global functions static:
  - attr.c: __nla_reserve()
  - attr.c: __nla_put()
- #if 0 the following unused global functions:
  - attr.c: nla_validate()
  - attr.c: nla_find()
  - attr.c: nla_memcpy()
  - attr.c: nla_memcmp()
  - attr.c: nla_strcmp()
  - attr.c: nla_reserve()
  - genetlink.c: genl_unregister_ops()
- remove the following unused EXPORT_SYMBOL's:
  - af_netlink.c: netlink_set_nonroot
  - attr.c: nla_parse
  - attr.c: nla_strlcpy
  - attr.c: nla_put

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/net/genetlink.h  |    1 -
 include/net/netlink.h    |   23 ++++++++---------------
 net/netlink/af_netlink.c |    1 -
 net/netlink/attr.c       |   29 ++++++++++++++---------------
 net/netlink/genetlink.c  |    3 ++-
 5 files changed, 24 insertions(+), 33 deletions(-)

--- linux-2.6.17-rc1-mm2-full/net/netlink/af_netlink.c.old	2006-04-13 17:40:48.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/net/netlink/af_netlink.c	2006-04-13 17:40:56.000000000 +0200
@@ -1805,7 +1805,6 @@
 EXPORT_SYMBOL(netlink_kernel_create);
 EXPORT_SYMBOL(netlink_register_notifier);
 EXPORT_SYMBOL(netlink_set_err);
-EXPORT_SYMBOL(netlink_set_nonroot);
 EXPORT_SYMBOL(netlink_unicast);
 EXPORT_SYMBOL(netlink_unregister_notifier);
 
--- linux-2.6.17-rc1-mm2-full/include/net/netlink.h.old	2006-04-13 17:42:48.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/include/net/netlink.h	2006-04-13 17:53:51.000000000 +0200
@@ -189,24 +189,11 @@
 extern void		netlink_queue_skip(struct nlmsghdr *nlh,
 					   struct sk_buff *skb);
 
-extern int		nla_validate(struct nlattr *head, int len, int maxtype,
-				     struct nla_policy *policy);
 extern int		nla_parse(struct nlattr *tb[], int maxtype,
 				  struct nlattr *head, int len,
 				  struct nla_policy *policy);
-extern struct nlattr *	nla_find(struct nlattr *head, int len, int attrtype);
 extern size_t		nla_strlcpy(char *dst, const struct nlattr *nla,
 				    size_t dstsize);
-extern int		nla_memcpy(void *dest, struct nlattr *src, int count);
-extern int		nla_memcmp(const struct nlattr *nla, const void *data,
-				   size_t size);
-extern int		nla_strcmp(const struct nlattr *nla, const char *str);
-extern struct nlattr *	__nla_reserve(struct sk_buff *skb, int attrtype,
-				      int attrlen);
-extern struct nlattr *	nla_reserve(struct sk_buff *skb, int attrtype,
-				    int attrlen);
-extern void		__nla_put(struct sk_buff *skb, int attrtype,
-				  int attrlen, const void *data);
 extern int		nla_put(struct sk_buff *skb, int attrtype,
 				int attrlen, const void *data);
 
@@ -331,6 +318,8 @@
 			 nlmsg_attrlen(nlh, hdrlen), policy);
 }
 
+#if 0
+
 /**
  * nlmsg_find_attr - find a specific attribute in a netlink message
  * @nlh: netlink message header
@@ -374,7 +363,6 @@
 	nla_for_each_attr(pos, nlmsg_attrdata(nlh, hdrlen), \
 			  nlmsg_attrlen(nlh, hdrlen), rem)
 
-#if 0
 /* FIXME: Enable once all users have been converted */
 
 /**
@@ -407,7 +395,8 @@
 
 	return nlh;
 }
-#endif
+
+#endif  /*  0  */
 
 /**
  * nlmsg_put - Add a new netlink message to an skb
@@ -784,6 +773,7 @@
 	return *(u8 *) nla_data(nla);
 }
 
+#if 0
 /**
  * nla_get_u64 - return payload of u64 attribute
  * @nla: u64 netlink attribute
@@ -796,6 +786,7 @@
 
 	return tmp;
 }
+#endif  /*  0  */
 
 /**
  * nla_get_flag - return payload of flag attribute
@@ -806,6 +797,7 @@
 	return !!nla;
 }
 
+#if 0
 /**
  * nla_get_msecs - return payload of msecs attribute
  * @nla: msecs netlink attribute
@@ -818,6 +810,7 @@
 
 	return msecs_to_jiffies((unsigned long) msecs);
 }
+#endif  /*  0  */
 
 /**
  * nla_nest_start - Start a new level of nested attributes
--- linux-2.6.17-rc1-mm2-full/net/netlink/attr.c.old	2006-04-13 17:44:12.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/net/netlink/attr.c	2006-04-13 17:55:22.000000000 +0200
@@ -52,6 +52,7 @@
 	return 0;
 }
 
+#if 0
 /**
  * nla_validate - Validate a stream of attributes
  * @head: head of attribute stream
@@ -81,6 +82,7 @@
 errout:
 	return err;
 }
+#endif  /*  0  */
 
 /**
  * nla_parse - Parse a stream of attributes into a tb buffer
@@ -127,6 +129,7 @@
 	return err;
 }
 
+#if 0
 /**
  * nla_find - Find a specific attribute in a stream of attributes
  * @head: head of attribute stream
@@ -146,6 +149,7 @@
 
 	return NULL;
 }
+#endif  /*  0  */
 
 /**
  * nla_strlcpy - Copy string attribute payload into a sized buffer
@@ -177,6 +181,8 @@
 	return srclen;
 }
 
+#if 0
+
 /**
  * nla_memcpy - Copy a netlink attribute into another memory area
  * @dest: where to copy to memcpy
@@ -230,6 +236,8 @@
 	return d;
 }
 
+#endif  /*  0  */
+
 /**
  * __nla_reserve - reserve room for attribute on the skb
  * @skb: socket buffer to reserve room on
@@ -242,7 +250,8 @@
  * The caller is responsible to ensure that the skb provides enough
  * tailroom for the attribute header and payload.
  */
-struct nlattr *__nla_reserve(struct sk_buff *skb, int attrtype, int attrlen)
+static struct nlattr *__nla_reserve(struct sk_buff *skb, int attrtype,
+				    int attrlen)
 {
 	struct nlattr *nla;
 
@@ -255,6 +264,7 @@
 	return nla;
 }
 
+#if 0
 /**
  * nla_reserve - reserve room for attribute on the skb
  * @skb: socket buffer to reserve room on
@@ -274,6 +284,7 @@
 
 	return __nla_reserve(skb, attrtype, attrlen);
 }
+#endif  /*  0  */
 
 /**
  * __nla_put - Add a netlink attribute to a socket buffer
@@ -285,8 +296,8 @@
  * The caller is responsible to ensure that the skb provides enough
  * tailroom for the attribute header and payload.
  */
-void __nla_put(struct sk_buff *skb, int attrtype, int attrlen,
-			     const void *data)
+static void __nla_put(struct sk_buff *skb, int attrtype, int attrlen,
+		      const void *data)
 {
 	struct nlattr *nla;
 
@@ -314,15 +325,3 @@
 	return 0;
 }
 
-
-EXPORT_SYMBOL(nla_validate);
-EXPORT_SYMBOL(nla_parse);
-EXPORT_SYMBOL(nla_find);
-EXPORT_SYMBOL(nla_strlcpy);
-EXPORT_SYMBOL(__nla_reserve);
-EXPORT_SYMBOL(nla_reserve);
-EXPORT_SYMBOL(__nla_put);
-EXPORT_SYMBOL(nla_put);
-EXPORT_SYMBOL(nla_memcpy);
-EXPORT_SYMBOL(nla_memcmp);
-EXPORT_SYMBOL(nla_strcmp);
--- linux-2.6.17-rc1-mm2-full/include/net/genetlink.h.old	2006-04-13 17:39:36.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/include/net/genetlink.h	2006-04-13 17:39:50.000000000 +0200
@@ -72,7 +72,6 @@
 extern int genl_register_family(struct genl_family *family);
 extern int genl_unregister_family(struct genl_family *family);
 extern int genl_register_ops(struct genl_family *, struct genl_ops *ops);
-extern int genl_unregister_ops(struct genl_family *, struct genl_ops *ops);
 
 extern struct sock *genl_sock;
 
--- linux-2.6.17-rc1-mm2-full/net/netlink/genetlink.c.old	2006-04-13 17:39:58.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/net/netlink/genetlink.c	2006-04-13 17:40:13.000000000 +0200
@@ -154,6 +154,7 @@
 	return err;
 }
 
+#if 0
 /**
  * genl_unregister_ops - unregister generic netlink operations
  * @family: generic netlink family
@@ -187,6 +188,7 @@
 
 	return -ENOENT;
 }
+#endif  /*  0  */
 
 /**
  * genl_register_family - register a generic netlink family
@@ -565,6 +567,5 @@
 
 EXPORT_SYMBOL(genl_sock);
 EXPORT_SYMBOL(genl_register_ops);
-EXPORT_SYMBOL(genl_unregister_ops);
 EXPORT_SYMBOL(genl_register_family);
 EXPORT_SYMBOL(genl_unregister_family);

