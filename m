Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289511AbSBETsm>; Tue, 5 Feb 2002 14:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289770AbSBETse>; Tue, 5 Feb 2002 14:48:34 -0500
Received: from relay-4v.club-internet.fr ([194.158.96.115]:54715 "HELO
	relay-4v.club-internet.fr") by vger.kernel.org with SMTP
	id <S289511AbSBETsS>; Tue, 5 Feb 2002 14:48:18 -0500
Message-ID: <3C6037B6.208@freesurf.fr>
Date: Tue, 05 Feb 2002 20:51:18 +0100
From: Kilobug <kilobug@freesurf.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020201
X-Accept-Language: fr-fr, fr, en
MIME-Version: 1.0
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: linux-kernel@vger.kernel.org, lkml@ohdarn.net
Subject: Re: [2.4.18-pre3-mjc3] heavy disk load and non-killable process
In-Reply-To: <3C5F24A1.1060401@freesurf.fr> <200202050826.g158QVt18059@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> On 4 February 2002 22:17, Kilobug wrote:
> 
>>Hello,
>>	I've a 2.4.18-pre3-mjc3 kernel, with preempt enabled. I was testing
>>relative performance of DMA and non-DMA IDE hard disk access,
>>and I did the following as root:
>>
>>~ # hdparm -X67 -d1 /dev/hdb
>>~ # time /bin/sh -c "cp foo bar; sync"
>>~ # time /bin/sh -c "cp foo bar; sync"
>>~ # time /bin/sh -c "cp foo bar; sync"
>>~ # hdparm -X12 -d0 /dev/hdb
>>~ # time /bin/sh -c "cp foo bar; sync"
>>~ # time /bin/sh -c "cp foo bar; sync"
>>~ # time /bin/sh -c "cp foo bar; sync"
>>(foo is a 64Mb large regular file)
>>
>>I had xmms running, and during the first two tests of the non-DMA
>>version, the sound stops and then restarts, but it didn't restart after
>>the last cp.
>>
>>What is strange (and may be a kernel bug IMHO) is that the xmms process
>>stays running and non-killable:
>>
> 
> SysRq-T, isolate xmms part, ksymoops it, send result here and CC maintainers 
> (or who you think might be interested (Andrea/Alan/...))

SysRq-T and ksymoops:
Call Trace: [<c010ac83>] [<c0114e59>] [<c01164d4>] [<c011dc05>] 
[<e486f91f>] [<c013d69d>] [<c0121d99>] [<c013c1e9>] [<c013c297>] 
[<c010702b>]
Warning (Oops_read): Code line not seen, dumping what data is available

Trace; c010ac82 <call_do_IRQ+4/a>
Trace; c0114e58 <do_schedule+58/3e0>
Trace; c01164d4 <sys_sched_yield+a4/e0>
Trace; c011dc04 <tasklet_kill+54/80>
Trace; e486f91e <[emu10k1]emu10k1_audio_release+be/230>
Trace; c013d69c <fput+4c/100>
Trace; c0121d98 <schedule_timeout+58/a0>
Trace; c013c1e8 <filp_close+68/c0>
Trace; c013c296 <sys_close+56/b0>
Trace; c010702a <system_call+32/38>


-- 
** Gael Le Mignot "Kilobug", Ing3 EPITA - http://kilobug.free.fr **
Home Mail   : kilobug@freesurf.fr          Work Mail : le-mig_g@epita.fr
GSM         : 06.71.47.18.22 (in France)   ICQ UIN   : 7299959
Fingerprint : 1F2C 9804 7505 79DF 95E6 7323 B66B F67B 7103 C5DA

"Software is like sex it's better when it's free.", Linus Torvalds

