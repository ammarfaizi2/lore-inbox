Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbVJFKNu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbVJFKNu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 06:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbVJFKNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 06:13:50 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:3210 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750801AbVJFKNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 06:13:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=FwYdPQghIPX5EytQaDifI1QDHb6TAj7F+xhD4/DqZDBgFPS1T1hyF16wxDQbVjlJirJHJGz9Rp8p9QKliH1jEedhQB3GyKmORR2JN/72zniHoRZ8MTwPrjeN1pIh42ILHRAcUSVAjvf9WgSWW79hvDegPXODlM7aBzu5/TEmOlI=  ;
Message-ID: <4344F90C.9070001@yahoo.com.au>
Date: Thu, 06 Oct 2005 20:14:36 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: ncunningham@cyclades.com
CC: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Free swap suspend from dependency on PageReserved
References: <1128546263.10363.14.camel@localhost>
In-Reply-To: <1128546263.10363.14.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham wrote:
> From: Nigel Cunningham <nigel@suspend2.net>
> 
> This patch removes the dependency that swap suspend currently has on
> PageReserved. In the places where PageReserved is currently set and
> cleared, we also set and clear PageNosave, and in swap suspend itself,
> we only reference PageNosave. The ongoing effort at freeing PageReserved
> thus achieves another step forward.
> 

Any reason you can't use page_is_ram directly? I would rather you
do this than moving swsusp specific flags out into the wider tree.
The reason is that these flags now become just as hard to kill as
PageReserved is.

You'll have to slightly modify i386's page_is_ram, because it
appears that you'll actually want

   'page_is_ram(pfn) && !(bad_ppro && page_kills_ppro(pfn))'

Thanks, glad someone is looking into this!

Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
