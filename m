Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261288AbVCHAGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbVCHAGz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 19:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbVCHADS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 19:03:18 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:34777 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261996AbVCGX56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 18:57:58 -0500
Message-ID: <422CEA86.5090202@sgi.com>
Date: Mon, 07 Mar 2005 15:57:58 -0800
From: Jay Lan <jlan@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: zh-tw, en-us, en, zh-cn, zh-hk
MIME-Version: 1.0
To: Tim Schmielau <tim@physik3.uni-rostock.de>
CC: Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Kaigai Kohei <kaigai@ak.jp.nec.com>, jbarnes@sgi.com
Subject: Re: [PATCH 2.6.11-rc4-mm1] end-of-proces handling for acct-csa
References: <421EA8FF.1050906@sgi.com>  <20050224204646.704680e9.akpm@osdl.org>  <1109314660.1738.206.camel@frecb000711.frec.bull.fr>  <42236979.5030702@sgi.com>  <1109662409.8594.50.camel@frecb000711.frec.bull.fr>  <4224AF3D.3010803@sgi.com> <1109749735.8422.104.camel@frecb000711.frec.bull.fr> <Pine.LNX.4.53.0503050726090.31083@gockel.physik3.uni-rostock.de>
In-Reply-To: <Pine.LNX.4.53.0503050726090.31083@gockel.physik3.uni-rostock.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch i propose is tiny, simple and straight forward. It
touches only one file and leaves the CSA code in a  configurable
loadable module. It broke nobody's code and it does not need to
redesign existing BSD kernel code and utilities.

If we are to merge the code, there are some detailed discussion
needed to happen on implementation deail. We are talking about
supporting two different internal formats by one piece of code.
We need to maintain BSD acct format because BSD utilities count
on it.

If we are to combine two formats into one, we then need to
modify BSD utilies to understand the new format. How about
the backwards compatibility?

Now this is really an overkill. All i asked for was only
adding a few lines to acct.c.

Thanks,
  - jay


Tim Schmielau wrote:
> On Wed, 2 Mar 2005, Guillaume Thouvenin wrote:
> 
> 
>>Is it possible to merge BSD and CSA? I mean with CSA, there is a part
>>that does per-process accounting. For exemple in the
>>linux-2.6.9.acct_mm.patch the two functions update_mem_hiwater() and
>>csa_update_integrals() update fields in the current (and parent)
>>process. So maybe you can improve the BSD per-process accounting or
>>maybe CSA can replace the BSD per-process accounting?
> 
> 
> Yes, that was also my preferred direction - make CSA able to also write
> BSD acct format, and replace the existing BSD accounting with CSA.
> However it seems this will still increase the amount of kernel code quite 
> a bit.
> 
> Sorry for not going into any details, I have to leave right now and will 
> be offline for two weeks.
> 
> Tim

