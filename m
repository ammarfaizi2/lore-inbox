Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751315AbWFBISG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbWFBISG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 04:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbWFBISG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 04:18:06 -0400
Received: from mail22.syd.optusnet.com.au ([211.29.133.160]:7847 "EHLO
	mail22.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751315AbWFBISF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 04:18:05 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH RFC] smt nice introduces significant lock contention
Date: Fri, 2 Jun 2006 18:17:46 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "'Chris Mason'" <mason@suse.com>, Ingo Molnar <mingo@elte.hu>
References: <000101c685d7$1bc84390$d234030a@amr.corp.intel.com> <200606021608.33928.kernel@kolivas.org> <447FEE6C.7000408@yahoo.com.au>
In-Reply-To: <447FEE6C.7000408@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606021817.46745.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 June 2006 17:53, Nick Piggin wrote:
> This is a small micro-optimisation / cleanup we can do after
> smtnice gets converted to use trylocks. Might result in a little
> less cacheline footprint in some cases.

It's only dependent_sleeper that is being converted in these patches. The 
wake_sleeping_dependent component still locks all runqueues and needs to 
succeed in order to ensure a task doesn't keep sleeping indefinitely. That 
one doesn't get called from schedule() so is far less expensive. This means I 
don't think we can change that cpu based locking order which I believe was 
introduce to prevent a deadlock (?DaveJ disovered it iirc).

-- 
-ck
