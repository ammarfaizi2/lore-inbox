Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291261AbSBGUME>; Thu, 7 Feb 2002 15:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291263AbSBGUL5>; Thu, 7 Feb 2002 15:11:57 -0500
Received: from webmail.mty.itesm.mx ([131.178.2.83]:32288 "EHLO
	webmail.mty.itesm.mx") by vger.kernel.org with ESMTP
	id <S291262AbSBGULj>; Thu, 7 Feb 2002 15:11:39 -0500
Date: Thu, 7 Feb 2002 13:57:49 +0000
From: Felipe Contreras <al593181@mail.mty.itesm.mx>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Weird bug in linux, glibc, gcc or what?
Message-ID: <20020207135749.GA4545@sion.mty.itesm.mx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've found a weird problem in linuxthreads. When I get out of a thread it
happends one of three, the new thread get's defuct and the proccess never
ends, it segfaults, or it works.

The most weird is that it depends on the kernel, and also when I run the
test trought gdb there is no problem.

Here is the test:

#include <pthread.h>

void *test(void *arg) {
	puts("Thread2");
	return 0;
}

int main() {
	pthread_t tt;
	puts("Before Thread2");
	pthread_create(&tt,NULL,test,NULL);
	puts("After Thread2");
	return 0;
}

The output:

1:src# ./test
Before Thread2
After Thread2
Thread2

This time it just kept waiting:

 8957 vc/1     00:00:00 test
 8958 ?        00:00:00 test <defunct>

I run it again:

1:src# ./test
Before Thread2
After Thread2

And again:

1:src# ./test
Before Thread2
Thread2
Segmentation fault

Now with gdb-5.1.1:

Starting program: /usr/src/./test
(no debugging symbols found)...[New Thread 1024 (LWP 9168)]
Before Thread2
[New Thread 2049 (LWP 9169)]
[New Thread 1026 (LWP 9170)]
Thread2
After Thread2

Program exited normally.

As I said the results vary from system to system, here are some
convinations:

* linux-2.4.10+glibc+2.2.4+gcc-2.95.3: Runs fine, but once in a while it
	keeps waiting for the defunct thread.

* linux-2.4.17+glibc+2.2.4+gcc-2.95.3: The same, but the defunct problem
	happends much more often.

* linux-2.4.10+glibc+2.2.5+gcc-3.0.3: Segfaults or waits for defuncts.

* linux-2.4.17+glibc+2.2.5+gcc-3.0.3: The same.

I'm lost on this, I supose it's a convination of glibc-linux problem.

Any ideas?

-- 
Felipe Contreras
