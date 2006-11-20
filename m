Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966612AbWKTT7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966612AbWKTT7Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 14:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966610AbWKTT7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 14:59:16 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:28287 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S966612AbWKTT7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 14:59:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=oSXKZW51+Akmvl1TQALts/i1oh+C1Z4buEJCkFEZWiKbGUW4BHI8bGI2tEomFJfyJT+Fk/4HA0CsAsZxS7OZWDXSP2YLBpaCot82wJKUY6QMyyIVD0DtUkI03L1mh2dpOXHgbiB9XUtIkuM3hQyoczUC8XN8I0qQyXdmGHk68b8=
Date: Tue, 21 Nov 2006 04:53:18 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Greg KH <gregkh@suse.de>
Subject: [PATCH] driver core: delete virtual directory on class_unregister()
Message-ID: <20061120195318.GB18077@APFDCB5C>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	Jiri Slaby <jirislaby@gmail.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Greg KH <gregkh@suse.de>
References: <4561E290.7060100@gmail.com> <20061120182312.GA16006@APFDCB5C> <4561FA6F.4030400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4561FA6F.4030400@gmail.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Class virtual directory is created as the need arises.
But it is not deleted when the class is unregistered.

Cc: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

---
 drivers/base/class.c |    2 ++
 1 file changed, 2 insertions(+)

Index: work-fault-inject/drivers/base/class.c
===================================================================
--- work-fault-inject.orig/drivers/base/class.c
+++ work-fault-inject/drivers/base/class.c
@@ -163,6 +163,8 @@ int class_register(struct class * cls)
 void class_unregister(struct class * cls)
 {
 	pr_debug("device class '%s': unregistering\n", cls->name);
+	if (cls->virtual_dir)
+		kobject_unregister(cls->virtual_dir);
 	remove_class_attrs(cls);
 	subsystem_unregister(&cls->subsys);
 }
