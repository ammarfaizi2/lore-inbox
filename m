Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbVHHLpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbVHHLpH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 07:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbVHHLpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 07:45:07 -0400
Received: from NS8.Sony.CO.JP ([137.153.0.33]:36595 "EHLO ns8.sony.co.jp")
	by vger.kernel.org with ESMTP id S1750802AbVHHLpH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 07:45:07 -0400
Date: Mon, 08 Aug 2005 20:40:22 +0900 (JST)
Message-Id: <20050808.204022.30161255.kaminaga@sm.sony.co.jp>
To: linux-kernel@vger.kernel.org
Subject: [HELP] How to get address of module
From: Hiroki Kaminaga <kaminaga@sm.sony.co.jp>
X-Mailer: Mew version 4.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

I'm looking for *nice* way to get address of loaded module in 2.6.
I'd like to know the address from driver.

In 2.4, I wrote something like this:

 * * *

(in kernel src)
--- kernel/module.c
+++ kernel/module.c

struct module *module_list = &kernel_module;

+ struct module *get_module_queue(void)
+ {
+         return module_list;
+ }
+ 
+ 

... and in driver, I wrote:
            
        mod = get_module_queue();
        while (mod->next) {
                if (strcmp(mod->name, name) == 0)
                        return (unsigned long)(mod + 1);
                mod = mod->next;
        }
        return 0;

 * * *

I am now using 2.6 kernel. The choice I can think of is

1) make linux-2.6/kernel/module.c:find_module(const char *name)
   global func, not static, and use this func.

2) use linux-2.6/kernel/module.c:module_kallsyms_lookup_name(const char *name)
   and somehow get return value from module_get_kallsym(...)

choice 1) doesn't sound nice since it changes static func -> global
func, but cost of getting module address is low. On the other hand,
choice 2) will not modify kernel src, which sounds nice, but costs more,
and I'm not sure this method works.

Any advice?!


HK.
--
