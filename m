Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287204AbSCGJNd>; Thu, 7 Mar 2002 04:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287386AbSCGJNX>; Thu, 7 Mar 2002 04:13:23 -0500
Received: from web10507.mail.yahoo.com ([216.136.130.157]:16393 "HELO
	web10507.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S287204AbSCGJNL>; Thu, 7 Mar 2002 04:13:11 -0500
Message-ID: <20020307091311.16356.qmail@web10507.mail.yahoo.com>
Date: Thu, 7 Mar 2002 01:13:11 -0800 (PST)
From: Andy Tai <lichengtai@yahoo.com>
Reply-To: atai@atai.org
Subject: "layered" block devices and deadlock problems
To: linux-kernel@vger.kernel.org
Cc: atai@atai.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I have been trying to write a kernel driver for a
"layered" block device, that is, a virtual device
which sits on top of actual physical devices and
redirects read/write requests to them.  To avoid
problems in the interrupt context I save the requests
in a queue in the request function and have a kernel
thread pulling the requests out of the queue and then
in turn calling read() or write() functions of the
physical block device.

However, I keep running into deadlocks.  Sometimes the
kernel thread will hang on waiting for free request
structures.  Other times it will hang in
wait_for_buffer() in buffer.c.  In both cases  the
system won't respond to any new shell commands I typed
in.  (But existing processes like xosview and top
continue to run) Since I am not familiar with the
internal workings of the buffer cache, can anyone give
me hints on how to avoid deadlocks in layered drivers?
 Or pointers to useful documentation for this kind of
tasks are also appreciated.  

Thanks.


__________________________________________________
Do You Yahoo!?
Try FREE Yahoo! Mail - the world's greatest free email!
http://mail.yahoo.com/
