Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbTENUA4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 16:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbTENUA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 16:00:56 -0400
Received: from pizda.ninka.net ([216.101.162.242]:25246 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261279AbTENUAz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 16:00:55 -0400
Date: Wed, 14 May 2003 13:13:19 -0700 (PDT)
Message-Id: <20030514.131319.70202360.davem@redhat.com>
To: kaber@trash.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: set state to XFRM_STATE_DEAD before calling
 xfrm_state_put in pfkey_msg2xfrm_state
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3EC259FD.1010706@trash.net>
References: <3EC259FD.1010706@trash.net>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Patrick McHardy <kaber@trash.net>
   Date: Wed, 14 May 2003 17:00:13 +0200

   This patch sets x->state to XFRM_STATE_DEAD before calling
   xfrm_state_put in pfkey_msg2xfrm_state to avoid triggering
   the BUG_TRAP in __xfrm_state_destroy. The patch applies to both
   2.5 and the 2.4 backport.
   
You didn't test this change.  x->type is a pointer, not a place where
you put XFRM_STATE_DEAD, a simple compile test would have alerted
this to you.

This also means you couldn't possibly have tested if this even
makes the assertion go away, it couldn't possibly have fixed this..

The correct fix, of course, is to set x->km.state to this value.
This is what I've done in my tree.

Please be a LOT more careful with your changes.
