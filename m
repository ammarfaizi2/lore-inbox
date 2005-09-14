Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965045AbVINGbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965045AbVINGbE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 02:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965049AbVINGbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 02:31:03 -0400
Received: from xproxy.gmail.com ([66.249.82.204]:32419 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965045AbVINGbB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 02:31:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KTtxnkbybr097go1qutK9JRcgR7MJIinuxTfQOxW9ZUao/Y+X0MIJXfv8uQPVEUDhst0J8In/RG4c2Jj2o0Q95PWGXWAxqAtKqrjS2aDWxE/fQ15ItC4oUnjyTfnH/zwkXV6+pV2MW5hVTFBm9o3t9Hl0N0nN5SuO7I4QO8px7Q=
Message-ID: <1e33f571050913233150598e88@mail.gmail.com>
Date: Wed, 14 Sep 2005 12:01:00 +0530
From: Gaurav Dhiman <gaurav4lkg@gmail.com>
Reply-To: gaurav4lkg@gmail.com
To: Robert Hancock <hancockr@shaw.ca>
Subject: Re: wait_event_interruptible_timeout problem
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <43276101.3020104@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4MjuE-6Cb-37@gated-at.bofh.it> <43276101.3020104@shaw.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/05, Robert Hancock <hancockr@shaw.ca> wrote:
> manomugdha biswas wrote:
> >  Hi,
> >  I have a kernel module (kernel 2.6) where I have
> >  opened multiple tcp connections. when there is no
> >  data
> >  i want my process to sleep. For that i have added
> >  the
> >  following code.
> >
> >  /* Initialise the wait q head */
> >    init_waitqueue_head(&VNICClientWQHead);
> >
> >  init_waitqueue_entry(&(currentMap->waitQ), current);
> >  add_wait_queue(currentMap->sock->sk->sk_sleep,
> >  &(currentMap->waitQ));
> >
> >  /* here currentMap is a structure containing tcp
> >  conenction info for my module. There is a currentMap
> >  for each tcp connection */
> >
> >  wait_event_interruptible_timeout(VNICClientWQHead,
> >                                   0, HZ * 100000);
> >
> >  I am not sure about the condition argument, 0.
> 
> The condition should be an expression that returns true when whatever
> you are waiting for occurs - in this case when data is available. If you
> put the condition as 0 it will never wake up.

On timeout it will wake up, even if the condition is 0 ..... bu in
this case the time out is too big. Try with small timeout value and
you will see that your process wakes up.

-Gaurav

> 
> Also, why the huge timeout? If you just want to sleep forever, use
> regular wait_event_interruptible.
> 
> --
> Robert Hancock      Saskatoon, SK, Canada
> To email, remove "nospam" from hancockr@nospamshaw.ca
> Home Page: http://www.roberthancock.com/
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
- Gaurav
my blog: http://lkdp.blogspot.com/
--
