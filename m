Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261860AbTCQTA0>; Mon, 17 Mar 2003 14:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261862AbTCQTAZ>; Mon, 17 Mar 2003 14:00:25 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:1003 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S261860AbTCQTAY>;
	Mon, 17 Mar 2003 14:00:24 -0500
Message-ID: <3E761DCA.9080005@colorfullife.com>
Date: Mon, 17 Mar 2003 20:11:06 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jakub Jelinek <jakub@redhat.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Why is get_current() not const function?
Content-Type: multipart/mixed;
 boundary="------------010105050108000803040706"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010105050108000803040706
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Is it possible to use __attribute__((const) with inline functions?
I tried that, but it seems that gcc ignores __attribute__((const) and 
looks at the contents of the function instead.

I've tried the attached test app: With gcc-3.2.1 (gcc -O3), and 
"inlconst" was called 10 times, constfnc only once.

--
    Manfred

--------------010105050108000803040706
Content-Type: text/plain;
 name="consttest.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="consttest.c"

#include <stdio.h>
#include <stdlib.h>

static int constfnc(int x) __attribute__((const));

static inline int inlconst(int x) __attribute__((const));

static void dummy(int i);

static inline int inlconst(int x)
{
	printf("in inlconst.\n");
	return 2;
}

int main(void)
{
	int i;
	for(i=0;i<10;i++) {
		dummy(constfnc(0));
	}
	for (i=0;i<10;i++) {
		dummy(inlconst(0));
	}
}

int constfnc(int x)
{
	printf("in const.\n");
	return 1;
}


void dummy(int i)
{
}


--------------010105050108000803040706--

