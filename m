Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261634AbVBSFgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261634AbVBSFgr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 00:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261636AbVBSFgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 00:36:47 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:21906 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261634AbVBSFgp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 00:36:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:organization:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=jriBlR2AgZHYSg5jIALIL26TBzB3O915zJRxCBtQ2U+0v7/fC6OfeYkksStr9WJVxjJQWd58zPGQQrIO+KSc3Ucgv4IRE7bt8eOA5X0FVNrxHK2BYRub59Yearyk+1EfkImELOywecqIkcvtSa5oVjEqySbVn3/JQauSdz9bo2E=
From: Vicente Feito <vicente.feito@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: workqueue - process context
Date: Sat, 19 Feb 2005 02:38:26 +0000
User-Agent: KMail/1.7.1
Organization: none
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502190238.26660.vicente.feito@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 19 February 2005 04:57 am, you wrote:
>     Vicente> I've been playing with workqueues, and I've found that
>     Vicente> once I unload the module, if I don't call
>     Vicente> destroy_workqueue(); then the workqueue I've created
>     Vicente> stays in the process list, [my_wq], I don't know if
>     Vicente> that's meant to be, or is it a bug, cause I believe there
>     Vicente> can be two options in here:
>
>     Vicente> 1) It's meant to be so you can unload your module and let
>     Vicente> the works run some time after you're already gone, that
>     Vicente> allows you to probe other modules or do whatever necesary
>     Vicente> without the need to wait for the workqueue to be emtpy.
>
>     Vicente> 2) It's a bug, cause the module allows to be unloaded,
>     Vicente> destroying the structs but not removing the workqueue
>     Vicente> from the process context.
>
> Not destroying its workqueue is a bug in the module just like any
> other resource leak.  It's analogous to a module allocating some
> memory with kmalloc() and not calling kfree() when it's unloaded.  If
> a module creates a workqueue, then it should call destroy_workqueue()
> when it's unloaded.
What if I need the module to be unloaded cause It's mutually exclusive with 
another module to be loaded, and I still need to run the works in a workqueue 
time before that happens? That's completely out of the picture?cause that 
might be useful.
>
> By the way, the module (or any code calling destroy_workqueue()) must
> make sure that it has race conditions that might result in work being
> submitted to the queue while it is being destroyed.
yes, I think flushing is enough, is it?

>
>  -R .
Vicente.
