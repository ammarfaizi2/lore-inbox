Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750896AbWJ1P2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbWJ1P2g (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 11:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750912AbWJ1P2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 11:28:36 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:24791 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750893AbWJ1P2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 11:28:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=DDsUrDXgWEIE5tVcZD5m20WffoVqG2f3kGCu6l9aOEv6K7mUfj0uqtFMizWSBc+iCgnZMYT8nhzGMYiCKwREMmMP8H/OmX7KCw2fAVGehYhDy1qfIr3z8oZ6lcomwwN6c5itRX4rnRHtFtemB2nNNZ4xYf5aN0FryT0D2DryuCA=
Date: Sat, 28 Oct 2006 19:28:34 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Mikael Starvik <starvik@axis.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] cryptocop: double spin_lock_irqsave()
Message-ID: <20061028152834.GA31651@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/cris/arch-v32/drivers/cryptocop.c |    1 -
 1 file changed, 1 deletion(-)

--- a/arch/cris/arch-v32/drivers/cryptocop.c
+++ b/arch/cris/arch-v32/drivers/cryptocop.c
@@ -2051,7 +2051,6 @@ static void cryptocop_job_queue_close(vo
 	spin_lock_irqsave(&cryptocop_process_lock, process_flags);
 
 	/* Empty the job queue. */
-	spin_lock_irqsave(&cryptocop_process_lock, process_flags);
 	for (i = 0; i < cryptocop_prio_no_prios; i++){
 		if (!list_empty(&(cryptocop_job_queues[i].jobs))){
 			list_for_each_safe(node, tmp, &(cryptocop_job_queues[i].jobs)) {

