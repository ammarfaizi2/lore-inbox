Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131830AbRCUXMo>; Wed, 21 Mar 2001 18:12:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131821AbRCUXMX>; Wed, 21 Mar 2001 18:12:23 -0500
Received: from ns-inetext.inet.com ([199.171.211.140]:17572 "EHLO
	ns-inetext.inet.com") by vger.kernel.org with ESMTP
	id <S131819AbRCUXMU>; Wed, 21 Mar 2001 18:12:20 -0500
Message-ID: <3AB9352A.71E42C38@inet.com>
Date: Wed, 21 Mar 2001 17:11:38 -0600
From: Eli Carter <eli.carter@inet.com>
Organization: Inet Technologies, Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.5-15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Patrick O'Rourke" <orourke@missioncriticallinux.com>
CC: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <3AB9313C.1020909@missioncriticallinux.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick O'Rourke wrote:
> 
> Since the system will panic if the init process is chosen by
> the OOM killer, the following patch prevents select_bad_process()
> from picking init.
> 
> Pat
> 
> --- xxx/linux-2.4.3-pre6/mm/oom_kill.c  Tue Nov 14 13:56:46 2000
> +++ linux-2.4.3-pre6/mm/oom_kill.c      Wed Mar 21 15:25:03 2001
> @@ -123,7 +123,7 @@
> 
>          read_lock(&tasklist_lock);
>          for_each_task(p) {
> -               if (p->pid) {
> +               if (p->pid && p->pid != 1) {
>                          int points = badness(p);
>                          if (points > maxpoints) {
>                                  chosen = p;
> 

Having not looked at the code... Why not "if( p->pid > 1 )"?  (Or can
p->pid can be negative?!, um, typecast to unsigned...)

Eli
-----------------------.           Rule of Accuracy: When working toward
Eli Carter             |            the solution of a problem, it always 
eli.carter(at)inet.com `------------------ helps if you know the answer.
