Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932447AbWDMS5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447AbWDMS5e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 14:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbWDMS5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 14:57:34 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:18873 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932447AbWDMS5d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 14:57:33 -0400
Date: Thu, 13 Apr 2006 20:57:17 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
cc: tyler@agat.net, rusty@rustcorp.com.au, gregkh@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kmod optimization
In-Reply-To: <20060413111936.3d035771.rdunlap@xenotime.net>
Message-ID: <Pine.LNX.4.61.0604132055260.20938@yvahk01.tjqt.qr>
References: <20060413180345.GA10910@Starbuck> <20060413111936.3d035771.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


+/* Test if a module is loaded : must hold module_mutex */
+int is_loaded(const char *module_name);
+{
+       struct module *mod = find_module(module_name);
+
+       if (!mod) {
+               return 1;
+       }
+
+       return 0;
+}
+
+


>Don't use braces when not needed.
>Why not make this function inline and put it into a header file?

static inline int is_loaded(const char *module_name) {
    return find_module(module_name) != NULL;
}

Cheers. In that case, I think it can even be "hand-inlined" into the callers.


Jan Engelhardt
-- 
