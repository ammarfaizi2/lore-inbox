Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274623AbRITTdv>; Thu, 20 Sep 2001 15:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274621AbRITTdb>; Thu, 20 Sep 2001 15:33:31 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:55022 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S274619AbRITTd3>; Thu, 20 Sep 2001 15:33:29 -0400
Date: Thu, 20 Sep 2001 15:33:52 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: linux-kernel@vger.kernel.org,
        "Christopher K. St. John" <cks@distributopia.com>
Subject: Re: [PATCH] /dev/epoll update ...
Message-ID: <20010920153352.A20626@redhat.com>
In-Reply-To: <20010920010502.A7960@redhat.com> <XFMail.20010920112513.davidel@xmailserver.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <XFMail.20010920112513.davidel@xmailserver.org>; from davidel@xmailserver.org on Thu, Sep 20, 2001 at 11:25:13AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2001 at 11:25:13AM -0700, Davide Libenzi wrote:
> The advantage /dev/epoll has compared to aio_* and RTsig is 
> 1) multiple event delivery/system call

This is actually covered in my aio plan, and just needs the kernel 
provided syscall function library support to read from shared memory.  
The ABI I'm using is based on aio_*, but is different.  There are a 
few emails I've written on the subject recently that I can forward to 
you, but the basic API is: io_submit queues aio requests which later 
write a 32 byte completion entry containing the object, user data and 
result codes to a ringbuffer.

> 2) less user<->kernel memory moves
> 
> The concept is very similar anyway coz you basically have to initiate the
> io-call and wait for an event.
> The difference is how events are collected.

See the above. =)  aio also works much better as the io request helps 
define the duration for memory pinning of any O_DIRECT or similar 
operations that allow the hardware to act on user provided buffers.

		-ben
