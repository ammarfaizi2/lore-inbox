Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263226AbUDGONl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 10:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263665AbUDGONl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 10:13:41 -0400
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:21424 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263226AbUDGONk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 10:13:40 -0400
Message-ID: <40740C90.3060005@yahoo.com.au>
Date: Thu, 08 Apr 2004 00:13:36 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: vda@port.imtp.ilyichevsk.odessa.ua, colpatch@us.ibm.com,
       wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: [Patch 17/23] mask v2 = [6/7] nodemask_t_ia64_changes
References: <20040401122802.23521599.pj@sgi.com>	<20040401131240.00f7d74d.pj@sgi.com>	<20040406043732.6fb2df9f.pj@sgi.com>	<200404070855.03742.vda@port.imtp.ilyichevsk.odessa.ua>	<20040406235000.6c06af9a.pj@sgi.com> <20040407004437.3a078f28.pj@sgi.com>
In-Reply-To: <20040407004437.3a078f28.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Several architectures have this large version of find_next_bit() code.
> 
> It may well make sense for the O(1) scheduler to be inlining this.
> 

No, the schedule() fastpath doesn't use find_next_bit. That is
only used to traverse the runqueues when moving tasks from one
to another. No problem uninlining it there.

If the function is more than a cacheline or two big, you'll
probably get better performance through better cache utilisation
anyway, and you'll be able to use a slightly larger, faster
version if you have one, which is probably a good thing.

Unless there is something specific that I'm not aware of?
