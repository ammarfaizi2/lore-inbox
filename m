Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132542AbRAYSLB>; Thu, 25 Jan 2001 13:11:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132985AbRAYSKw>; Thu, 25 Jan 2001 13:10:52 -0500
Received: from ashley.ivey.uwo.ca ([129.100.22.27]:2577 "EHLO
	ashley.ivey.uwo.ca") by vger.kernel.org with ESMTP
	id <S132542AbRAYSKp> convert rfc822-to-8bit; Thu, 25 Jan 2001 13:10:45 -0500
Message-Id: <200101251810.f0PIAeH04079@ashley.ivey.uwo.ca>
Date: Thu, 25 Jan 2001 13:10:40 -0500
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
Content-Type: text/plain;
	charset=us-ascii
Subject: Re: [Fwd: sigcontext on Linux-ppc in user space]
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
To: jekacur@ca.ibm.com
X-Mailer: Apple Mail (2.337)
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Apple Message framework v337)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is what I get from running it on my system (ppc linux with 2.2.15 kernel with some mods and glibc-2.1.3).

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
> void sigusr_handler(int signo, siginfo_t *siginfp, struct sigcontext * scp) 
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
