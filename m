Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261949AbVAYOJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261949AbVAYOJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 09:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbVAYOIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 09:08:49 -0500
Received: from asplinux.ru ([195.133.213.194]:60423 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id S261949AbVAYOIH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 09:08:07 -0500
Message-ID: <41F653BC.20809@sw.ru>
Date: Tue, 25 Jan 2005 17:12:12 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: "Seth, Rohit" <rohit.seth@intel.com>
CC: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Andrey Savochkin <saw@sawoct.com>, linux-kernel@vger.kernel.org
Subject: Re: possible CPU bug and request for Intel contacts
References: <01EF044AAEE12F4BAAD955CB7506494302E61BA0@scsmsx401.amr.corp.intel.com>
In-Reply-To: <01EF044AAEE12F4BAAD955CB7506494302E61BA0@scsmsx401.amr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rohit,

>>BTW, can you explain why making pages non-global is the cure? Is it
>> safe workaround for this bug?
> There is a boundary condition that can have non-global pages containing
> the CR3 load to also hit this issue on affected PIII.  Though for this
> to happen, mov to cr3 has to be the very last instruction on a page.
> And the page following that page (containing CR3 load) has to have
> different mapping between user and kernel spaces.
but in our case "mov %edx, %cr3" is not the last instruction on a page. 
It is in the middle of it.
Well, another remark is that after cr3 load there are only few 
instructions before the "call system_call_table(%edx)" which references 
the page with different user and kernel mappings.

also, this bug can be cured via inserting about 20 simple operations 
between cr3 load and call to the page with overlapping mappings.

I'm just trying to understand is it the bug referenced in E80 or not and 
is it safe to use non-global mappings as a cure.

Kirill

