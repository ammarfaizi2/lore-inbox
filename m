Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262389AbVCBSAk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262389AbVCBSAk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 13:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262383AbVCBSAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 13:00:39 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:19409 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262380AbVCBR7N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 12:59:13 -0500
Message-ID: <4225FF0E.5040107@sgi.com>
Date: Wed, 02 Mar 2005 09:59:42 -0800
From: Jay Lan <jlan@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: zh-tw, en-us, en, zh-cn, zh-hk
MIME-Version: 1.0
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
CC: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       Kaigai Kohei <kaigai@ak.jp.nec.com>, jbarnes@sgi.com
Subject: Re: [PATCH 2.6.11-rc4-mm1] end-of-proces handling for acct-csa
References: <421EA8FF.1050906@sgi.com>	 <20050224204646.704680e9.akpm@osdl.org>	 <1109314660.1738.206.camel@frecb000711.frec.bull.fr>	 <42236979.5030702@sgi.com>	 <1109662409.8594.50.camel@frecb000711.frec.bull.fr>	 <4224AF3D.3010803@sgi.com> <1109749735.8422.104.camel@frecb000711.frec.bull.fr>
In-Reply-To: <1109749735.8422.104.camel@frecb000711.frec.bull.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I did not look into the userspace commands supported in BSD
accounting on the dependency on the format of /var/account/pacct
file.

The accounting exit hook allows BSD/CSA to save accounting
data stored in task_struct to internally kept data structure
and then writes to their respective accounting file. The
format of the accounting output file of the two are different,
with CSA being the superset of BSD and also with CSA carrying
concept of grouping of processes.

It would be an interesting project to merge BSD and CSA, but
it is going to take some surgical work on both products, not
an easy one.

- jay


Guillaume Thouvenin wrote:
> On Tue, 2005-03-01 at 10:06 -0800, Jay Lan wrote:
> 
>>Sorry I was not clear on my point.
>>
>>I was trying to point out that, an exit hook for BSD and CSA is
>>essential to save accounting data before the data is gone. That
>>can not be done with a netlink.
>>
>>So, my patch was to keep acct_process as a wrapper, which
>>would then call do_exit_csa() for CSA and call do_acct_process
>>for BSD.
> 
> 
> Is it possible to merge BSD and CSA? I mean with CSA, there is a part
> that does per-process accounting. For exemple in the
> linux-2.6.9.acct_mm.patch the two functions update_mem_hiwater() and
> csa_update_integrals() update fields in the current (and parent)
> process. So maybe you can improve the BSD per-process accounting or
> maybe CSA can replace the BSD per-process accounting?
> 
> Guillaume  

