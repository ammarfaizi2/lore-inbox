Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262005AbVCASIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262005AbVCASIb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 13:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbVCASIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 13:08:30 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:59555 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262005AbVCASI0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 13:08:26 -0500
Message-ID: <4224AF3D.3010803@sgi.com>
Date: Tue, 01 Mar 2005 10:06:53 -0800
From: Jay Lan <jlan@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: zh-tw, en-us, en, zh-cn, zh-hk
MIME-Version: 1.0
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
CC: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       Kaigai Kohei <kaigai@ak.jp.nec.com>, jbarnes@sgi.com
Subject: Re: [PATCH 2.6.11-rc4-mm1] end-of-proces handling for acct-csa
References: <421EA8FF.1050906@sgi.com>	 <20050224204646.704680e9.akpm@osdl.org>	 <1109314660.1738.206.camel@frecb000711.frec.bull.fr>	 <42236979.5030702@sgi.com> <1109662409.8594.50.camel@frecb000711.frec.bull.fr>
In-Reply-To: <1109662409.8594.50.camel@frecb000711.frec.bull.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry I was not clear on my point.

I was trying to point out that, an exit hook for BSD and CSA is
essential to save accounting data before the data is gone. That
can not be done with a netlink.

So, my patch was to keep acct_process as a wrapper, which
would then call do_exit_csa() for CSA and call do_acct_process
for BSD.

Thanks,
  - jay


Guillaume Thouvenin wrote:
> On Mon, 2005-02-28 at 10:56 -0800, Jay Lan wrote:
> 
>>The exit hook is essential for CSA to save off data before the data
>>is gone, A netlink type of thing does not help. BSD is in the same
>>situation. You can not replace the acct_process() call with a netlink.
>>If ELSA is to use the enhanced accounting data, it needs the CSA
>>eop handling at exit as well.
> 
> 
> Why replace the acct_process()? The problem here is to add a new hook in
> the do_fork() and you can use the BSD accounting hook acct_process()
> which is already in the exit() routine. We don't need to replace it with
> a netlink because today there are no user space applications that need
> it. 
> 
> Best regards,
> Guillaume 

