Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966439AbWKTS4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966439AbWKTS4x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 13:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966440AbWKTS4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 13:56:53 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:62867 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S966437AbWKTS4w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 13:56:52 -0500
Message-ID: <4561FA6F.4030400@gmail.com>
Date: Mon, 20 Nov 2006 19:56:47 +0100
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Akinobu Mita <akinobu.mita@gmail.com>, Jiri Slaby <jirislaby@gmail.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Greg KH <gregkh@suse.de>
Subject: Re: kobject_add failed with -EEXIST
References: <4561E290.7060100@gmail.com> <20061120182312.GA16006@APFDCB5C>
In-Reply-To: <20061120182312.GA16006@APFDCB5C>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Muni-Spam-TestIP: 147.251.48.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Akinobu Mita wrote:
> ---
>  drivers/base/class.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> Index: work-fault-inject/drivers/base/class.c
> ===================================================================
> --- work-fault-inject.orig/drivers/base/class.c
> +++ work-fault-inject/drivers/base/class.c
> @@ -163,6 +163,8 @@ int class_register(struct class * cls)
>  void class_unregister(struct class * cls)
>  {
>  	pr_debug("device class '%s': unregistering\n", cls->name);
> +	if (cls->virtual_dir)
> +		kobject_unregister(cls->virtual_dir);
>  	remove_class_attrs(cls);
>  	subsystem_unregister(&cls->subsys);
>  }
> 

This solves my problem.

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
