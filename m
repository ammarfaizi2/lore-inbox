Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263802AbUESGEt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263802AbUESGEt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 02:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263806AbUESGEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 02:04:49 -0400
Received: from web50201.mail.yahoo.com ([206.190.38.42]:7259 "HELO
	web50201.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263802AbUESGEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 02:04:47 -0400
Message-ID: <20040519054507.63816.qmail@web50201.mail.yahoo.com>
Date: Tue, 18 May 2004 22:45:07 -0700 (PDT)
From: Alex Davis <alex14641@yahoo.com>
Subject: signal handling issue.
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There appears to be a change between linux 2.4 and 2.6
in how signals are handled. As a test, I wrote the program
below:

#include <stdio.h>
#include <signal.h>
#include <setjmp.h>

static jmp_buf env;

static void handler(int s) {
        printf("caught signal %d\n", s);
        longjmp(env, 1);
}

int main() {
        int * p = 0;

        printf("write\n");
        signal(SIGSEGV, handler);
        if ( ! setjmp(env) )
        {
                *p = 0;
        }

        printf("read\n");
        signal(SIGSEGV, handler);
        if ( ! setjmp(env) )
        {
                int a = *p;
        }
        return 0;
}

When run on 2.4.26, the program prints:

write
caught signal 11
read
caught signal 11


Which (I think) is expected, but when run on 2.6.5,
the program prints:

write
caught signal 11
read
Segmentation fault

It's as if the second call to signal is being ignored.
Is this a bug or a feature?

-Alex



=====
I code, therefore I am


	
		
__________________________________
Do you Yahoo!?
SBC Yahoo! - Internet access at a great low price.
http://promo.yahoo.com/sbc/
