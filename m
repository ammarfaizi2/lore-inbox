Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130929AbRAYSvX>; Thu, 25 Jan 2001 13:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135944AbRAYSvN>; Thu, 25 Jan 2001 13:51:13 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:20157 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S130929AbRAYSvD>; Thu, 25 Jan 2001 13:51:03 -0500
From: jekacur@ca.ibm.com
Importance: Normal
Subject: Re: [Fwd: sigcontext on Linux-ppc in user space]
To: khendricks@ivey.uwo.ca
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF391E2A9A.4D8058CB-ON852569DF.00675165@LocalDomain>
Date: Thu, 25 Jan 2001 13:50:48 -0500
X-MIMETrack: Serialize by Router on D25ML03/25/M/IBM(Release 5.0.4a |July 24, 2000) at
 01/25/2001 01:50:51 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, actually the segfault was for a more complicated function, but the
simplified example still gives the wrong answer. i.e scp should point to a
struct sigcontext and scp->signal should be 10 in the sample program.

John Kacur/Toronto/IBM@IBMCA
jekacur@ca.ibm.com
(416) 448-2584 (phone)
778-2584 (tie line)


"Kevin B. Hendricks" <khendricks@ivey.uwo.ca> on 01/25/2001 01:10:40 PM

Please respond to khendricks@ivey.uwo.ca

To:   John Kacur/Toronto/IBM@IBMCA
cc:   linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject:  Re: [Fwd: sigcontext on Linux-ppc in user space]


Hi,

Here is what I get from running it on my system (ppc linux with 2.2.15
kernel with some mods and glibc-2.1.3).

But no segfault.

Kevin


[kbhend@localhost ~]$ gcc -O2 -ojunk junk.c
[kbhend@localhost ~]$ ./junk
SIGUSR1 = 10
scp = 7fffe9a4
scp->signal = 0
[kbhend@localhost ~]$




On Thursday, January 25, 2001, at 10:09 AM, jekacur@ca.ibm.com wrote:

> #include <stdio.h>
> #include <signal.h>
>
> /* Function Prototypes */
> void install_sigusr1_handler(void);
> void sigusr_handler(int , siginfo_t *, struct sigcontext * scp);
>
> int main(void)
> {
>         install_sigusr1_handler();
>         printf("SIGUSR1 = %d\n", SIGUSR1);
>         raise(SIGUSR1);
>         exit(0);
> }
>
> void install_sigusr1_handler(void)
> {
>         struct sigaction newAct;
>
>         if (sigemptyset(&newAct.sa_mask) != 0) {
>                 fprintf(stderr, "Warning, sigemptyset failed.\n");
>         }
>
>         newAct.sa_flags = 0;
>         newAct.sa_flags |= SA_SIGINFO | SA_RESTART;
>
>         newAct.sa_sigaction = (void
> (*)(int,siginfo_t*,void*))sigusr_handler;
>
>         if (sigaction(SIGUSR1, &newAct, NULL) != 0) {
>                 fprintf(stderr, "Couldn't install SIGUSR1 handler.\n");
>                 fprintf(stderr, "Exiting.\n");
>                 exit(1);
>         }
> }
>
> void sigusr_handler(int signo, siginfo_t *siginfp, struct sigcontext *
scp)
> {
>         printf("scp = %08x\n", scp);
>         printf("scp->signal = %d\n", scp->signal);
> }
>
>




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
