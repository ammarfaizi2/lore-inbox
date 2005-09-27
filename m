Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751054AbVI0Wnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbVI0Wnq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 18:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbVI0Wnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 18:43:46 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:36578 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751054AbVI0Wnp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 18:43:45 -0400
Message-ID: <4339CB15.9060602@engr.sgi.com>
Date: Tue, 27 Sep 2005 15:43:33 -0700
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040906
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Hugh Dickins <hugh@veritas.com>,
       Frank van Maarseveen <frankvm@frankvm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.14-rc2] fix incorrect mm->hiwater_vm and mm->hiwater_rss
References: <20050921121915.GA14645@janus> <Pine.LNX.4.61.0509211515330.6114@goblin.wat.veritas.com> <43319111.1050803@engr.sgi.com> <Pine.LNX.4.61.0509211802150.8880@goblin.wat.veritas.com> <4331990A.80904@engr.sgi.com> <Pine.LNX.4.61.0509211835190.9340@goblin.wat.veritas.com> <4331A0DA.5030801@engr.sgi.com> <20050921182627.GB17272@janus> <Pine.LNX.4.61.0509211958410.10449@goblin.wat.veritas.com> <4339AED4.8030108@engr.sgi.com> <4339BDF6.3070706@engr.sgi.com> <Pine.LNX.4.62.0509271449280.10674@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0509271449280.10674@schroedinger.engr.sgi.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Tue, 27 Sep 2005, Jay Lan wrote:
> 
> 
>>Just looked at the __vm_stat_account() code. It is enclosed inside
>>#ifdef CONFIG_PROC_FS.
>>
>>If that is necessary, i can not put hiwater_vm update code in there. The
>>system accounting code should not be dependent on a config flag that has
>>nothing to do with system accounting.
> 
> 
> I doubt you can do accounting without having /proc. Dont you need to 
> read/write files in /proc? Can we make accounting dependent on /proc?

Right, system accounting code (BSD_PROCESS_ACCT) does not depend on
/proc.

In my opinion, those "everyone should say Y here" config flags should
not be config flags at all. Since it is a flag, i should not put
sys accounting code in there.
