Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291414AbSBHOoK>; Fri, 8 Feb 2002 09:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291580AbSBHOoA>; Fri, 8 Feb 2002 09:44:00 -0500
Received: from jalon.able.es ([212.97.163.2]:1019 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S291414AbSBHOnk>;
	Fri, 8 Feb 2002 09:43:40 -0500
Date: Fri, 8 Feb 2002 15:43:32 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Felipe Contreras <al593181@mail.mty.itesm.mx>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Weird bug in linux, glibc, gcc or what?
Message-ID: <20020208154332.A3336@werewolf.able.es>
In-Reply-To: <20020207135749.GA4545@sion.mty.itesm.mx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20020207135749.GA4545@sion.mty.itesm.mx>; from al593181@mail.mty.itesm.mx on jue, feb 07, 2002 at 14:57:49 +0100
X-Mailer: Balsa 1.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20020207 Felipe Contreras wrote:
>Hi,
>
>I've found a weird problem in linuxthreads. When I get out of a thread it
>happends one of three, the new thread get's defuct and the proccess never
>ends, it segfaults, or it works.
>
>The most weird is that it depends on the kernel, and also when I run the
>test trought gdb there is no problem.
>
>Here is the test:
>
>#include <pthread.h>
>
>void *test(void *arg) {
>	puts("Thread2");
>	return 0;
>}
>
>int main() {
>	pthread_t tt;
>	puts("Before Thread2");
>	pthread_create(&tt,NULL,test,NULL);
>	puts("After Thread2");
>	return 0;
>}
>

Buggy program that could give unspecified behaviour, unless pthread
standard talks about orphaned threads...

Your main program can die (exit) before child thread ends, so it has
nobody to notify its dying or return to.

Try with a sleep(1) before main return, or better, do a
pthread_join().

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.18-pre9-slb #3 SMP Fri Feb 8 01:33:12 CET 2002 i686
