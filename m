Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262426AbTEVBGK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 21:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262430AbTEVBGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 21:06:10 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:28803 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262426AbTEVBGJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 21:06:09 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andrew Theurer <habanero@us.ibm.com>
Reply-To: habanero@us.ibm.com
To: linux-kernel@vger.kernel.org
Subject: Re: must-fix list, v5
Date: Wed, 21 May 2003 20:25:47 -0500
User-Agent: KMail/1.4.3
References: <20030521152255.4aa32fba.akpm@digeo.com>
In-Reply-To: <20030521152255.4aa32fba.akpm@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200305212025.47875.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 21 May 2003 17:22, Andrew Morton wrote:
> +o Overeager affinity in presence of repeated yields
> +
> +  http://www.hpl.hp.com/research/linux/kernel/o1-openmp.php
> +
> +  ingo: this is valid.  fix is in progress.

I have seen this with SpecJBB on high warehouse runs in around 2.5.66, I am 
testing now to see if it still exists in 2.5.69.  In 2.5.66 adding a bit to 
try_to_wakeup to relocate p-task_cpu to an idle cpu (if available) if the 
p->task_cpu is currently non idle helped dramatically.  This change is also 
in Andrea's 2.4 kernel tree I believe.  Basically in some situations, a quick 
push load balance before task activation.  

Also, in this particular case, this behavior may go away with the use of 
futexes in JVM, not sure yet, so I don't know if JVM and JBB are good 
justifications to make this change.  

-Andrew Theurer

