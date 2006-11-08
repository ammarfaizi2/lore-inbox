Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161395AbWKHSFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161395AbWKHSFN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 13:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161415AbWKHSFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 13:05:13 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:26893 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161395AbWKHSFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 13:05:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Bh8h5uZ/wBT4oonlmAHl1CqW3F6jVtGxQeMHqHzaqomsNXU17UxYQCHpHgC7ofO68l2BOm8ig9EZ/e8Q/109jpOldLX5TjXQ1Gmkbfkp9orqIzchRPMw6TfgIh/JCrFRg/rscw7RMzgtPXFi1aTGqL1MWq4zymD0PIHkkjIbt94=
Message-ID: <3f250c710611081005v5fcf3236qfb10b47bab1ada5f@mail.gmail.com>
Date: Wed, 8 Nov 2006 14:05:10 -0400
From: "Mauricio Lin" <mauriciolin@gmail.com>
To: balbir@in.ibm.com
Subject: Jiffies wraparound is not treated in the schedstats
Cc: linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Balbir,

Do you know why in the sched_info_arrive() and sched_info_depart()
functions the calculation of delta_jiffies does not use the time_after
or time_before macro to prevent  the miscalculation when jiffies
overflow?

For instance the delta_jiffies variable is simply calculated as:

delta_jiffies = now - t->sched_info.last_queued;

Do not you think the more logical way should be

if (time_after(now, t->sched_info.last_queued))
   delta_jiffies = now - t->sched_info.last_queued;
else
   delta_jiffies = (MAX_JIFFIES - t->sched_info.last_queued) + now

I have included more variables to measure some issues of schedule in
the kernel (following schedstat idea) and I noticed that jiffies
wraparound has led to wrong values, since the user space tool when
collecting the values is producing negative values.

Any comments?

Can I provide a patch for that?

BR,

Mauricio Lin.
