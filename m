Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268134AbUJHBg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268134AbUJHBg6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 21:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269870AbUJHBck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 21:32:40 -0400
Received: from fmr04.intel.com ([143.183.121.6]:62185 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S269715AbUJGWHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 18:07:08 -0400
Message-ID: <4165BE08.8060600@intel.com>
Date: Thu, 07 Oct 2004 15:07:04 -0700
From: Arun Sharma <arun.sharma@intel.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kill a sparse warning in binfmt_elf.c
References: <4164756E.4010408@intel.com> <200410071811.i97IBQf0031262@turing-police.cc.vt.edu> <41658FB4.5090402@intel.com> <200410071854.i97IsvU5031703@turing-police.cc.vt.edu>            <4165927F.5040606@intel.com> <200410071916.i97JGmft018659@turing-police.cc.vt.edu>
In-Reply-To: <200410071916.i97JGmft018659@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/2004 12:16 PM, Valdis.Kletnieks@vt.edu wrote:

> Hmm.. there it's a 'const char *name', but we feed it to a 'const void *'
> and then you cast it to a __user. 

I'm not very concerned about const char * being cast to const void *. That's not the focus of the patch[1]. The focus of the patch is really __user.

> Either that *name should be __user
> as well, or you tagged something as a __user that might not be.
>

Certain interfaces such as get_user() will fail if you pass a kernel pointer and unconditionally cast it to __user (without doing a set_fs(KERNEL_DS)). But file_operations->write() is not one of them and hence the patch.

	-Arun

[1] If you insist on this, you should change all the calls to memcpy() as well.
