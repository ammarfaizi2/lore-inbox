Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262048AbUBBXgz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 18:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbUBBXgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 18:36:55 -0500
Received: from mail-07.iinet.net.au ([203.59.3.39]:4489 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262048AbUBBXgw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 18:36:52 -0500
Message-ID: <401EDEF2.6090802@cyberone.com.au>
Date: Tue, 03 Feb 2004 10:36:18 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Philip Martin <philip@codematters.co.uk>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.1 slower than 2.4, smp/scsi/sw-raid/reiserfs
References: <87oesieb75.fsf@codematters.co.uk>	<20040201151111.4a6b64c3.akpm@osdl.org>	<401D9154.9060903@cyberone.com.au> <87llnm482q.fsf@codematters.co.uk>	<401DDCD7.3010902@cyberone.com.au> <401E1131.6030608@cyberone.com.au> <87d68xcoqi.fsf@codematters.co.uk>
In-Reply-To: <87d68xcoqi.fsf@codematters.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Philip Martin wrote:

>Nick Piggin <piggin@cyberone.com.au> writes:
>
>
>>Another thing I just saw - you've got quite a lot of memory in
>>buffers which might be something going wrong.
>>
>>When the build finishes and there is no other activity, can you
>>try applying anonymous memory pressure until it starts swapping
>>to see if everything gets reclaimed properly?
>>
>
>How do I apply anonymous memory pressure?
>
>

Well just run something that uses a lot of memory and doesn't
do much else. Run a few of these if you like:

#include <stdlib.h>
#include <unistd.h>
#define MEMSZ (64 * 1024 * 1024)
int main(void)
{
    int i;
    char *mem = malloc(MEMSZ);
    for (i = 0; i < MEMSZ; i+=4096)
       mem[i] = i;
    sleep(60);
    return 0;
}

>>Was each kernel freshly booted and without background activity
>>before each compile?
>>
>
>Each kernel was freshly booted.  There were a number of daemons
>running, and I was running X, but these don't appear to use much
>memory or CPU and the network was disconnected.  Just after a boot
>there is lots of free memory, but in normal operation the machine uses
>its memory, so to make it more like normal I ran "find | grep" before
>doing the build.  Then I ran make clean, make, make clean, make and
>took numbers for the second make.
>
>You can have the numbers straight after a boot as well.  In this case
>I rebooted, logged in, ran make clean and make -j4.
>
>I can hear disk activity on this machine. During a 2.4.24 build the
>activity happens in short bursts a few seconds apart.  During a 2.6.1
>build it sounds as if there is more activity, with each burst of
>activity being a little longer.  However that just the impression I
>get, I haven't tried timing anything, I may be imagining it.
>
>

Thanks. Much the same, isn't it?
Can you try booting with the kernel argument: elevator=deadline
and see how 2.6 goes?

Andrew, any other ideas?

