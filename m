Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbWHUVEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbWHUVEp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 17:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbWHUVEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 17:04:45 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:24555 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751103AbWHUVEo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 17:04:44 -0400
Subject: Re: [ckrm-tech] [RFC][PATCH] UBC: user resource beancounters
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Kirill Korotaev <dev@sw.ru>
Cc: Rik van Riel <riel@redhat.com>, vatsa@in.ibm.com,
       ckrm-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, devel@openvz.org,
       Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <44E9910D.9010402@sw.ru>
References: <44E33893.6020700@sw.ru> <20060817110237.GA19127@in.ibm.com>
	 <44E47547.8030702@sw.ru> <1155844543.26155.10.camel@linuxchandra>
	 <44E5982C.80304@sw.ru> <1155927229.26155.28.camel@linuxchandra>
	 <44E9910D.9010402@sw.ru>
Content-Type: text/plain
Organization: IBM
Date: Mon, 21 Aug 2006 14:04:33 -0700
Message-Id: <1156194273.6479.31.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-21 at 14:55 +0400, Kirill Korotaev wrote:
<snip>

> >>If you have a single container controlling all the resources, then
> >>placing kjournald into CPU container would require setting
> >>it's memory limits etc. And kjournald will start to be accounted separately,
> > 
> > 
> > Not necessarily. You could just set the CPU shares of the group and
> > leave the other resources as don't care.
> don't care IMHO doesn't mean "accounted and limited as container X".
> it sounds like "no limits" for me.

Yes. But, it would provide the same functionality that you want (i.e
limit only CPU and no other resources).

> 
> >>while my intention is kjournald to be accounted as the host system.
> >>I only want to _guarentee_ some CPU to it.
> > I do not see any _guarantee_ support, only barrier(soft limit) and
> > limit. May be I overlooked. Can you tell me how guarantee is achieved
> > with UBC.
> we just provide additional parameters like oomguarpages, where barrier
> is a guarantee.

I take it that you are suggesting that the controller can use barrier as
guarantee.

I don't see how it will work. charge_beancounter() returns -ENOMEM even
when the group is over its barrier (when queried with strict ==
UB_BARRIER). 

I have to see the oomguarpatches patches for understanding this, I
suppose.
> 
> Kirill
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


