Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262151AbSIZC5y>; Wed, 25 Sep 2002 22:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262152AbSIZC5y>; Wed, 25 Sep 2002 22:57:54 -0400
Received: from [217.7.64.198] ([217.7.64.198]:49877 "EHLO mx1.net4u.de")
	by vger.kernel.org with ESMTP id <S262151AbSIZC5x>;
	Wed, 25 Sep 2002 22:57:53 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ernst Herzberg <earny@net4u.de>
Reply-To: earny@net4u.de
To: Adam Goldstein <Whitewlf@Whitewlf.net>
Subject: Re: Very High Load, kernel 2.4.18, apache/mysql
Date: Thu, 26 Sep 2002 05:03:02 +0200
User-Agent: KMail/1.4.2
Cc: linux-kernel@vger.kernel.org
References: <B7E52DA4-D0C3-11D6-8C5C-000502C90EA3@Whitewlf.net>
In-Reply-To: <B7E52DA4-D0C3-11D6-8C5C-000502C90EA3@Whitewlf.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209260503.02474.earny@net4u.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mittwoch, 25. September 2002 22:16, Adam Goldstein wrote:

> [.....]  It has still
> reached >25 load when apache processes reached 120 (112 active
> according to server-status) and page loads come to near dead stop...
> segfaults still exist, even with fixed mysql connection calls. :(
> 1-4/min under present  25+ load.
>
> [.....]

> Server uptime: 2 hours 10 minutes 6 seconds
> 43 requests currently being processed, 13 idle servers

> KK_WW_WW_K_KWLWWWKW_KKKK.__K_WWW_WWW_K_WWWWK_WKWW_WKK.W...W....W...W..

>>   PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
>> 16800 apache    20   0  4732 4260  2988 R    37.7  0.2   0:35 httpd
>> 21171 apache    16   0  4976 4548  3268 R    36.6  0.2   2:02 httpd
>>  6949 apache    17   0  4604 4132  2936 R    36.5  0.2   0:53 httpd
>> 29183 apache    17   0  4900 4468  3192 R    36.0  0.2   6:18 httpd

--------------------------------------------------------

Looks very bad. Not the '>25 load', don't panic if that reaches more than 50 or more, 
if at the same time the processors don't reaches the 100%. 

First reconfigure your apache, with

MaxClients 256  # absolute minimum, maybe you have to recompile apache
MinSpareServers 100  # better 150 to 200
MaxSpareServers 200 # bring it near MaxClients

Make shure, you have enough resources available, su to apache, make shure
 ulimit -a
data seg size (kbytes)      unlimited
file size (blocks)          unlimited
max locked memory (kbytes)  unlimited
max memory size (kbytes)    unlimited
open files                  65536 (!!)
pipe size (512 bytes)       8
stack size (kbytes)         unlimited
cpu time (seconds)          unlimited
max user processes          4095 (!!)
virtual memory (kbytes)     unlimited

cat /proc/sys/fs/file-max
131072

Your machine should handle that. 

Reason: Bring the count of forks of apache clients to a minimum. But you have to be careful.
You need everywhere the needed resources, max client connects to mysql for example. 

And increase the apache-servers in several steps. If you have a bug or bad implementation
in your php scripts, you can run out of your cpu-resources.

If still the cpu-usage is about 100%, redesign your software or buy a bigger machine ;-)

<Earny>
