Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264399AbTDXEVv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 00:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264400AbTDXEVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 00:21:51 -0400
Received: from dp.samba.org ([66.70.73.150]:54251 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264399AbTDXEVs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 00:21:48 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] Oopses in apply_alternatives 
In-reply-to: Your message of "Wed, 23 Apr 2003 23:30:38 +0200."
             <20030423213038.GA6389@vana.vc.cvut.cz> 
Date: Thu, 24 Apr 2003 13:12:10 +1000
Message-Id: <20030424043357.5B9312C08B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030423213038.GA6389@vana.vc.cvut.cz> you write:
> Hi Rusty,
>   I somehow missed apply_alternatives inclusion into the kernel, so
> I have no idea whether you are right person...
> 
>   It is not good idea to call apply_alternatives from module_finalize,
> as apply_alternatives is __init function... It spectaculary crashed

Smells of Torvaldism.  I missed it too: you're right,
apply_alternatives should be marked

	__init_or_module

instead.

Thanks!
Rusty.

> @@ -802,7 +802,7 @@
>     APs have less capabilities than the boot processor are not handled. 
>      
>     In this case boot with "noreplacement". */ 
> -void __init apply_alternatives(void *start, void *end) 
> +void apply_alternatives(void *start, void *end) 
>  { 
>  	struct alt_instr *a; 
>  	int diff, i, k;

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
