Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264198AbTFKHhs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 03:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264201AbTFKHhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 03:37:48 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:45062 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S264198AbTFKHhr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 03:37:47 -0400
Message-ID: <3EE6E0B6.1060800@aitel.hist.no>
Date: Wed, 11 Jun 2003 09:56:38 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: Simon Fowler <simon@himi.org>
CC: Andrew Morton <akpm@digeo.com>, jsimmons@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.70-bk radeonfb oops on boot.
References: <20030610061654.GB25390@himi.org> <20030610130204.GC27768@himi.org> <20030610141440.26fad221.akpm@digeo.com> <20030611021926.GA2241@himi.org> <20030610201641.220a4927.akpm@digeo.com> <20030611035525.GB2852@himi.org> <20030610211607.2bb55b41.akpm@digeo.com> <20030611050540.GD2852@himi.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon Fowler wrote:
> On Tue, Jun 10, 2003 at 09:16:07PM -0700, Andrew Morton wrote:
> 
>>Simon Fowler <simon@himi.org> wrote:
>>
>>>>>>It might be worth reverting this chunk, see if that fixes it:
>>>>>>
>>>>>>--- b/drivers/char/mem.c        Thu Jun  5 23:36:40 2003
>>>>>>+++ b/drivers/char/mem.c        Sun Jun  8 05:02:24 2003
>>>>>>@@ -716 +716 @@
>>>>>>-__initcall(chr_dev_init);
>>>>>>+subsys_initcall(chr_dev_init);
>>>>>>
>>>>>
>>>>>And we have a winner . . . Reverting this hunk fixes the oops.
>>>>>
>>>>
> <snippage> 
> 
>>Thanks for testing.
>>
>>All the initcall ordering of chardevs versus pci, pci versus pci and who
>>knows what else is all bollixed up.
>>
>>Unfortunately I do not have the bandwidth to work on this.
> 
> 
> Since this seems to be a showstopper for people using radeonfb,
> getting the 'fix' above in might be a good idea . . .


It isn't merely radeonfb.  A machine with matroxfb dies
the same death, pci_enable_device_bars() oopses
before the framebuffer even comes up
with 2.5.70-mm7.

Helge Hafting


