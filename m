Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272721AbTG1H6t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 03:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272726AbTG1H6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 03:58:49 -0400
Received: from jive.SoftHome.net ([66.54.152.27]:54160 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id S272721AbTG1H6r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 03:58:47 -0400
Message-ID: <3F24DB59.1010600@softhome.net>
Date: Mon, 28 Jul 2003 10:14:17 +0200
From: "Ihar \"Philips\" Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Miles Bader <miles@gnu.org>
CC: Hollis Blanchard <hollisb@us.ibm.com>, Otto Solares <solca@guug.org>,
       "J.A. Magallon" <jamagallon@able.es>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       David McCullough <davidm@snapgear.com>, uclinux-dev@uclinux.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.6 size increase - get_current()?
References: <9CA735B0-BEAD-11D7-BEDE-000A95A0560C@us.ibm.com> <buowue3l4ni.fsf@mcspd15.ucom.lsi.nec.co.jp>
In-Reply-To: <buowue3l4ni.fsf@mcspd15.ucom.lsi.nec.co.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Bader wrote:
> Hollis Blanchard <hollisb@us.ibm.com> writes:
> 
>>Inlines don't always help performance (depending on cache sizes, branch 
>>penalties, frequency of code access...), but they do always increase 
>>code size.
> 
> 
> Um, inlining can often _decrease_ code size because it gives the
> compiler substantial new opportunities for optimization (the function
> body is no longer opaque, so the compiler has a lot more info, and any
> optimizations done on the inlined body can be context-specific).
> 

   starting from -O3 gcc do always trys to do inlining.
   was observed on gcc 3.2 and I beleive I saw the same 2.95.3

   compile this test with 02 & 03:
-------------------
#include <stdio.h>

int aaa() { return 32; }

int main() {
         int b = aaa();
         printf("hello %d \n", b);
         return 0;
}
------------------

    and then objdump -d to see the difference between main()s: 02 - you 
will see function call, 03 - you will see just raw number 0x20 used.

