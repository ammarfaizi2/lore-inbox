Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263339AbTEPUb5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 16:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264386AbTEPUb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 16:31:57 -0400
Received: from pizda.ninka.net ([216.101.162.242]:4016 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263339AbTEPUb4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 16:31:56 -0400
Date: Fri, 16 May 2003 13:44:06 -0700 (PDT)
Message-Id: <20030516.134406.74725937.davem@redhat.com>
To: chas@locutus.cmf.nrl.navy.mil
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] add reference counting to atm_dev 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200305161605.h4GG5fGi018381@locutus.cmf.nrl.navy.mil>
References: <20030515.171457.02279102.davem@redhat.com>
	<200305161605.h4GG5fGi018381@locutus.cmf.nrl.navy.mil>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: chas williams <chas@locutus.cmf.nrl.navy.mil>
   Date: Fri, 16 May 2003 12:05:41 -0400
   
   true.  however, i think i would like to do both at once.  but it seems 
   like just replacing atm_dev_lock with rtnl would probably be enough
   for right now.
   
You still need to have a spinlock to guard the actual insert/delete
from the list so that readers don't see inconsistent data.

Really, look at how netdevices are managed, searched, etc.

   >Ok, I'll apply this.  But long term we really need to clean out
   >the cobwebs here, use RTNL, do solid module refcounting etc.
   
   are you referring to the other bits of linux-atm like br2684, lane,
   mpoa, pppoatm or something else?
   
The whole ATM stack needs to be doing sane things in this area, yes.
