Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316678AbSGBImj>; Tue, 2 Jul 2002 04:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316679AbSGBImi>; Tue, 2 Jul 2002 04:42:38 -0400
Received: from holomorphy.com ([66.224.33.161]:30947 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316678AbSGBImh>;
	Tue, 2 Jul 2002 04:42:37 -0400
Date: Tue, 2 Jul 2002 01:44:18 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Erik Andersen <andersen@codepoet.org>, Timo Benk <t_benk@web.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: allocate memory in userspace
Message-ID: <20020702084418.GR22961@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Erik Andersen <andersen@codepoet.org>, Timo Benk <t_benk@web.de>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20020701172659.GA4431@toshiba> <20020701174913.GA19338@codepoet.org> <20020702083737.GQ22961@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020702083737.GQ22961@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2002 at 11:49:13AM -0600, Erik Andersen wrote:
>> void *malloc(size_t size)
>> {
>>     void *result;
>>     if (size == 0)
>> 	return NULL;
>>     result = mmap((void *) 0, size + sizeof(size_t), PROT_READ | PROT_WRITE, 
>> 	    MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
>>     if (result == MAP_FAILED)
>> 	return 0;
>>     * (size_t *) result = size;
>>     return(result + sizeof(size_t));
>> }

On Tue, Jul 02, 2002 at 01:37:37AM -0700, William Lee Irwin III wrote:
> This looks like a very bad idea. Userspace allocators should make some
> attempt at avoiding diving into the kernel at every allocation like this.

Sorry, I also forgot the rather severe internal fragmentation this is
likely to suffer due to page-level restrictions on mmap's operation.

Cheers,
Bill
