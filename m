Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264767AbUGGAHL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264767AbUGGAHL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 20:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264774AbUGGAHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 20:07:11 -0400
Received: from web41112.mail.yahoo.com ([66.218.93.28]:33929 "HELO
	web41112.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264767AbUGGAGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 20:06:12 -0400
Message-ID: <20040707000612.39528.qmail@web41112.mail.yahoo.com>
Date: Tue, 6 Jul 2004 17:06:12 -0700 (PDT)
From: tom st denis <tomstdenis@yahoo.com>
Subject: Re: 0xdeadbeef vs 0xdeadbeefL
To: linux-kernel@vger.kernel.org
In-Reply-To: <20040706215622.GA9505@havoc.gtf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- David Eger <eger@havoc.gtf.org> wrote:
> Is there a reason to add the 'L' to such a 32-bit constant like this?
> There doesn't seem a great rhyme to it in the headers...

IIRC it should have the L [probably UL instead] since numerical
constants are of type ``int'' by default.  

Normally this isn't a problem since int == long on most platforms that
run Linux.  However, by the standard 0xdeadbeef is not a valid unsigned
long constant.

Consider the following...

#include <stdio.h>
int main(void)
{
  unsigned int x;
  x = 4;
  if (x < 0xdeadbeef) printf("hello");
  return 0;
}

If you run splint on that you get 

---
Splint 3.1.1 --- 13 Jun 2004

test2.c: (in function main)
test2.c:7:7: Operands of < have incompatible types (unsigned int, int):
                x < 0xdeadbeef
  To ignore signs in type comparisons use +ignoresigns

Finished checking --- 1 code warning
---

As far as I know splint follows C99 which means that it thinks the
constant is "int".  

Tom


	
		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - 100MB free storage!
http://promotions.yahoo.com/new_mail 
