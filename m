Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275265AbRJAQpV>; Mon, 1 Oct 2001 12:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275269AbRJAQpL>; Mon, 1 Oct 2001 12:45:11 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:34574 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S275265AbRJAQpD>; Mon, 1 Oct 2001 12:45:03 -0400
Date: Mon, 1 Oct 2001 12:22:43 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: "Oleg A. Yurlov" <kris@spylog.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Swapping in 2.4.10.SuSE-3 (2.4.10aa1 + some patches).
In-Reply-To: <921452911726.20011001203203@spylog.com>
Message-ID: <Pine.LNX.4.21.0110011222100.1129-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 1 Oct 2001, Oleg A. Yurlov wrote:

> 
>         Hi, folks,
> 
>         Kernel 2.4.10.SuSE-3 + patches from Andrea (from LKML), 1 CPU, 1 Gb RAM,
> 4 Gb swap. Mysql going to swap, but server has about 700Mb free memory:
> 
> buran:~ # vmstat 2
>    procs                      memory    swap          io     system         cpu
>  r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
>  0  0  0 335984 686688   6392 194476   3   6   126   167  172    83   4   1  94
>  0  0  0 335984 686688   6392 194476   0   0     0     0  102    11   0   0 100
> 
>         Result of "top" command:
> 
>   PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
>  1190 root       9   0  1220 1020   876 S     0.0  0.0   0:00 sh
>  1210 root       9   0   964  732   728 S     0.0  0.0   0:00 safe_mysqld
>  1245 mysql      9   0  318M  624   612 S     0.0  0.0   0:00 mysqld.42
>  1247 mysql      9   0  318M  624   612 S     0.0  0.0   0:00 mysqld.42
>  1248 mysql      9   0  318M  624   612 S     0.0  0.0   0:00 mysqld.42
>  1249 mysql      9   0  318M  624   612 S     0.0  0.0   0:17 mysqld.42
>  1250 mysql      9   0  318M  624   612 S     0.0  0.0   0:00 mysqld.42
>  1251 mysql      9   0  318M  624   612 S     0.0  0.0   0:29 mysqld.42
>  1252 mysql      9   0  318M  624   612 S     0.0  0.0   1:06 mysqld.42
>  1253 mysql      9   0  318M  624   612 S     0.0  0.0   0:00 mysqld.42
>  1254 mysql      9   0  318M  624   612 S     0.0  0.0   0:00 mysqld.42
>  1259 mysql      9   0  318M  624   612 S     0.0  0.0  26:01 mysqld.42
> 
>         No error messages in dmesg and syslog.
> 
>         It is normal ?

Yes. 

The kernel is just preallocating swap. If there is actual swap activity,
you can see in the "si so" (swapin/swapout) fields of vmstat. 

