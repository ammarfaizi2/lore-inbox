Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261411AbUKBT4U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbUKBT4U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 14:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbUKBTyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 14:54:54 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:15060 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261533AbUKBTwZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 14:52:25 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: wli@holomorphy.org, linux-kernel@vger.kernel.org
Subject: contention on profile_lock
Date: Tue, 2 Nov 2004 11:52:15 -0800
User-Agent: KMail/1.7
Cc: steiner@sgi.com, edwardsg@sgi.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411021152.16038.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm, the last patch you sent me worked ok, so I'm not sure why we're seeing 
problems with profiling now.  There seems to be very heavy contention on 
profile_lock since profile_hook is called unconditionally every timer tick.  
Should it only be called if profiling is enabled?  Is there a way we can 
check the notifier list to see if it's empty before calling it or something?  
The only user appears to be oprofile timer based profiling, so in the general 
case we're taking the profile_lock and not doing anything.

Thanks,
Jesse
