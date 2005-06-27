Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262119AbVF0QMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbVF0QMu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 12:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261751AbVF0QIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 12:08:20 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:26331 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261745AbVF0QEa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 12:04:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pc8V/jKbyViM3NWz3wzXZgOw6/UXoRwUjxOz3OVz7d5QDE4pELTLnerd1KLCjUnN5pOmeObECw0eryhRtRGuqB9vsVXVnfBZObx5XcNRgp5j2VwYv8CjP+WuHnUZ7TNfrTFZ6ULk6nB+jVg1A+PMrTfTPFvSPa25OohvZ3weCnA=
Message-ID: <29495f1d05062709041af9f9cd@mail.gmail.com>
Date: Mon, 27 Jun 2005 09:04:27 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Denis Vlasenko <vda@ilport.com.ua>
Subject: Re: [RFC] Driver writer's guide to sleeping
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200506251250.18133.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200506251250.18133.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/05, Denis Vlasenko <vda@ilport.com.ua> wrote:
> Hi folks,
> 
> I'm working on a Linux wireless driver.
> 
> I compiled a little guide for myself about waiting primitives.
> I would appreciate if you look thru it. Maybe I'm wrong somewhere.

<snip>
> schedule_timeout(timeout)
<snip>
> msleep(ms)
<snip>
> msleep_interruptible(ms)
<snip>

So, there are four cases in the schedule_timeout() family of sleeps,
based one what you would like to be woken up on:

Signals and Waitqueue events:
     set_current_state(TASK_INTERRUPTIBLE);
     schedule_timeout(some_time_in_jiffies);

Signals only:
     msleep_interruptible(some_time_in_msecs);

Waitqueue events only:
      set_current_state(TASK_UNINTERRUPTIBLE);
      schedule_timeout(some_time_in_jiffies);

Neither signals nor waitqueues:
      msleep(some_time_in_msecs);

Hopefully that clears some things up.

w.r.t to wait-queue event sleeping, you probably should also be aware
of the wait_event() family of macros.

Thanks,
Nish
