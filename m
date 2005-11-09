Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932130AbVKIQ4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbVKIQ4j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 11:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbVKIQ4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 11:56:39 -0500
Received: from nproxy.gmail.com ([64.233.182.195]:62674 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932130AbVKIQ4i convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 11:56:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QkIDLiegPYFA7vcv0dO1haqT/szBDZherbinBfKAp0hYin7g37vygHOk8tj0l8/QnQBgTLMam9dT4toSOs5oOZZxA3aun1zG0b+TJELz2GyJr0he3+l1Ks/24phSHdQdtnFthVZEjIA45CTL/Cq392cVdoInM7VQ81Zo1Z9FGYY=
Message-ID: <7d40d7190511090856x24fd68f5g@mail.gmail.com>
Date: Wed, 9 Nov 2005 17:56:37 +0100
From: Aritz Bastida <aritzbastida@gmail.com>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Subject: Re: Stopping Kernel Threads at module unload time
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0511091110190.10303@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <7d40d7190511090749j3de0e473x@mail.gmail.com>
	 <Pine.LNX.4.61.0511091110190.10303@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> This is how the kernel thread is stopped.
>
>      if(info->pid)
>      {
>          (void)kill_proc(info->pid, SIGTERM, 1);
>          wait_for_completion(&info->quit);
>      }
>

I actually would prefer to do it with the new kernel thread API.
So, to create the thread:   kthread_create
bind it to a cpu:                  kthread_bind
stop it:                                kthread_stop

Now, if I call kthread_stop() in module unload time, does that code
run in user process context just like system calls do? That is
important, because if it cannot sleep, it would deadlock.
