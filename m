Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262340AbTFFW1Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 18:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262362AbTFFW1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 18:27:25 -0400
Received: from wmail.atlantic.net ([209.208.0.84]:43418 "HELO
	wmail.atlantic.net") by vger.kernel.org with SMTP id S262340AbTFFW1Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 18:27:24 -0400
Message-ID: <3EE11B41.80505@techsource.com>
Date: Fri, 06 Jun 2003 18:52:49 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Results of actual compile printk format compression
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a quick note...

Although my experiments with kernel printk format string compression 
have reported estimated shrinkage, this is the first time I have been 
able to compile a whole kernel with the compression filter.

These results come from doing an allyesconfig of 2.5.68 and then weeding 
out anything that didn't build.  One program extracts strings from 
preprocessor output, a second program determines how the strings will be 
encoded, and the third makes substitutions during a kernel compile.

The uncompressed compile resulted in a kernel image of 24011892 bytes. 
The resulting image with format strings compressed is 23904708 bytes 
which is a shrinkage of 107184 bytes.  Subtracting out an estimate of 3K 
for the dictionary and necessary modifications to printk, that results 
in a reduction of something like 104112 which is 4% of the original 
kernel size.

That may not seem like a lot, but if you consider only the printk 
strings themselves, they are compressed to less than 50% of their 
original size (counting the dictionary but not printk code mods).

So, I ask... is this a useful savings?  Is there any chance anyone would 
bother to increase their compile time by a factor of 5 in order to shave 
off 4% or 100k bytes?

(Not to mention that allyesconfig is a very unrealistic scenario.)

