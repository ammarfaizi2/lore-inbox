Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261271AbVBMNBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbVBMNBW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 08:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbVBMNBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 08:01:22 -0500
Received: from smtp6.wanadoo.fr ([193.252.22.25]:36756 "EHLO smtp6.wanadoo.fr")
	by vger.kernel.org with ESMTP id S261268AbVBMNBB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 08:01:01 -0500
X-ME-UUID: 20050213130045858.D1765240012A@mwinf0609.wanadoo.fr
Date: Sun, 13 Feb 2005 14:00:58 +0100
From: Philippe Elie <phil.el@wanadoo.fr>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Oops with oprofile + RT preempt 2.6.11-rc2-RT-V0.7.37-01
Message-ID: <20050213130058.GA566@zaniah>
References: <1108274835.3739.2.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108274835.3739.2.camel@krustophenia.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Feb 2005 at 01:07 +0000, Lee Revell wrote:

> Are there any known incompatibilities with oprofile and the RT preempt patch?
> 
> Lee
> 
> Oops: 0000 [#1]
> PREEMPT 

> alloc
> CPU:    0
> EIP:    0060:[oprofilefs_str_to_user+21/64]    Not tainted VLI
> EFLAGS: 00010246   (2.6.11-rc2-RT-V0.7.37-01) 
> EIP is at oprofilefs_str_to_user+0x15/0x40
> eax: 00000000   ebx: 00000000   ecx: ffffffff   edx: 00000000
> esi: d593b6a0   edi: 00000000   ebp: cb966f6c   esp: cb966f68
> ds: 007b   es: 007b   ss: 0068   preempt: 00000001
> Process cat (pid: 3290, threadinfo=cb966000 task=d083ce10)
> Stack: cb966fa8 cb966f90 c01529ec 00000000 0804d038 00001000 cb966fa8 d593b6a0 
>        fffffff7 0804d038 cb966fbc c0152cc1 d593b6a0 0804d038 00001000 cb966fa8 
>        00000000 00000000 00000000 00000003 00001000 cb966000 c01026a4 00000003 

oprofile_files.c:
 oprofilefs_str_to_user(oprofile_ops.cpu_type, buf, count, offset);

oprofilefs.c:
ssize_t oprofilefs_str_to_user(char const * str, char __user * buf,
	size_t count, loff_t * offset)
{
	return simple_read_from_buffer(buf, count, offset, str, strlen(str));
}

oprofile_ops.cpu_type == NULL, this has been fixed 3 weeks ago,
can you retry with -rc4 ?

Philippe Elie

