Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422867AbWJOHyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422867AbWJOHyx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 03:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422866AbWJOHyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 03:54:53 -0400
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:14462 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1422867AbWJOHyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 03:54:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=TGrtJVKYbdO8Y+/bcRkeo5xwNHtB1HT+Y34AP8BBUOdVC2tdaKuoIetUKCfTahHp5jf0uHK+Avfv1qLLGMyB3Xls0K4bYaFtDMbbj2yA/snjqRGyCUKQYLGP534tBc7ASbqFkK8oOPSl1m/gsojDWkWXxokwnvrz7TiQu3Eqkrs=  ;
Message-ID: <4531E946.5070503@yahoo.com.au>
Date: Sun, 15 Oct 2006 17:54:46 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Oeser <ioe-lkml@rameria.de>
CC: Nick Piggin <npiggin@suse.de>, Carsten Otte <cotte.de@gmail.com>,
       Linux Memory Management <linux-mm@kvack.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 3/3] mm: fault handler to replace nopage and populate
References: <20061007105758.14024.70048.sendpatchset@linux.site> <5c77e7070610120456t1bdaa95cre611080c9c953582@mail.gmail.com> <20061012120735.GA20191@wotan.suse.de> <200610141528.50542.ioe-lkml@rameria.de>
In-Reply-To: <200610141528.50542.ioe-lkml@rameria.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

Ingo Oeser wrote:
> Hi Nick,
> 
> On Thursday, 12. October 2006 14:07, Nick Piggin wrote:
> 
>>Actually, filemap_xip needs some attention I think... if xip files
>>can be truncated or invalidated (I assume they can), then we need to
>>lock the page, validate that it is the correct one and not truncated,
>>and return with it locked.
> 
> 
> ???
> 
> Isn't XIP for "eXecuting In Place" from ROM or FLASH?

Yes, I assume so. It seems that it isn't restricted to executing, but
is basically a terminology to mean that it bypasses the pagecache.

> How to truncate these? I thought the whole idea of
> XIP was a pure RO mapping?

Well, not filemap_xip.

> 
> They should be valid from mount to umount.
> 
> Regards
> 
> Ingo Oeser, a bit puzzled about that...

See mm/filemap_xip.c:xip_file_write, xip_truncate_page.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
