Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264372AbUASGKU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 01:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264374AbUASGKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 01:10:20 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:43677 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264372AbUASGKP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 01:10:15 -0500
Message-ID: <400B7539.8080901@in.ibm.com>
Date: Mon, 19 Jan 2004 11:42:09 +0530
From: Prashanth T <prasht@in.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: rml@tech9.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rwlock_is_locked undefined for UP systems
References: <4007EAE7.2030104@in.ibm.com> <20040116140933.C24102@infradead.org>
In-Reply-To: <20040116140933.C24102@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ok....I understand that rwlock_is_locked( ) is to be protected by
CONFIG_SMP.  But I was tempted when I saw spin_is_locked( )
to be returning zero for !SMP in include/linux/spinlock.h . 
Am I seeing something wrong here?

Christoph Hellwig wrote:

>On Fri, Jan 16, 2004 at 07:15:11PM +0530, Prashanth T wrote:
>  
>
>>Hi,
>>    I had to use rwlock_is_locked( ) with linux2.6 for kdb and noticed that
>>this routine to be undefined for UP.  I have attached the patch for 2.6.1
>>below to return 0 for rwlock_is_locked( ) on UP systems.
>>Please let me know.
>>    
>>
>
>we don't implement spin_is_locked on UP either because there's no really
>usefull return value.  The lock will never be taken on !SMP && !PREEMPT,
>but OTOH it's also not needed, so any assert on will give false results.
>And the assert is probably the only thing that the _is_locked routines
>could used for sanely.
>
>
>  
>

