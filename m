Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262793AbTELVTl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 17:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbTELVTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 17:19:40 -0400
Received: from pizda.ninka.net ([216.101.162.242]:48782 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262793AbTELVTj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 17:19:39 -0400
Date: Mon, 12 May 2003 13:26:41 -0700 (PDT)
Message-Id: <20030512.132641.35021107.davem@redhat.com>
To: chas@locutus.cmf.nrl.navy.mil
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] make clip modular 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200305122126.h4CLQ4Gi030745@locutus.cmf.nrl.navy.mil>
References: <20030512.115758.39166911.davem@redhat.com>
	<200305122126.h4CLQ4Gi030745@locutus.cmf.nrl.navy.mil>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: chas williams <chas@locutus.cmf.nrl.navy.mil>
   Date: Mon, 12 May 2003 17:26:04 -0400

   how about this for now for clip (lane et al will come later):
   
Still buggy.

...

   -#ifdef CONFIG_ATM_CLIP
   +#if defined(CONFIG_ATM_CLIP) || defined(CONFIG_ATM_CLIP_MODULE)
    		case SIOCMKCLIP:
    			if (!capable(CAP_NET_ADMIN))
    				ret_val = -EPERM;
    			else 
   -				ret_val = clip_create(arg);
   +				ret_val = atm_clip_ops->clip_create(arg);
    			goto done;

Do you know that atm_clip_ops is non-NULL here?  How is that?

Also how can you legally call into a module without having a reference
to it or somehow otherwise blocking it's unloading (f.e. by holding
the ops semaphore)?

Chas, please think carefully about this problem.
