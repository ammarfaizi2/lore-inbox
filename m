Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbTILSc6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 14:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbTILSbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 14:31:40 -0400
Received: from ivoti.terra.com.br ([200.176.3.20]:51866 "EHLO
	ivoti.terra.com.br") by vger.kernel.org with ESMTP id S261807AbTILSbV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 14:31:21 -0400
Message-ID: <3F621160.5020502@terra.com.br>
Date: Fri, 12 Sep 2003 15:33:04 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: Felipe W Damasio <felipewd@terra.com.br>
Cc: rusty@rustcorp.com.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernel/futex.c: Uneeded memory barrier
References: <3F620E61.4080604@terra.com.br>
In-Reply-To: <3F620E61.4080604@terra.com.br>
Content-Type: multipart/mixed;
 boundary="------------020207060203010307060009"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020207060203010307060009
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	It is easier to review the patch if you can actually read the patch ;)

Felipe

Felipe W Damasio wrote:
>     Hi Rusty,
> 
>     Patch against 2.6-test5.
> 
>     Kills an unneeded set_current_state after schedule_timeout, since it 
> already guarantees that the task will be TASK_RUNNING.
> 
>     Also, when setting the state to TASK_RUNNING, isn't that memory 
> barrier unneeded? Patch removes this memory barrier too.
> 
>     If it looks good, please consider applying.
> 
>     Thanks.
> 
> Felipe
> 

--------------020207060203010307060009
Content-Type: text/plain;
 name="futex-state.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="futex-state.patch"

--- linux-2.6.0-test5/kernel/futex.c.orig	2003-09-12 15:14:42.000000000 -0300
+++ linux-2.6.0-test5/kernel/futex.c	2003-09-12 15:14:56.000000000 -0300
@@ -381,13 +381,12 @@
 		 * We were woken already.
 		 */
 		spin_unlock(&futex_lock);
-		set_current_state(TASK_RUNNING);
+		__set_current_state(TASK_RUNNING);
 		return 0;
 	}
 
 	spin_unlock(&futex_lock);
 	time = schedule_timeout(time);
-	set_current_state(TASK_RUNNING);
 
 	/*
 	 * NOTE: we don't remove ourselves from the waitqueue because

--------------020207060203010307060009--

