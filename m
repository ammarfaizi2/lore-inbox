Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262308AbVDFULZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262308AbVDFULZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 16:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262307AbVDFULY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 16:11:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:32428 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262309AbVDFUK5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 16:10:57 -0400
Subject: Re: Linux 2.4.30-rc3 md/ext3 problems (ext3 gurus : please check)
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Hifumi Hisashi <hifumi.hisashi@lab.ntt.co.jp>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Neil Brown <neilb@cse.unsw.edu.au>, Andrew Morton <akpm@osdl.org>,
       vherva@viasys.com, linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <6.0.0.20.2.20050406163929.06ef07b0@mailsv2.y.ecl.ntt.co.jp>
References: <20050326162801.GA20729@logos.cnet>
	 <20050328073405.GQ16169@viasys.com> <20050328165501.GR16169@viasys.com>
	 <16968.40186.628410.152511@cse.unsw.edu.au>
	 <20050329215207.GE5018@logos.cnet>
	 <16970.9679.874919.876412@cse.unsw.edu.au>
	 <20050330115946.GA7331@logos.cnet>
	 <1112740856.4148.145.camel@sisko.sctweedie.blueyonder.co.uk>
	 <6.0.0.20.2.20050406163929.06ef07b0@mailsv2.y.ecl.ntt.co.jp>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1112818233.3377.52.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Wed, 06 Apr 2005 21:10:33 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2005-04-06 at 11:01, Hifumi Hisashi wrote:

> I have measured the bh refcount before the buffer_uptodate() for a few days.
> I found out that the bh refcount sometimes reached to 0 .
> So, I think following modifications are effective.

Thanks --- it certainly looks like this should fix the dereferencing of
invalid bh's, and this code mirrors what 2.6 does around that area.

However, 2.6 is suspected of still having leaks in ext3.  To be certain
that we're not just backporting one of those to 2.4, we need to
understand who exactly is going to clean up these bh's if they are in
fact unused once we complete this code and do the final put_bh().  

I'll give this patch a spin with Andrew's fsx-based leak stress and see
if anything unpleasant appears.  

Cheers,
 Stephen

