Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751481AbVJYHcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbVJYHcg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 03:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbVJYHcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 03:32:36 -0400
Received: from mailgate-out2.mysql.com ([213.136.52.68]:26026 "EHLO
	mailgate.mysql.com") by vger.kernel.org with ESMTP id S1751481AbVJYHcg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 03:32:36 -0400
Message-ID: <435DE042.9060208@mysql.com>
Date: Tue, 25 Oct 2005 09:35:30 +0200
From: Jonas Oreland <jonas@mysql.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.11) Gecko/20050915
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>, Andi Kleen <ak@suse.de>
CC: Jonas Oreland <jonas@mysql.com>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, discuss@x86-64.org
Subject: x86-64: Syncing dualcore cpus TSCs
References: <1127157404.3455.209.camel@cog.beaverton.ibm.com> <20051007122624.GA23606@tentacle.sectorb.msk.ru> <200510071431.47245.ak@suse.de> <20051008101153.GA1541@tentacle.sectorb.msk.ru> <1128967404.8195.419.camel@cog.beaverton.ibm.com> <20051010181216.GA21548@tentacle.sectorb.msk.ru> <434AB0BE.3080206@mysql.com> <20051011073532.GA29254@tentacle.sectorb.msk.ru> <434BE7E9.8000501@mysql.com>
In-Reply-To: <434BE7E9.8000501@mysql.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This might be a very bad suggestion, but here it is:

On dualcore cpus (amd64) the TSC will get out of sync when executing hlt instruction.
booting with idle=poll, will make it never to execute hlt, hence TSC will be in sync.
booting with notsc will make it use other time source...but this is slower
  (this is default after "[PATCH] x86-64: Fix bad assumption that dualcore cpus have synced TSCs")

How about syncing TSC after hlt?

If cost of syncing TSC's is smaller than cost of using other time source this might be an alternative.

/Jonas
