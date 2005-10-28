Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030199AbVJ1Oty@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030199AbVJ1Oty (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 10:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030200AbVJ1Oty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 10:49:54 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:29656 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030199AbVJ1Otx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 10:49:53 -0400
Subject: Re: [ketchup] patch to allow for moving of .gitignore in 2.6.14
From: Steven Rostedt <rostedt@goodmis.org>
To: Matt Mackall <mpm@selenic.com>
Cc: Esben Nielsen <simlo@phys.au.dk>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1130504043.9574.56.camel@localhost.localdomain>
References: <Pine.LNX.4.58.0510170316310.5859@localhost.localdomain>
	 <20051017213915.GN26160@waste.org>
	 <Pine.LNX.4.58.0510180211320.13581@localhost.localdomain>
	 <20051018063031.GR26160@waste.org>
	 <Pine.LNX.4.58.0510180239550.13581@localhost.localdomain>
	 <20051018072927.GU26160@waste.org>
	 <1130504043.9574.56.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 28 Oct 2005 10:49:30 -0400
Message-Id: <1130510970.9574.82.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-10-28 at 08:54 -0400, Steven Rostedt wrote:
> Hi Matt,
> 
> Here's a small patch to ketchup to make it move the .gitignore that is
> now included in 2.6.14.
> 
> -- Steve
> 
> Index: Ketchup-d9503020b3c1/ketchup
> ===================================================================
> --- Ketchup-d9503020b3c1.orig/ketchup	2005-10-28 08:38:50.000000000 -0400
> +++ Ketchup-d9503020b3c1/ketchup	2005-10-28 08:48:37.000000000 -0400
> @@ -482,7 +482,7 @@
>          error("Unpacking failed: ", err)
>          sys.exit(-1)
>  
> -    err = os.system("mv linux*/* . ; rmdir linux*")
> +    err = os.system("mv linux*/* linux*/.git* . ; rmdir linux*")
>      if err:
>          error("Unpacking failed: ", err)
>          sys.exit(-1)
> 

Unfortunately, the above shows an error message (but does not fail) for
2.6.13.  Here's a better updated fix/hack to allow for either
having .gitignore, or not.

-- Steve

Index: Ketchup-d9503020b3c1/ketchup
===================================================================
--- Ketchup-d9503020b3c1.orig/ketchup	2005-10-28 08:38:50.000000000 -0400
+++ Ketchup-d9503020b3c1/ketchup	2005-10-28 10:45:43.000000000 -0400
@@ -482,7 +482,7 @@
         error("Unpacking failed: ", err)
         sys.exit(-1)
 
-    err = os.system("mv linux*/* . ; rmdir linux*")
+    err = os.system("shopt -s dotglob; mv linux*/* . ; rmdir linux*")
     if err:
         error("Unpacking failed: ", err)
         sys.exit(-1)


