Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129359AbRC2Ws0>; Thu, 29 Mar 2001 17:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129506AbRC2WsH>; Thu, 29 Mar 2001 17:48:07 -0500
Received: from chromium11.wia.com ([207.66.214.139]:4115 "EHLO
	neptune.kirkland.local") by vger.kernel.org with ESMTP
	id <S129359AbRC2WsG>; Thu, 29 Mar 2001 17:48:06 -0500
Message-ID: <3AC3BC59.9DB44884@chromium.com>
Date: Thu, 29 Mar 2001 14:51:05 -0800
From: Fabio Riccardi <fabio@chromium.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "J . A . Magallon" <jamagallon@able.es>
CC: linux-kernel@vger.kernel.org
Subject: Re: linux scheduler limitations?
In-Reply-To: <3AC3A6C9.991472C0@chromium.com> <20010329233521.C6053@werewolf.able.es> <3AC3B35D.FC010700@chromium.com> <20010330003356.C1052@werewolf.able.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J . A . Magallon" wrote:

> It all depends on your app, as every parallel algorithm. In a web-ftp-whatever
> server, you do not need any synchro. You can start threads in free run and
> let them die alone.

even if you don't need synchronization you pay for it anyway, since you will have
to use the pthread version of libc that is reentrant. Moreover many calls (i.e.
accept) are "scheduling points" for pthreads, whenever you call them the runtime
will perform quite a bit of bookeeping.

it is instructive to use a profiler on your application and see what happens when
you use pthreads...

> You said, 'mapped'.
> AFAIK, that is the advantage, you can avoid the VM switch by sharing memory.

If your application uses lots of memory than I agree, Apache only uses a tiny
amount of RAM per instance though, so I don't think that that is my case.

 - Fabio


