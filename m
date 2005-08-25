Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964968AbVHYNHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964968AbVHYNHi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 09:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964970AbVHYNHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 09:07:38 -0400
Received: from mail.intersys.com ([198.133.74.1]:59403 "EHLO
	mail.intersystems.com") by vger.kernel.org with ESMTP
	id S964968AbVHYNHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 09:07:37 -0400
Message-ID: <430DC285.7070104@intersystems.com>
Date: Thu, 25 Aug 2005 09:07:17 -0400
From: Ray Fucillo <fucillo@intersystems.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: process creation time increases linearly with shmem
References: <430CBFD1.7020101@intersystems.com> <430D0D6B.100@yahoo.com.au>
In-Reply-To: <430D0D6B.100@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> fork() can be changed so as not to set up page tables for
> MAP_SHARED mappings. I think that has other tradeoffs like
> initially causing several unavoidable faults reading
> libraries and program text.
> 
> What kind of application are you using?

The application is a database system called Caché.  We allocate a large 
shared memory segment for database cache, which in a large production 
environment may realistically be 1+GB on 32-bit platforms and much 
larger on 64-bit.  At these sizes fork() is taking hundreds of 
miliseconds, which can become a noticeable bottleneck for us.  This 
performance characteristic seems to be unique to Linux vs other Unix 
implementations.

