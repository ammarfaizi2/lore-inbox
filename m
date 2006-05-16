Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751052AbWEPCL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbWEPCL6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 22:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbWEPCL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 22:11:58 -0400
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:23686 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751049AbWEPCL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 22:11:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=OEub/24KHj+44A11Aq9NrTCVz7fQ1qoKjhZIai+ZmNoskJ9h4AgDACZSjoCdmqiiseqWscJlTTODP5FdknMQGOWCdjrSKtJaPfYlPh0fqz5Tut5QhnpepyT17hvTaJrcHn5PKYR6l7wnrutp96eUxxtlmZ3HchndaXpuu/SrVVY=  ;
Message-ID: <446934E3.5020204@yahoo.com.au>
Date: Tue, 16 May 2006 12:11:47 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
CC: apw@shadowen.org, akpm@osdl.org, mel@csn.ul.ie, davej@codemonkey.org.uk,
       tony.luck@intel.com, linux-kernel@vger.kernel.org, bob.picco@hp.com,
       ak@suse.de, linux-mm@kvack.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 5/6] Have ia64 use add_active_range() and free_area_init_nodes
References: <20060508141030.26912.93090.sendpatchset@skynet>	<20060508141211.26912.48278.sendpatchset@skynet>	<20060514203158.216a966e.akpm@osdl.org>	<44683A09.2060404@shadowen.org>	<44685123.7040501@yahoo.com.au>	<446855AF.1090100@shadowen.org>	<20060515192918.c3e2e895.kamezawa.hiroyu@jp.fujitsu.com>	<44691D7C.5060208@yahoo.com.au> <20060516103415.ad964bdf.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060516103415.ad964bdf.kamezawa.hiroyu@jp.fujitsu.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

KAMEZAWA Hiroyuki wrote:

>
>Andy's page_zone(page) == page_zone(buddy) check is good, I think.
>
>Making alignment is a difficult problem, I think. It complecates many things.
>We can avoid above check only when memory layout is ideal.
>
>BTW, How about following patch ?
>I don't want to  say "Oh, you have to re-compile your kernel with 
>CONFIG_UNALIGNED_ZONE on your new machine. you are unlucky." to users.
>

No, this is a function of the architecture code, not the specific
machine it is running on.

So if the architecture ensures alignment and no holes, then they don't
need the overhead of CONFIG_UNALIGNED_ZONE or CONFIG_HOLES_IN_ZONE.

If they do not ensure correct alignment, then they must enable
CONFIG_UNALIGNED_ZONE, even if there may be actual systems which do
result in aligned zones.
--

Send instant messages to your online friends http://au.messenger.yahoo.com 
