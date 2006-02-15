Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422958AbWBOE5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422958AbWBOE5c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 23:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422960AbWBOE5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 23:57:32 -0500
Received: from fmr13.intel.com ([192.55.52.67]:48274 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S1422958AbWBOE5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 23:57:31 -0500
Message-ID: <43F324CD.1020807@linux.intel.com>
Date: Wed, 15 Feb 2006 20:55:41 +0800
From: bibo mao <bibo_mao@linux.intel.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Zhou Yingchao <yingchao.zhou@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Fwd: [PATCH] kretprobe instance recycled by parent process
References: <43F3059A.9070601@linux.intel.com>	 <67029b170602141936v69b85832q@mail.gmail.com> <67029b170602141939v4791ac72l@mail.gmail.com>
In-Reply-To: <67029b170602141939v4791ac72l@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zhou Yingchao wrote:
> 2006/2/15, bibo mao <bibo_mao@linux.intel.com>:
>> When kretprobe probe schedule() function, if probed process exit then
>> schedule() function will never return, so some kretprobe instance will
>> never be recycled. By this patch the parent process will recycle
>> retprobe instance of probed function, there will be no memory leak of
>> kretprobe instance. This patch is based on 2.6.16-rc3.
> 
> Is there any process which can exit without go through the do_exit() path?
> --
When process exits through do_exit() function, it will call schedule() 
function. But if schedule() function is probed by kretprobe, this time 
schedule() function will not return never because process has exited.

bibo,mao
