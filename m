Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290024AbSAKR2X>; Fri, 11 Jan 2002 12:28:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290028AbSAKR2N>; Fri, 11 Jan 2002 12:28:13 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:60687 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S290024AbSAKR2E>; Fri, 11 Jan 2002 12:28:04 -0500
Date: Fri, 11 Jan 2002 15:27:53 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Dimitrie Paun <dimi@intelliware.ca>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Severe VM problem on stock RH7.2 while running Java
In-Reply-To: <F7EB06D3ED62D311A15600104B6D909F44205C@IWD_MAIL>
Message-ID: <Pine.LNX.4.33L.0201111523430.12225-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jan 2002, Dimitrie Paun wrote:

> It looks like the system spends 100% of it's time
> in the kernel, doing some VM-related thing.

> In this particular case the OOM killer managed to
> finally kill the offending java process, and the
> system recovered:

OK, so kernel 2.4.7-13 has a VM bug when running OOM. There are
two possible approaches to getting rid of this bug:

1) upgrade to a kernel which runs ok when pushed near OOM,
   like 2.4.17 with my -rmap patch ... but if you do run
   OOM with the newer kernel (a bit harder with 2.4.8 and
   newer) your JVM will still be killed

2) add more swap or ram to the machine, so you have space
   for the program you're trying to run

> Jan  9 21:29:59 vangogh kernel: Out of Memory: Killed process 6307 (java).

>    procs                      memory    swap          io     system
> cpu
>  r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy
> id
>  0  2  1 484720   2048    612   8132 2348 6076  2356  6144  316  1174  16
> 4  80
>  7  0  1 530088   2824    524   6420 568 13354   598 13366  510  1007   6
> 9  85
>  1  1  1 530100   1804    548   6352 426 7682   686  7754  268  1622  24  27
> 50
>  0  2  1 523096   2356    564   6952 662 8984  1030  8984  297   586   2  15
> 82
>  1  2  3 514984   2616    580   6844 246 8388   246  8402  414   417   3  11
> 86

As you can see, you're really running OOM here, with very
little memory available for cache or buffers. You probably
want to add more swap space and/or ram in order to get
performance.

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/




