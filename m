Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261669AbULBPxY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbULBPxY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 10:53:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261658AbULBPxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 10:53:24 -0500
Received: from rproxy.gmail.com ([64.233.170.198]:26422 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261661AbULBPwO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 10:52:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=owYfc1XxLKv3Pt23aosOStsIAnKGDqsApVbXx0Ens0oEWW6kv5RQWR3qB0EA/1BuYIGVj0dNNM8+taPZZL66M6av8/LRPFsC9DCNCn0muE1CfUCjkCDM5lRrIWZV7YokhPw+JAw88TA6vSIp7zgHbm1zj+OT8zYGiDzRMz30tJA=
Message-ID: <3f250c7104120207524399d522@mail.gmail.com>
Date: Thu, 2 Dec 2004 11:52:13 -0400
From: Mauricio Lin <mauriciolin@gmail.com>
Reply-To: Mauricio Lin <mauriciolin@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Out of memory killer - time conditions before killing a process
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does anyone know why in the out_of_memory(int gfp_mask) function has
the following conditions:

	 * If it's been a long time since last failure,
	 * we're not oom.
	 */
	if (since > 5*HZ)
		goto reset;

	/*
	 * If we haven't tried for at least one second,
	 * we're not really oom.
	 */
	since = now - first;
	if (since < HZ)
		goto out_unlock;

	/*
	 * If we have gotten only a few failures,
	 * we're not really oom. 
	 */
	if (++count < 10)
		goto out_unlock;

These conditions prevent the oom_kill() function to be invoked. Could
anyone explain about it?
Why 5 seconds, count variable less than 10 ...?

BR,

Mauricio Lin.
