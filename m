Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267829AbUJGSxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267829AbUJGSxq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 14:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267831AbUJGSuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 14:50:54 -0400
Received: from fmr04.intel.com ([143.183.121.6]:16546 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S267806AbUJGStZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 14:49:25 -0400
Message-ID: <41658FB4.5090402@intel.com>
Date: Thu, 07 Oct 2004 11:49:24 -0700
From: Arun Sharma <arun.sharma@intel.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kill a sparse warning in binfmt_elf.c
References: <4164756E.4010408@intel.com> <200410071811.i97IBQf0031262@turing-police.cc.vt.edu>
In-Reply-To: <200410071811.i97IBQf0031262@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/2004 11:11 AM, Valdis.Kletnieks@vt.edu wrote:
> On Wed, 06 Oct 2004 15:45:02 PDT, Arun Sharma said:
> 
>> The attached patch kills a sparse warning in binfmt_elf.c:dump_write() by
>> adding a __user annotation.
> 
>>  static int dump_write(struct file *file, const void *addr, int nr)
>>  {
>> -	return file->f_op->write(file, addr, nr, &file->f_pos) == nr;
>> +	return file->f_op->write(file, (const char __user *) addr, nr, &file->f_pos) == nr;
>>  }
> 
> wouldn't it be more useful to put the annotation into the *prototype* for
> the dump_write() function, so that we get sparse typechecking for the
> caller(s) of this function?  Your fix just kills the warning - when the *real*
> problem is that we're called with a 'void *' that we then cast to something
> without any real double check on what it is....

dump_write() is a static function without a prototype.

	-Arun

