Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbUDIU5V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 16:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbUDIU5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 16:57:21 -0400
Received: from mail.kroah.org ([65.200.24.183]:18048 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261763AbUDIU5U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 16:57:20 -0400
Date: Fri, 9 Apr 2004 13:53:45 -0700
From: Greg KH <greg@kroah.com>
To: Brian King <brking@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net
Subject: Re: [PATCH] call_usermodehelper hang
Message-ID: <20040409205344.GA5236@kroah.com>
References: <4072F2B7.2070605@us.ibm.com> <20040406172903.186dd5f1.akpm@osdl.org> <20040407061146.GA10413@kroah.com> <407487A6.8020904@us.ibm.com> <20040408224713.GD15125@kroah.com> <40770AD0.4000402@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40770AD0.4000402@us.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2004 at 03:42:56PM -0500, Brian King wrote:
> Would you prefer a fix in call_usermodehelper itself? It could certainly
> be argued that calling call_usermodehelper with wait=0 should be allowed
> even when holding locks. Although, fixing it here is less obvious to me
> how to do because of the arguments to call_usermodehelper. I would imagine
> it would consist of creating a kernel_thread to preserve the caller's stack.

Yes, I think call_usermodehelper should be changed to create a new
kernel thread for every call.  That would solve this problem, and any
future races that might happen.  Care to work on that?

thanks,

greg k-h
