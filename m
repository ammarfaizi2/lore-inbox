Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130429AbRCCHnZ>; Sat, 3 Mar 2001 02:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130430AbRCCHnQ>; Sat, 3 Mar 2001 02:43:16 -0500
Received: from www.wen-online.de ([212.223.88.39]:16400 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S130429AbRCCHnF>;
	Sat, 3 Mar 2001 02:43:05 -0500
Date: Sat, 3 Mar 2001 08:42:47 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: george anzinger <george@mvista.com>,
        Christopher Friesen <cfriesen@nortelnetworks.com>,
        John Being <olonho@hotmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: strange nonmonotonic behavior of gettimeoftheday -- seen  similar
          problem on PPC
In-Reply-To: <Pine.LNX.3.95.1010302141102.9090A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.33.0103030802280.320-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Mar 2001, Richard B. Johnson wrote:

> Yes and no. It takes microseconds to call the kernel for anything (time
> getpid() ), so it seldom loops. All the kernel has to do is remember

Hi,

c0109286  system_call +<22/40> (0.21) pid(4265)
c011c7e7  sys_gettimeofday +<13/a8> (0.27) pid(4265)
c010e3b2  do_gettimeofday +<e/88> (0.48) pid(4265)
c01092aa  ret_from_sys_call +<6/21> (0.76) pid(4265)
c0109286  system_call +<22/40> (0.19) pid(4265)
c0120b45  sys_getpid +<d/1c> (0.18) pid(4265)
c01092aa  ret_from_sys_call +<6/21> (0.77) pid(4265)
                                     ^^^^ time in usecs

This is a 500Mhz PIII.  It wouldn't take much more cpu/memory speed
to get under a usec.  The overhead of calling the kernel on this box
is almost exactly 1 usec.

	-Mike

