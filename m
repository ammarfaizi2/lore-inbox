Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265795AbUJEU7n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265795AbUJEU7n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 16:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265970AbUJEU7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 16:59:43 -0400
Received: from smtp.poczta.interia.pl ([217.74.65.43]:17496 "EHLO
	smtp.poczta.interia.pl") by vger.kernel.org with ESMTP
	id S265795AbUJEU7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 16:59:40 -0400
Message-ID: <41630B2C.5020709@interia.pl>
Date: Tue, 05 Oct 2004 22:59:24 +0200
From: Patryk Jakubowski <patrics@interia.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040630
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Invisible threads in 2.6.9
References: <S268296AbUJDTjb/20041004193948Z+2396@vger.kernel.org>
In-Reply-To: <S268296AbUJDTjb/20041004193948Z+2396@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-EMID: cc776acc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I've been experimenting with process/thread accounting in 2.6.9-rc3 (and
2.6.8), and found this strange situation: if the leader thread of a
multi-threaded process terminates, the other threads become
undetectable. After the main thread becomes a zombie, /proc/PID/task
returns ENOENT on open. If you happen to know the TID, you can access
/proc/PID/* directly, but otherwise, there is no way to observe the
remaining threads, as far as I can see. Consider this program, for example:

|
#include

void *run(void *arg)
{
    for(;;)
	;
}

int main()
{
    pthread_t t;
    int i;
    for (i = 0; i < 10; ++i)
        pthread_create(&t, NULL, run, NULL);
    pthread_exit(NULL);
}
|

When I run it, the system (predictably) goes to ~100% CPU utilization,
but there seems to be no way to find out who is hogging the CPU with
top(1), ps(1), or anything else. All they can show is the main thread in
zombie state, consuming 0% CPU.

Is this correct behaviour of linux?
Would not this allow user space programs to hide running executions?
This could be an opportunity for spyware to infect the machine and hide
itself perhaps? Hope I'm wrong here!

If this is the bug in kernel (procfs?)  I can give you my configuration
and resulting behaviour.

Sorry for my bad english.



----------------------------------------------------------------------
Portal INTERIA.PL zaprasza... >>> http://link.interia.pl/f17cb

