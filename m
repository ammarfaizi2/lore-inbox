Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261617AbVBSFAf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbVBSFAf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 00:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261632AbVBSFAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 00:00:35 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:52591 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261617AbVBSFA2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 00:00:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:organization:to:subject:date:user-agent:references:in-reply-to:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=rHUqhjounZ7mxLoszdnxiBHgPsbwLU3oRCfRST0QSb0f0IWydwwMTbitMBNiFZ3qEMDGgX5P5ilmaopNvqzh48iUE8FL2Tb+lJeK8/t7QviLpaARJVzPVAIYuXd4xh4sOcf6zaVoBhPzORiV0+19tiLjCSOeSX7V3XokHNOxfhw=
From: Vicente Feito <vicente.feito@gmail.com>
Organization: none
To: Roland Dreier <roland@topspin.com>
Subject: Re: workqueue - process context
Date: Sat, 19 Feb 2005 02:02:08 +0000
User-Agent: KMail/1.7.1
References: <200502190148.11334.vicente.feito@gmail.com> <52is4ptae0.fsf@topspin.com>
In-Reply-To: <52is4ptae0.fsf@topspin.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502190202.08782.vicente.feito@gmail.com>
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
