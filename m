Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262367AbVCVFC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262367AbVCVFC0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 00:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262507AbVCVE6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 23:58:55 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:28536 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262487AbVCVE6G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 23:58:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=uqQCAxIsW8TLf4umZrC9pPPR+QWtsHScEJDFRJrqJdLAINLgQfb9R/C9XqJBTSQepO00b7TtxHXU0VaiIFP0v9o8Ke/wtF2hmfNsaUicUwuCnqogYE6pQqw/W4lvnS85G4aA3JpKLV/qxLiedVtghRkq+LwlBJfbhKYBjWzS5gE=
Message-ID: <423FA59E.5030406@gmail.com>
Date: Tue, 22 Mar 2005 13:57:02 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050118)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dtor_core@ameritech.net
Cc: mochel@digitalimplant.org, James.Bottomley@steeleye.com,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] driver model/scsi: synchronize pm calls with probe/remove
References: <20050321091846.GA25933@htj.dyndns.org> <d120d500050321064028e255fe@mail.gmail.com>
In-Reply-To: <d120d500050321064028e255fe@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, Dmitry.

Dmitry Torokhov wrote:
> On Mon, 21 Mar 2005 18:18:46 +0900, Tejun Heo <htejun@gmail.com> wrote:
> 
>>Hello, Dmitry, Mochel and James.
>>
>>I've been looking at sd code and found seemingly bogus 'if (!sdkp)'
>>tests with /* this can happen */ comment.  I've digged changelog and
>>found out that this was to prevent oops which occurs if some driver
>>gets stuck inside ->probe and the machine goes down and calls back
>>->remove.  IMHO, we should avoid this problem by fixing driver ->probe
>>or ->remove callbacks instead of detecting and bypassing
>>half-initialized/destroyed devices in pm callbacks.
>>
>>This patch read-locks a device's bus using device_pm_down_read_bus()
>>before invoking any pm callback.
> 
> 
> Hi Tejun,
> 
> There are talks about getting rid of bus's rwsem and replacing it with
> a per-device semaphore to serialize probe, remove, suspend and resume.
> This should resolve entire host of problems including this one, if I
> unrerstand it correctly.
> 
> Please take a look here:
> http://seclists.org/lists/linux-kernel/2005/Mar/5847.html
> 

  Yeap, sounds great.  Hmmm.. as the final result will (and should) be 
the same for inidividual drivers (no overlapping callback invocations), 
how about incorporating my patch before implementing the proposed fix 
such that we can get rid of the awkward semantic first?  The proposed 
change should change the same part of code anyway, so I don't think this 
would be a hassle.

  Thanks.

-- 
tejun

