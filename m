Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262538AbUDTKyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbUDTKyL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 06:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbUDTKyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 06:54:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17377 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262538AbUDTKyG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 06:54:06 -0400
Message-ID: <40850143.1090709@redhat.com>
Date: Tue, 20 Apr 2004 00:53:55 -1000
From: Warren Togami <wtogami@redhat.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040418)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Markus Lidel <Markus.Lidel@shadowconnect.com>,
       Arjan van de Ven <arjanv@redhat.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>
Subject: Re: [PATCH] i2o_block Fix, possible CFQ elevator problem?
References: <4083BA03.1090606@redhat.com> <20040419121225.GT1966@suse.de> <408471E2.8060201@redhat.com> <40848159.7090605@togami.com> <20040420070805.GC25806@suse.de> <4084D83D.8060405@redhat.com> <20040420080325.GD25806@suse.de> <4084E671.4090509@redhat.com> <20040420090523.GE25806@suse.de>
In-Reply-To: <20040420090523.GE25806@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
>>>Not necessarily, it's most likely a CFQ bug. Otherwise it would have
>>>surfaced before :-)
>>>
>>
>>I forgot to mention in the previous reports:
>>
>>Prior to three of your original suggested cleanups of i2o_block, four 
>>simultaneous bonnie++'s on four independent arrays would almost 
>>immediately cause the crash while running elevator=cfq.  After those 
>>three cleanups four simultaneous bonnie++ would survive for a while 
>>without crashing... until you run "sync" in another terminal.  We 
>>however did not test it enough times to determine if without "sync" it 
>>can survive the test run.  Do you want this tested without "sync"?
> 
> 
> Repeat the tests that made it crash. The last patch I sent should work
> for you, at least until the real issue is found.
> 

Tested your patch, it indeed does seem to keep the system stable.  If I 
am understanding it right, the patch disables merging in the case where 
it would have caused a BUG condition?  (Less efficiency.)

In any case, for now we are doing our i2o development using the other 
schedulers like deadline.  Let us know if you have updated cfq patches 
to try, and we will.

Warren Togami
wtogami@redhat.com
