Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932339AbWJIH5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbWJIH5M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 03:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWJIH5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 03:57:12 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:13460 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932339AbWJIH5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 03:57:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=LRPQaPAUkk1kRAqBD9ijISQq/HhiOziDAUzbbSbKgqFSjj5AZDAl4pXxF124yOw1JrB/3z+KJJgpgzaZRz8hh8FJBVcjlxVaVl2yI7+cDo9NFzDm5qGCJfbcfGCBI6d27FNCPcC3Y0gB+BsvaY9sOhxsUNDW56Donevb/Rm3VU4=
Message-ID: <452A00CC.4080205@gmail.com>
Date: Mon, 09 Oct 2006 16:57:00 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060915)
MIME-Version: 1.0
To: Joe Jin <lkmaillist@gmail.com>
CC: linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: skip reset on bus not a device
References: <215036450609292206pd16c7cxa1c5c77ee52c050e@mail.gmail.com>	 <451E7BD2.7020002@gmail.com>	 <215036450609301849h64551749uf6b4a3e48c57fe15@mail.gmail.com>	 <4529BCC4.8060906@gmail.com>	 <215036450610082354q34b906bdp54a3b9cee52a5855@mail.gmail.com>	 <4529F391.3030504@gmail.com> <20061009070652.GE10832@htj.dyndns.org> <215036450610090044n56ec3a9dg62573a16d63ab00c@mail.gmail.com>
In-Reply-To: <215036450610090044n56ec3a9dg62573a16d63ab00c@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Jin wrote:
>> > It's against libata development tree.  So, you downloaded the tar.gz 
>> and
>> > tested it?
> 
> no, but at latest kernel 2.6.19-rc1 use the same tree as you said, and
> it also can worked

I see.  It's irrelevant anyway.

>> And, one more thing to try.  The following patch should fix your
>> problem.  It's against v2.6.18.
>>
> 
> while applied the patch, error info gone :)
> 
> A question: if the status register return 0xFF means the device not exist?
> why not use ata_devchk()?

Many SATA controllers emulate TF registers and pass devchk even when no 
device is attached.  I don't know whether the two conditions can happen 
together - 0xFF status is usually seen on PATA.  Anyways, it's more 
reliable to test 0xFF.  Also, that's what driver/ide has been doing for 
a long long time and we don't want to deviate from it if possible.

-- 
tejun
