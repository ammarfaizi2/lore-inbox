Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316589AbSEPGnl>; Thu, 16 May 2002 02:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316590AbSEPGnk>; Thu, 16 May 2002 02:43:40 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:4622 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S316589AbSEPGnj>; Thu, 16 May 2002 02:43:39 -0400
Message-Id: <200205160640.g4G6eKY16156@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Rik van Riel <riel@conectiva.com.br>,
        William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [RFC][PATCH] iowait statistics
Date: Thu, 16 May 2002 09:42:52 -0200
X-Mailer: KMail [version 1.3.2]
Cc: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
In-Reply-To: <Pine.LNX.4.44L.0205151558180.32261-100000@imladris.surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 May 2002 17:00, Rik van Riel wrote:
> > $ top
> > fscanf failed on /proc/stat for cpu 1
>
> Doh, take a look at top.c around line 1460:
>
>               for(i = 0; i < nr_cpu; i++) {
>                 if(fscanf(file, "cpu%*d %d %d %d %d\n",
>                           &u_ticks, &n_ticks, &s_ticks, &i_ticks) != 4) {
>                   fprintf(stderr, "fscanf failed on /proc/stat for cpu
> %d\n", i);
>
> It would have been ok (like vmstat) if it didn't expect the \n
> after the fourth number ;/
>
> Oh well, time for another procps patch ;)

While you're at it:

          printf("CPU states:"
                 " %2ld.%ld%% user, %2ld.%ld%% system,"
                 " %2ld.%ld%% nice, %2ld.%ld%% idle",
                 user_ticks / 10UL, user_ticks % 10UL,
                 system_ticks / 10UL, system_ticks % 10UL,
                 nice_ticks / 10UL, nice_ticks % 10UL,
                 idle_ticks / 10UL, idle_ticks % 10UL);

" %2ld" -> "%3ld" will make 100.00% look much nicer:
Current code: " 34.56%" " 100.00%" (i.e. 100% is one char wider!)
New code:     " 34.56%" "100.00%"

Same here:

          printf ("CPU%d states: %2d.%-d%% user, %2d.%-d%% system,"
                  " %2d.%-d%% nice, %2d.%-d%% idle",
                  cpumap,

Another thing: in sight of moves towards 64bit jiffies isn't it wise to
use unsigned long long (or explicit u64) for all these numbers?
--
vda
