Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261343AbVDZHwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261343AbVDZHwR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 03:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbVDZHwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 03:52:17 -0400
Received: from bernache.ens-lyon.fr ([140.77.167.10]:7818 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261343AbVDZHwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 03:52:12 -0400
Message-ID: <426DF305.7060109@ens-lyon.org>
Date: Tue, 26 Apr 2005 09:51:33 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050116)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
Cc: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org
Subject: Re: Crash when unmounting NFS/TCP with -f
References: <4268EEC9.8010305@ens-lyon.org> <426945CC.6040100@tmr.com>
In-Reply-To: <426945CC.6040100@tmr.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Report: *  1.1 NO_DNS_FOR_FROM Domain in From header has no MX or A DNS records
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen a écrit :
> Brice Goglin wrote:
> 
>> Hi Trond,
>>
>> I'm using NFS (v2) over TCP (in a SSH tunnel).
>> Each time the SSH dies before a umount NFS, I have to umount -f
>> and I get a crash (only sysrq works).
>> Actually, the crash occurs a few seconds after umount -f.
>>
>> It seems that killing SSH by hand does _not_ lead to crash.
>> But a long network failure does.
>> I remember seeing this bug several times with all stable releases
>> from 2.6.7 to 2.6.11. I didn't try with earlier versions.
>>
>> I didn't see anything in the logs (after reboot). But I can't be sure
>> there was nothing in dmesg since I didn't get a chance to chvt 1 and
>> see console messages before rebooting (with sysrq).
>>
>> Do you have any idea how to debug this ?
> 
> 
> No clue, but a question: is this a hard or soft mount? Could you post 
> your ssh and mount commands, munged as needed for security? That might 
> give someone a clue.

The ssh command is just
$ ssh kwad -L 2249:localhost:2049 -L 2248:localhost:870 -N -f
(port is forwarded to 2249 while mountport if forwarded to 2248)

Options is /proc/mounts are
rw,v2,rsize=8192,wsize=8192,hard,tcp,nolock,addr=localhost

I just had another network failure. I ran umount -f from vt1 to see
kernel message. I waited for about 1 minute but didn't get any crash.
So I switched back to X... and got the crash then.
Looks like this crash doesn't want me to see any message...

Brice
