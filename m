Return-Path: <linux-kernel-owner+w=401wt.eu-S965158AbXAKBBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965158AbXAKBBG (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 20:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965292AbXAKBBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 20:01:05 -0500
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:22321 "HELO
	smtp109.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S965158AbXAKBBE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 20:01:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=uA80nEhGJhE0yB93SL3jFnMOJCqdOz3ygmTUDBGJUiKSKtmrfyIQZTQFjVQl3DDA95vY4FnrkmMjMGjTQ6IEt3h5s+g3YhFtJDQLwsBzqFhav5QSWmCP6k52pjqofVlCmKVkPUf0YUDywtT2Znvp6A87WrX8Rd0bVouj3BGNiZk=  ;
X-YMail-OSG: KW.cYGQVM1mveZy4j1KyVYtCB6SEeUvUy2P_zoCxKQZjE2To7n5nCYtgE2jE.pujUvpND_0ruXSWvvM71cMwniF4Fx9tzSX8gmySvh2UIk.YZr8JwMA8yTsae_5HCzXS8g1KZl_jPcdDDZI-
Message-ID: <45A58C33.4050909@yahoo.com.au>
Date: Thu, 11 Jan 2007 12:00:35 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Vladimir V. Saveliev" <vs@namesys.com>
CC: Linus Torvalds <torvalds@osdl.org>, reiserfs-dev@namesys.com,
       =?ISO-8859-1?Q?Malte_Schr=F6der?= <MalteSch@gmx.de>,
       Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.20-rc4: known unfixed regressions (v2)
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org> <200701091908.44576.MalteSch@gmx.de> <Pine.LNX.4.64.0701091022180.3594@woody.osdl.org> <200701110324.42920.vs@namesys.com>
In-Reply-To: <200701110324.42920.vs@namesys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vladimir V. Saveliev wrote:
> Hello
> 
> On Tuesday 09 January 2007 21:30, Linus Torvalds wrote:
> 
>>On Tue, 9 Jan 2007, Malte Schröder wrote:
>>
>>>>So something interesting is definitely going on, but I don't know exactly
>>>>what it is. Why does reiserfs do the truncate as part of a close, if the
>>>>same inode is actually mapped somewhere else? 
> 
> 
> on file close reiserfs tries to "pack" content of last incomplete page of file into metadata blocks.
> It should not if that page is still mapped somewhere. 
> It does not actually truncate, it calls the same function which does truncate, but file size does not change.

That's racy, unfortunately :P

> 
> Please consider the below patch.

That seems like it would work. Probably papers over your truncate-inside-i_size as well.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
