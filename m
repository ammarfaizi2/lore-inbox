Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261864AbVANCkS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261864AbVANCkS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 21:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbVANCkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 21:40:17 -0500
Received: from peabody.ximian.com ([130.57.169.10]:63163 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261855AbVANCjz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 21:39:55 -0500
Subject: RE: 2.6.10-mm3 scaling problem with inotify
From: Robert Love <rml@novell.com>
To: "Zou, Nanhai" <nanhai.zou@intel.com>
Cc: John McCutchan <ttb@tentacle.dhs.org>, linux-kernel@vger.kernel.org,
       hawkes@tomahawk.engr.sgi.com
In-Reply-To: <894E37DECA393E4D9374E0ACBBE7427013CA7E@pdsmsx402.ccr.corp.intel.com>
References: <894E37DECA393E4D9374E0ACBBE7427013CA7E@pdsmsx402.ccr.corp.intel.com>
Content-Type: text/plain
Date: Thu, 13 Jan 2005 21:41:48 -0500
Message-Id: <1105670508.6027.254.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-14 at 10:31 +0800, Zou, Nanhai wrote:

(your email wraps badly)

>  There is still a little difference between your implement in
>  inotify_dentry_parent_queue_event from dnotify_parent
>  
>  In dnotify_parent, if parent is not watching the event, the code will
> not fall
>  through dget and dput path.
>  
>  While in inotify_dentry_parent_queue_event kernel will go dget and dput
> even
>  if (inode->inotify_data == NULL).
>  
>  While dget and dput will introduce a lot of atomic operations..
>  And the most important, dput will grab global dcache_lock...,
>  I think that is the reason why John Hawkes saw great performance drop.
>  
>  Simply follow dnotify_parent, only call dget and dput when
> inode->inotify_data != NULL will solve this problem I think.

This is what I meant in the original email.  This is the dnotify
difference I was talking about.

The patch I submitted should put the two in parity.

	Robert Love


