Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317217AbSHHBYF>; Wed, 7 Aug 2002 21:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317230AbSHHBYF>; Wed, 7 Aug 2002 21:24:05 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:44952 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S317217AbSHHBYF>; Wed, 7 Aug 2002 21:24:05 -0400
Date: Thu, 8 Aug 2002 03:27:04 +0200
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Jeff Dike <jdike@karaya.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: context switch vs. signal delivery [was: Re: Accelerating user mode
Message-Id: <20020808032704.73d7fdda.us15@os.inf.tu-dresden.de>
In-Reply-To: <200208061742.g76HgIg31452@karaya.com>
References: <20020806180202.66f1865a.us15@os.inf.tu-dresden.de>
	<200208061742.g76HgIg31452@karaya.com>
Organization: Disorganized
X-Mailer: Sylpheed version 0.7.8claws (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Aug 2002 13:42:18 -0400
Jeff Dike <jdike@karaya.com> wrote:
> 
> The kernel process can examine the signal pending mask of the process after
> it has transferred SIGIO to itself.  This can be done either through 
> /proc/<pid>/status or a ptrace extension, since we're happily postulating 
> new things for it to do anyway.  If there is a SIGIO pending, it calls
> sigio_handler.
> 
> Any other possibilities that you see?

Another possibility could be the kernel process and the task processes sharing
a pending signal queue, either for one particular signal or all signals. The
kernel process would block SIGIO while the task runs and when the task enters
kernel mode with a SIGIO still trapped in the task process, SIGIO would get
delivered in the kernel and cleared from the shared pending queue, which is
just what we want.

Someone actually already tried implementing it with a clone extension, see
http://www.rhdv.cistron.nl/sigqueue.html

-Udo.
