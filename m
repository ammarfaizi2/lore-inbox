Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261853AbVANCfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261853AbVANCfz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 21:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbVANCfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 21:35:55 -0500
Received: from coriana6.CIS.McMaster.CA ([130.113.128.17]:65253 "EHLO
	coriana6.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S261853AbVANCfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 21:35:48 -0500
Subject: RE: 2.6.10-mm3 scaling problem with inotify
From: John McCutchan <ttb@tentacle.dhs.org>
To: "Zou, Nanhai" <nanhai.zou@intel.com>
Cc: linux-kernel@vger.kernel.org, Robert Love <rml@novell.com>,
       hawkes@tomahawk.engr.sgi.com
In-Reply-To: <894E37DECA393E4D9374E0ACBBE7427013CA7E@pdsmsx402.ccr.corp.intel.com>
References: <894E37DECA393E4D9374E0ACBBE7427013CA7E@pdsmsx402.ccr.corp.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 13 Jan 2005 21:36:20 -0500
Message-Id: <1105670180.25359.2.camel@vertex>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
X-PMX-Version-Mac: 4.7.0.111621, Antispam-Engine: 2.0.2.0, Antispam-Data: 2005.1.13.29
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_VERSION 0, __SANE_MSGID 0'
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-14 at 10:31 +0800, Zou, Nanhai wrote:
>  
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
> 

Yeah, the old code was written before inode->inotify_data existed.
Robert caught this before he sent his patch. His patch should fix this
regression.

-- 
John McCutchan <ttb@tentacle.dhs.org>
