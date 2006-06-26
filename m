Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932829AbWFZTE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932829AbWFZTE1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 15:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932831AbWFZTE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 15:04:27 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:53973 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932829AbWFZTEZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 15:04:25 -0400
Message-ID: <44A02FB0.6000505@sgi.com>
Date: Mon, 26 Jun 2006 12:04:16 -0700
From: Jay Lan <jlan@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040906
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Balbir Singh <balbir@in.ibm.com>,
       Chris Sturtivant <csturtiv@sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] delay accounting taskstats interface send tgid once
References: <44A02331.8020903@watson.ibm.com>
In-Reply-To: <44A02331.8020903@watson.ibm.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shailabh,

Is this patch supposed to go on top of all other patches? Or is it
supposed to replace any? I had failure applying this patch on top
of all previously applied.

- jay


Shailabh Nagar wrote:
> Send per-tgid data only once during exit of a thread group instead of once with
> each member thread exit.
> 
> Currently, when a thread exits, besides its per-tid data, the per-tgid data of
> its thread group is also sent out, if its thread group is non-empty. The
> per-tgid data sent consists of the sum of per-tid stats for all *remaining*
> threads of the thread group.
> 
> This patch modifies this sending in two ways:
> 
> - the per-tgid data is sent only when the last thread of a thread group exits.
> This cuts down heavily on the overhead of sending/receiving per-tgid data,
> especially  when other exploiters of the taskstats interface aren't interested
> in per-tgid stats
> 
> - the semantics of the per-tgid data sent are changed. Instead of being the
> sum of per-tid data for remaining threads, the value now sent is the true total
> accumalated statistics for all threads that are/were part of the thread group.
> 
> The patch also addresses a minor issue where failure of one accounting
> subsystem to fill in the taskstats structure was causing the send of taskstats
> to not be sent at all.
> 
> The patch has been tested for stability and run cerberus for over 4 hours on
> an SMP.
> 
> Signed-off-by: Shailabh Nagar <nagar@watson.ibm.com>
> Signed-off-by: Balbir Singh <balbir@in.ibm.com>
