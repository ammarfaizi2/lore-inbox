Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293453AbSCEQnU>; Tue, 5 Mar 2002 11:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293459AbSCEQnA>; Tue, 5 Mar 2002 11:43:00 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:3758 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S293453AbSCEQm6>;
	Tue, 5 Mar 2002 11:42:58 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: Fwd: [Lse-tech] get_pid() performance fix
Date: Tue, 5 Mar 2002 11:43:44 -0500
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
In-Reply-To: <20020305145004.BFA503FE06@smtp.linux.ibm.com> <87bse39e1f.fsf@devron.myhome.or.jp>
In-Reply-To: <87bse39e1f.fsf@devron.myhome.or.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020305164239.8EFFF3FE06@smtp.linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 March 2002 11:26 am, OGAWA Hirofumi wrote:
> Hubertus Franke <frankeh@watson.ibm.com> writes:
> > @@ -153,13 +155,18 @@
> >                               if(last_pid & 0xffff8000)
> >                                     last_pid = 300;
> >                               next_safe = PID_MAX;
> > +                             goto repeat;
> >                         }
> > -                       goto repeat;
> > +                       if(unlikely(last_pid == beginpid))
> > +                             goto nomorepids;
> > +                       continue;
>
> It isn't guaranteed that pid is unique.
>
> In the case:
> 	task->pid = 300, task->xxx = 301
> 	pid 301 is free
>
> 	This get_pid() returns 301.
>
> Regards.

No the point of this patch was to limit the search time for finding
the next available pid. We are not mocking around with the 
logic that declares a pid available or not. That stays the same.
However, one doesn't need to start every single time from the
beginning to find the next available pid.

-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
