Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964964AbVITKVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964964AbVITKVa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 06:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964965AbVITKVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 06:21:30 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:1467 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S964964AbVITKVa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 06:21:30 -0400
Subject: Re: [AIO] aio-2.6.13-rc6-B1
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: Benjamin LaHaise <bcrl@linux.intel.com>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050817184406.GA24961@linux.intel.com>
References: <20050817184406.GA24961@linux.intel.com>
Date: Tue, 20 Sep 2005 12:23:10 +0200
Message-Id: <1127211790.2051.9.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 20/09/2005 12:34:25,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 20/09/2005 12:34:27,
	Serialize complete at 20/09/2005 12:34:27
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-17 at 14:44 -0400, Benjamin LaHaise wrote:
> The bugfix followup to the last aio rollup is now available at:
> 
> 	http://www.kvack.org/~bcrl/patches/aio-2.6.13-rc6-B1-all.diff
> 
> with the split up in:
> 
> 	http://www.kvack.org/~bcrl/patches/aio-2.6.13-rc6-B1/
> 
> This fixes the bugs noticed in the -B0 variant.  Major changes in this 
> patchset are:
> 
> 	- added aio semaphore ops
> 	- aio thread based fallbacks
> 	- vectored aio file_operations
> 	- aio sendmsg/recvmsg via thread fallbacks
> 	- retry based aio pipe operations
> 
> Comments?
> 
> 		-ben
> 

  Hi Ben,

  what's the point of calling wake_up_locked(&sem->wait) in 
aio_down_wait? We're already in a wakeup path and end up
calling __wake_up_common recursively.

  I think it may be one of the cause of my kernel hanging at the
very beginning.

  When I remove this call things go further but at some point a
semaphore wait queue gets thrashed and __wake_up_common tries to
call an invalid callback function.

  Any input appreciated.

  Sébastien.

-- 
------------------------------------------------------

  Sébastien Dugué                BULL/FREC:B1-247
  phone: (+33) 476 29 77 70      Bullcom: 229-7770

  mailto:sebastien.dugue@bull.net

  Linux POSIX AIO: http://www.bullopensource.org/posix
  
------------------------------------------------------

