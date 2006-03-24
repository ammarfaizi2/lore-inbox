Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbWCXU2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbWCXU2O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 15:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWCXU2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 15:28:13 -0500
Received: from mail5.sea5.speakeasy.net ([69.17.117.7]:20612 "EHLO
	mail5.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1750770AbWCXU2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 15:28:13 -0500
Date: Fri, 24 Mar 2006 15:28:09 -0500 (EST)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@excalibur.intercode
To: Kirill Korotaev <dev@sw.ru>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       xemul@sw.ru, ebiederm@xmission.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, herbert@13thfloor.at, devel@openvz.org,
       serue@us.ibm.com, sam@vilain.net
Subject: Re: [RFC][PATCH 1/2] Virtualization of UTS
In-Reply-To: <44242CE7.3030905@sw.ru>
Message-ID: <Pine.LNX.4.64.0603241519410.27657@excalibur.intercode>
References: <44242B1B.1080909@sw.ru> <44242CE7.3030905@sw.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Mar 2006, Kirill Korotaev wrote:

> This patch introduces utsname namespace in system, which allows to have
> different utsnames on the host.
> Introduces config option CONFIG_UTS_NS and uts_namespace structure for this.
> 

Please include patches inline, so they can be quoted inline.

+#define system_utsname	(current->uts_ns->name)

This should be a static inline.

+struct uts_namespace *create_uts_ns(void)
+{
+	struct uts_namespace *ns;
+
+	ns = kmalloc(sizeof(struct uts_namespace), GFP_KERNEL);
+	if (ns == NULL)
+		return NULL;
+
+	memset(&ns->name, 0, sizeof(ns->name));
+	atomic_set(&ns->cnt, 1);
+	return ns;
+}

IMHO, it's better to do something like:

{
	foo = kmalloc();
	if (foo) {
		stuff;
		etc;
	}
	return foo;
}

I suggest you use kzalloc(), too.

Also, I think the API approach needs to be determined before the patches 
go into -mm, in case it impacts on the code.


