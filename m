Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966364AbWKTS3S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966364AbWKTS3S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 13:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966373AbWKTS3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 13:29:17 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:40909 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S966364AbWKTS3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 13:29:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=qbDb+/KypdcnZ5X7PFNQZRnDx/yVTN84OaQfJceEmie7QoJ152o/NOGvdqrV2M0XVtIsJdD4c328kCtjzpxCBCsqHZaAPz0JdVCNqJzX2tTTNhQeeeQ3/uKbrpdOZ8HUAY9LA9ZhT8tw5/qAafRjFlBb6yQ6DVo5L/B9wciuj5Y=
Date: Tue, 21 Nov 2006 03:23:12 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Greg KH <gregkh@suse.de>
Subject: Re: kobject_add failed with -EEXIST
Message-ID: <20061120182312.GA16006@APFDCB5C>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	Jiri Slaby <jirislaby@gmail.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Greg KH <gregkh@suse.de>
References: <4561E290.7060100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4561E290.7060100@gmail.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2006 at 06:14:56PM +0100, Jiri Slaby wrote:
> Hi!
> 
> Does anybody have some clue, what's wrong with the attached module?
> Kernel complains when the module is insmoded second time (DRIVER_DEBUG enabled):

Could you try this patch? I also had similar problem.


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
