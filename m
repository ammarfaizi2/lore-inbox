Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264202AbTEGTFV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 15:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264203AbTEGTFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 15:05:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32472 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264202AbTEGTFT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 15:05:19 -0400
Message-ID: <3EB95BD7.8060700@pobox.com>
Date: Wed, 07 May 2003 15:17:43 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: top stack (l)users for 2.5.69
References: <20030507132024.GB18177@wohnheim.fh-wedel.de> <Pine.LNX.4.53.0305070933450.11740@chaos> <1052332566.752437@palladium.transmeta.com>
In-Reply-To: <1052332566.752437@palladium.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> In article <Pine.LNX.4.53.0305070933450.11740@chaos>,
> Richard B. Johnson <root@chaos.analogic.com> wrote:
> 
>>You know (I hope) that allocating stuff on the stack is not
>>"bad". 
> 
> 
> Allocating stuff on the stack _is_ bad if you allocate more than a few
> hundred bytes. That's _especially_ true deep down in the call-sequence,
> ie in device drivers, low-level filesystems etc.
> 
> The kernel stack is a very limited resource, with no protection from
> overflow. Being lazy and using automatic variables is a BAD BAD thing,
> even if it's syntactically easy and generates good code.


Note that the problem is exacerbated if you have a bunch of disjoint 
stack scopes.  For that case, gcc will take the _sum_ of the stacks and 
not the union.  rth was kind enough to file gcc PR 9997 on this problem.

It is turning out to be fairly common problem in the various drivers' 
ioctl handlers.  Kernel hackers (myself included) often create automatic 
variables for each case in a C switch statement.  (and now I'm having to 
go back and fix that :))

	Jeff



