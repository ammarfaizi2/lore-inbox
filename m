Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751291AbVIRDq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbVIRDq0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 23:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbVIRDq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 23:46:26 -0400
Received: from smtpout.mac.com ([17.250.248.70]:56818 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751291AbVIRDqZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 23:46:25 -0400
In-Reply-To: <200509172231.33872.dhazelton@enter.net>
References: <4N6EL-4Hq-3@gated-at.bofh.it> <200509170028.59973.dhazelton@enter.net> <432BB77E.3050501@v.loewis.de> <200509172231.33872.dhazelton@enter.net>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3FEE1455-90E8-4855-9BA4-045A6EE5D82B@mac.com>
Cc: =?ISO-8859-1?Q? "Martin_v._L=F6wis" ?= <martin@v.loewis.de>,
       7eggert@gmx.de, "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [Patch] Support UTF-8 scripts
Date: Sat, 17 Sep 2005 23:45:56 -0400
To: "D. Hazelton" <dhazelton@enter.net>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 17, 2005, at 18:31:33, D. Hazelton wrote:
> That, and my point remains that the kernel should know absolutely  
> nothing about how to execute a text file - the kernel should return  
> an error to the extent of "I don't know what to do with this file"  
> to the shell that tries to execute it, and the shell can then check  
> for the sh_bang. I do admit that this change would break a lot of  
> existing code, so I'll leave the argument to the experts.

No, that would not work at all.  We have a very nice system to allow  
set-uid scripts (Specifically, I like my nice secure taint-mode set- 
uid perl scripts).  If you did this, they would break completely, not  
to mention _add_ all sorts of unsolvable race conditions to the few  
ways of working around such a lack of SUID scripts.  Also, it means  
that I can't just "mv /sbin/init /sbin/init.real ; vim /sbin/init" to  
do a simple wrapper around the init program, I would need to write a  
compiled C program to do all sorts of fragile hackish things like  
calling a script /sbin/init.sh.

Cheers,
Kyle Moffett

--
There are two ways of constructing a software design. One way is to  
make it so simple that there are obviously no deficiencies. And the  
other way is to make it so complicated that there are no obvious  
deficiencies.  The first method is far more difficult.
   -- C.A.R. Hoare


