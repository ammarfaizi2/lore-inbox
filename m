Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbUC1Q0N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 11:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261952AbUC1Q0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 11:26:13 -0500
Received: from CS2075.cs.fsu.edu ([128.186.122.75]:31137 "EHLO mail.cs.fsu.edu")
	by vger.kernel.org with ESMTP id S261947AbUC1Q0L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 11:26:11 -0500
Message-ID: <1080491171.9b65f4fce8899@system.cs.fsu.edu>
Date: Sun, 28 Mar 2004 11:26:11 -0500
From: khandelw@cs.fsu.edu
To: linux-kernel@vger.kernel.org
Subject: ps/top doesn't show the process on a smp kernel ;)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) 4.0-cvs
X-Originating-IP: 68.84.18.28
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
    This is the simple program that I tried on a - 2.4.20-30.9smp #1 SMP Wed Feb
4 20:36:46 EST 2004 i686 i686 i386 GNU/Linux (kernel) machine.

The ps command doesn't show me the process.  /proc/ shows that these process are
present in the system. When I uncomment the call getpid(). Then it shows me the
process. I am not able to understand this behavior and I hope this is the right
place to post this question/bug.


<snip>

#include <unistd.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/wait.h>

int main()
{
    int i = 3;
    pid_t pid, pidarr[3];

    for(i = 0; i < 3;i ++) {
        if ( (pid = fork()) == 0) {
            while(1){
                /* getpid(); */
            }
        }
        pidarr[i] = pid;
    }
    for(i = 0; i < 3;i ++) {
        waitpid(pidarr[i], NULL, 0);
    }
    return 0;
}

</snip>
