Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135670AbRDSNtB>; Thu, 19 Apr 2001 09:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135672AbRDSNsk>; Thu, 19 Apr 2001 09:48:40 -0400
Received: from passat.ndh.net ([195.94.90.26]:33017 "EHLO passat.ndh.net")
	by vger.kernel.org with ESMTP id <S135670AbRDSNsg>;
	Thu, 19 Apr 2001 09:48:36 -0400
Date: Thu, 19 Apr 2001 15:48:32 +0200
From: Alex Riesen <a.riesen@traian.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: missing poll(2) for semaphores
Message-ID: <20010419154832.B8090@traian.de>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20010419114646.B798@traian.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010419114646.B798@traian.de>; from a.riesen@traian.de on Thu, Apr 19, 2001 at 11:46:46AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just an addition to the sample:

fds[3] = sem3;
fds[4] = sem4;
fds[5] = sem5;
fds[6] = sem6;

.. and wait for any of them? or for all together?
and sure have this mixed with descriptors.

Wellknown win32 api WaitForMultipleObjects provides such
functionality, and having something like
that would help to port the applications using that api.

On Thu, Apr 19, 2001 at 11:46:46AM +0200, Alex Riesen wrote:
 Hi, all
 i am missing a good (i think) feature of unix descriptors
 in SysV semaphores - to be poll(2)-able.
 Have someone an idea to somehow achieve the goal ? 
 
 
 something like this:
 
 int sem = create_our_pollable_semaphore();
 ...
 ...
 pollfd fds[xxx];
 
 for(i=0; i < countof(fds); fds[i++].events = POLLIN|POLLOUT);
 fds[0].fd = sem;
 fds[1].fd = server_sock1;
 fds[2].fd = cmd_sock2;
 
 while ( poll(fds, countof(fds), -1) >= 0 )
  ...
 
 Thank you in advance
 
 Alex Riesen

