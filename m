Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131836AbRCUXmf>; Wed, 21 Mar 2001 18:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131837AbRCUXm0>; Wed, 21 Mar 2001 18:42:26 -0500
Received: from mail.missioncriticallinux.com ([208.51.139.18]:5386 "EHLO
	missioncriticallinux.com") by vger.kernel.org with ESMTP
	id <S131836AbRCUXmN>; Wed, 21 Mar 2001 18:42:13 -0500
Message-ID: <3AB93C02.5030109@missioncriticallinux.com>
Date: Wed, 21 Mar 2001 18:40:50 -0500
From: "Patrick O'Rourke" <orourke@missioncriticallinux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.3-pre6 i686; en-US; 0.8) Gecko/20010218
X-Accept-Language: en
MIME-Version: 1.0
To: Eli Carter <eli.carter@inet.com>
CC: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <3AB9313C.1020909@missioncriticallinux.com> <3AB9352A.71E42C38@inet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eli Carter wrote:

> Having not looked at the code... Why not "if( p->pid > 1 )"?  (Or can
> p->pid can be negative?!, um, typecast to unsigned...)

I simply mirrored the check done in do_exit():

	if (tsk->pid == 1)
		panic("Attempted to kill init!");

Since PID_MAX is 32768 I do not believe pids can be negative.

I suppose one could make an argument for skipping "daemons", i.e.
pids below 300 (see the get_pid() function in kernel/fork.c), but
I think that is a larger issue.

Pat

-- 
Patrick O'Rourke
978.606.0236
orourke@missioncriticallinux.com

