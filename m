Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262831AbUBZSCf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 13:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262845AbUBZSCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 13:02:35 -0500
Received: from terminus.zytor.com ([63.209.29.3]:49896 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S262831AbUBZSCd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 13:02:33 -0500
Message-ID: <403E34B1.3030608@zytor.com>
Date: Thu, 26 Feb 2004 10:02:25 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20040105
X-Accept-Language: en, sv, es, fr
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Early memory patch, +accounting
References: <403ADCDD.8080206@zytor.com>	<m1r7wjf22s.fsf@ebiederm.dsl.xmission.com>	<403CEE33.3020601@zytor.com> <m1oerlevny.fsf_-_@ebiederm.dsl.xmission.com>
In-Reply-To: <m1oerlevny.fsf_-_@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> 
> I intend to export _end into setup.S so a bootloader can
> tell what memory the kernel will attempt to use before looking at
> the e820 map, the kernel command line, and the initrd location.
> After that the kernel can properly dynamically allocate things.
> 

You're confusing "may" with "will".  This is the fundamental problem 
with this approach.

> Exporting _end will allow two things.
> 1) On systems with a 15M-16M I/O hole the bootloader can check to see
>    if a big kernel will attempt to use memory in that region.
> 
> 2) On small memory systems it will let the bootloader make a good
>    estimate to see if everything will fit into memory.

No, it won't, because it still has no idea whatsoever how much 
dynamically allocated memory it needs during boot.

	-hpa
