Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964809AbWEJEpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbWEJEpf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 00:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbWEJEpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 00:45:35 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:33044 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964809AbWEJEpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 00:45:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=CUlx8CzvdQon832qjT2AHpqOL31Eqpthd0QmPb+eedGXn1cB+bJYvh8FNmWJyMySqvC4Twi6dOpLExiXsvMNo004KG5ngxyCCNRQxHlZ4ohf9ZDdvEZlN4AwmCXQP8Ze3aTb1GLBmqUssMLAim0ZF+65i9s66z3LD4PKonR+SWc=
Message-ID: <44616FE7.1080306@gmail.com>
Date: Wed, 10 May 2006 13:45:27 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: Daniel Walker <dwalker@mvista.com>
CC: akpm@osdl.org, jeremy@sgi.com, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] sata_vsc gcc 4.1 warning fix
References: <200605100256.k4A2u6Hu031761@dwalker1.mvista.com>	 <44616A1C.20800@gmail.com> <1147235880.21536.53.camel@c-67-180-134-207.hsd1.ca.comcast.net>
In-Reply-To: <1147235880.21536.53.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Walker wrote:
> On Wed, 2006-05-10 at 13:20 +0900, Tejun Heo wrote:
>> Daniel Walker wrote:
>>> Fixes the following warning,
>>>
>>> drivers/scsi/sata_vsc.c:152: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
>>> drivers/scsi/sata_vsc.c:153: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
>>> drivers/scsi/sata_vsc.c:154: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
>>> drivers/scsi/sata_vsc.c:155: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
>>> drivers/scsi/sata_vsc.c:156: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
>>> drivers/scsi/sata_vsc.c:158: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
>>> drivers/scsi/sata_vsc.c:159: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
>>> drivers/scsi/sata_vsc.c:160: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
>>> drivers/scsi/sata_vsc.c:161: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
>>> drivers/scsi/sata_vsc.c:162: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
>>> drivers/scsi/sata_vsc.c:166: warning: passing argument 2 of 'writeb' makes pointer from integer without a cast
>>> drivers/scsi/sata_vsc.c: In function 'vsc_sata_tf_read':
>>> drivers/scsi/sata_vsc.c:178: warning: passing argument 1 of 'readw' makes pointer from integer without a cast
>>> drivers/scsi/sata_vsc.c:179: warning: passing argument 1 of 'readw' makes pointer from integer without a cast
>>> drivers/scsi/sata_vsc.c:180: warning: passing argument 1 of 'readw' makes pointer from integer without a cast
>>> drivers/scsi/sata_vsc.c:181: warning: passing argument 1 of 'readw' makes pointer from integer without a cast
>>> drivers/scsi/sata_vsc.c:182: warning: passing argument 1 of 'readw' makes pointer from integer without a cast
>>> drivers/scsi/sata_vsc.c:183: warning: passing argument 1 of 'readw' makes pointer from integer without a cast
>>> drivers/scsi/sata_vsc.c: In function 'vsc_sata_setup_port':
>>> drivers/scsi/sata_vsc.c:320: warning: passing argument 2 of 'writel' makes pointer from integer without a cast
>>> drivers/scsi/sata_vsc.c:321: warning: passing argument 2 of 'writel' makes pointer from integer without a cast
>>>
>>> Signed-Off-By: Daniel Walker <dwalker@mvista.com>
>>>
>> Hello, Daniel.
>>
>> This fix comes up every so often and I have submitted almost identical 
>> patch several months ago.  Unfortunately, it's not the proper fix and 
>> won't be accepted.  All those read/writeX()'s and in/outX()'s are 
>> scheduled (for a looooong time) to be converted to new unified 
>> ioread/writeX()'s.  Things are in progress (well, or halt) in the #iomap 
>> branch of libata-dev devel tree.  libata needs some updates in host 
>> initialization part for this conversion to complete.
> 
> I guess subconsciously I knew as much, but I've seen warning like these
> during compiles for a very very very long time .. Considering how
> trivial it is to silence them I don't see why it shouldn't be accepted .
> The "right" fix should have arrived by now ..
> 

Well, it was Jeff's (the maintainer) call.  The warning messages bug me
too but I sort of understand Jeff's decision as the bugging actually
reminds me of the problem every time I build libata.  Well, let's hope
iomap gets completed in not too distant future

Thanks.

-- 
tejun
