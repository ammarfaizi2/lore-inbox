Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263231AbUEaKmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263231AbUEaKmH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 06:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263295AbUEaKmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 06:42:07 -0400
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:11648 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263231AbUEaKmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 06:42:05 -0400
Message-ID: <40BB0BF8.4040108@yahoo.com.au>
Date: Mon, 31 May 2004 20:42:00 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Pavel Machek <pavel@suse.cz>, ncunningham@linuxmail.org,
       cef-lkml@optusnet.com.au, linux-kernel@vger.kernel.org, rob@landley.net,
       seife@suse.de
Subject: Re: swappiness=0 makes software suspend fail.
References: <200405280000.56742.rob@landley.net>	<20040528215642.GA927@elf.ucw.cz>	<200405291905.20925.cef-lkml@optusnet.com.au>	<40B85024.2040505@linuxmail.org>	<20040529222308.GA1535@elf.ucw.cz> <20040531030914.0e20d2e0.akpm@osdl.org>
In-Reply-To: <20040531030914.0e20d2e0.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Pavel Machek <pavel@suse.cz> wrote:
> 
>>Right solution is to make sure that shrink_all_memory() works, no
>> matter how swappiness is set.
> 
> 
> off-by-one in balance_pgdat() was the main problem.
> 

I think it might be intentional, because 1/2 + 1/4 + ... + 1/4096 ~ 1.

If so, it instead needs fixing in try_to_free_pages, and a comment.
