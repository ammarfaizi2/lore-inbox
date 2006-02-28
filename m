Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932570AbWB1UgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932570AbWB1UgO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 15:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932566AbWB1UgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 15:36:14 -0500
Received: from nproxy.gmail.com ([64.233.182.200]:21557 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932570AbWB1UgM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 15:36:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=C6TTp7D/GLxFShHhiTovC+LhkuBwiwLNfEMkKFaSqlq0kKsw5y+IbosBeWxTEf/O3U939eip6LP+v1H+5b8Y4tFmsUlnJXXxIo7mMGsu+UuGtZsJWUZKlFjtmuxGKvmW0421mbk+19AId5gf3hpsrDS55PrXNO4xukwz14oRFnM=
Message-ID: <598a055d0602281236m7eac9c09oc60af9ce28e7e4bf@mail.gmail.com>
Date: Tue, 28 Feb 2006 15:36:11 -0500
From: "Li, Peng" <ringer9cs@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Thread safety for epoll/libaio
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I apologize if I should not post this on LKML, but there seems to be
some lack of documentation for using epoll/AIO with threads.  Are
these interfaces thread-safe?  Can I use them safely in the following
way:

Thread A:  while(1) { io_getevents();  ... }
// wait forever until an event occurs, then handles the event and loop

Thread B:  while(1) { epoll_wait();  ... }
// same as thread A

Thread C:  ... io_submit(); ...

Thread D:  ... epoll_ctl(); ....

Suppose thread B calls epoll_wait and blocks before thread D calls
epoll_ctl.  Is it safe to do so? Will thread B be notified for the
event submitted by thread D?  Thread A and C pose the same question
for AIO.

I wrote a simple program to test these interfaces and they seem to
work without problems, but I am not sure if it is really safe to do so
in general.  If all of them works, it seems easy to use epoll and AIO
together as I can simply use another thread to harvest events from
thread A and B and make it look like a unified event notification
interface.

Peng
