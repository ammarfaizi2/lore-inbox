Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964838AbWEYDwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbWEYDwU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 23:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964843AbWEYDwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 23:52:20 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:53213 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S964838AbWEYDwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 23:52:20 -0400
Message-ID: <447529DA.8040800@catalyst.net.nz>
Date: Thu, 25 May 2006 15:51:54 +1200
From: Sam Vilain <sam.vilain@catalyst.net.nz>
Organization: Catalyst IT (NZ) Ltd
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: ebiederm@xmission.com, linux-kernel@vger.kernel.org, serue@us.ibm.com,
       herbert@13thfloor.at, dev@sw.ru, devel@openvz.org, sam@vilain.net,
       xemul@sw.ru, haveblue@us.ibm.com, clg@fr.ibm.com,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH 3/3] proc: make UTS-related sysctls utsns aware
References: <20060523012300.13531.96685.stgit@localhost.localdomain>	<20060523012301.13531.12776.stgit@localhost.localdomain> <20060524085414.40b980f5.akpm@osdl.org>
In-Reply-To: <20060524085414.40b980f5.akpm@osdl.org>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Sam Vilain <sam.vilain@catalyst.net.nz> wrote:
> 
>>Add a new function proc_do_utsns_string, that derives the pointer
>> into the uts_namespace->name structure, currently based on the
>> filename of the dentry in /proc, and calls _proc_do_string()
>> ---
>> RFC only - not tested yet.  builds, though
> 
> 
> So... is it tested yet?

No, I was waiting for feedback

(hackhackhack)

ok, now it's tested

root@ken:~# ./chuts /bin/bash
root@ken:~# uname -a
Linux ken 2.6.17-rc4-mm2-g2214c350 #8 PREEMPT Thu May 25 09:32:27 NZST
2006 x86_64 GNU/Linux
root@ken:~# hostname bert
root@ken:~# uname -a
Linux bert 2.6.17-rc4-mm2-g2214c350 #8 PREEMPT Thu May 25 09:32:27 NZST
2006 x86_64 GNU/Linux
root@ken:~# exit
root@ken:~# uname -a
Linux ken 2.6.17-rc4-mm2-g2214c350 #8 PREEMPT Thu May 25 09:32:27 NZST
2006 x86_64 GNU/Linux
root@ken:~# cat /proc/sys/kernel/hostname
ken
root@ken:~# ./chuts /bin/sh -c "hostname bert && cat
/proc/sys/kernel/hostname"
bert
root@ken:~# cat /proc/sys/kernel/hostname
ken
root@ken:~# ./chuts /bin/sh -c "echo 'bob' > /proc/sys/kernel/hostname
&& uname -n"
bob
root@ken:~# uname -n
ken


> You owe me three Signed-off-by:s, please.

They should be coming your way seperately very shortly.  I've revised
the third one (namespaces-utsname-sysctl-hack-cleanup-2.patch), see my
reply to Dave Hansen's e-mail.  The revised version is the one I tested.
-- 
Sam Vilain, Catalyst IT (NZ) Ltd.
phone: +64 4 499 2267        cell:  +64 21 55 40 50
DDI:   +64 4 803 2342        PGP ID: 0x66B25843
