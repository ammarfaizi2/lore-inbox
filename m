Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267553AbUJVU0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267553AbUJVU0g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 16:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267745AbUJVU0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 16:26:10 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:30178 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267553AbUJVUX5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 16:23:57 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: linux-kernel@vger.kernel.org
Subject: BUG_ONs in signal.c?
Date: Fri, 22 Oct 2004 13:23:49 -0700
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410221323.49298.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently saw a bug where someone hit the BUG_ON in signal.c after the 
do_coredump code (in my kernel "kernel BUG at signal.c:1614").  After looking 
at it a bit, it seems that we drop the sighand lock prior to calling into the 
core dump routine, which leaves the task vulnerable to having it's group_exit 
or group_exit_code changed either during the coredump or shortly after, 
causing one of the BUG_ONs to trip (in this particular case it was the 
group_exit_code != code check).  Are these BUG_ON checks necessary anymore?  
Or should we be holding the sighand lock all the way until we call do_exit or 
do_group_exit?  Or something else?

Thanks,
Jesse
