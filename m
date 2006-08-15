Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbWHOXmL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbWHOXmL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 19:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbWHOXmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 19:42:11 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:25813
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1750807AbWHOXmK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 19:42:10 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Maximum number of processes in Linux
Date: Wed, 16 Aug 2006 01:39:16 +0200
User-Agent: KMail/1.9.1
References: <fa.evUDdOgjejpeNWKvgan3aKFF880@ifi.uio.no> <44E254E4.6090508@shaw.ca>
In-Reply-To: <44E254E4.6090508@shaw.ca>
Cc: linux-kernel@vger.kernel.org, Irfan Habib <irfan.habib@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608160139.17019.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 August 2006 01:12, Robert Hancock wrote:
> Irfan Habib wrote:
> > Hi,
> > 
> > What is the maximum number of process which can run simultaneously in
> > linux? I need to create an application which requires 40,000 threads.
> > I was testing with far fewer numbers than that, I was getting
> > exceptions in pthread_create
> 
> What architecture is this? On a 32-bit architecture with a 2MB stack 
> size (which I think is the default) you couldn't possibly create more 
> than 2048 threads just because of stack space requirements. Reducing the 
> stack size would get you more.

Hm, I'm on a 4way PPC64 machine with 2.5G RAM.
It can only create 509 pthreads and fails with ENOMEM
on the 510th.
That's not a really big machine, but I expected it to be able
to create somewhere around 8000 threads or so, at least. Especially
as it has a 64bit kernel and lots of memory.

Well...

That's my test app:

#include <stdio.h>
#include <pthread.h>
#include <string.h>
#include <errno.h>


static void * thread(void *arg)
{
        while (1)
                sleep(10);
}

int main(void)
{
        int err = 0;
        unsigned long i = 0;
        pthread_t t;

        while (!err) {
                err = pthread_create(&t, NULL, thread, NULL);
                i++;
                if (err) {
                        printf("Creating pthread %lu failed with \"%s\"\n",
                                i, strerror(errno));
                        break;
                }
                printf("%lu pthreads created\n", i);
        }

        return 0;
}

-- 
Greetings Michael.
