Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266810AbUF3TAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266810AbUF3TAP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 15:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266812AbUF3TAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 15:00:14 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:22494 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S266810AbUF3TAH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 15:00:07 -0400
Message-ID: <40E30E50.3040401@austin.ibm.com>
Date: Wed, 30 Jun 2004 14:02:40 -0500
From: Olof Johansson <olof@austin.ibm.com>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040605)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: linas@austin.ibm.com, paulus@au1.ibm.com,
       Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev <linuxppc64-dev@lists.linuxppc.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PPC64: lockfix for rtas error log
References: <20040629175007.P21634@forte.austin.ibm.com>	 <1088559864.1906.9.camel@gaston>	 <20040630123637.S21634@forte.austin.ibm.com> <1088621248.1920.43.camel@gaston>
In-Reply-To: <1088621248.1920.43.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
>> So instead, the problem can be easily
>>avoided by not using a global buffer.  The code below mallocs/frees.
>>Its not perf-critcal, so I don't mind malloc overhead.  Would this
>>work for you?  Patch attached below.
> 
> 
> I prefer that, but couldn't we move the kmalloc outside of the spinlock
> and so use GFP_KERNEL instead ?

Isn't the global buffer used since it's in BSS, and as such, in low 
memory, guaranteed to be below 4GB? RTAS has limitations that restricts 
any passed-in buffers to be addressable as 32-bit real mode pointers, right?


-Olof
