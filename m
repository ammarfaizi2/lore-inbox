Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261425AbVECIr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbVECIr7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 04:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261429AbVECIr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 04:47:59 -0400
Received: from mailgate.quadrics.com ([194.202.174.11]:39639 "EHLO
	qserv01.quadrics.com") by vger.kernel.org with ESMTP
	id S261425AbVECIrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 04:47:49 -0400
Message-ID: <42773964.1030101@quadrics.com>
Date: Tue, 03 May 2005 09:42:12 +0100
From: David Addison <addy@quadrics.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Grant Grundler <iod00d@hp.com>
Cc: Brice Goglin <Brice.Goglin@ens-lyon.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       hch@infradead.org, Caitlin Bestler <caitlin.bestler@gmail.com>
Subject: Re: [openib-general] Re: RDMA memory registration
References: <20050426084234.A10366@topspin.com> <52mzrlsflu.fsf@topspin.com>	<20050426122850.44d06fa6.akpm@osdl.org>	<5264y9s3bs.fsf@topspin.com> <426EA220.6010007@ammasso.com>	<20050426133752.37d74805.akpm@osdl.org>	<5ebee0d105042907265ff58a73@mail.gmail.com>	<469958e005042908566f177b50@mail.gmail.com>	<52d5sdjzup.fsf_-_@topspin.com> <42727B60.7010507@ens-lyon.org> <20050429193354.GJ24871@esmail.cup.hp.com>
In-Reply-To: <20050429193354.GJ24871@esmail.cup.hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 May 2005 08:36:01.0218 (UTC) FILETIME=[22DAF220:01C54FBB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Grundler wrote:
> On Fri, Apr 29, 2005 at 08:22:24PM +0200, Brice Goglin wrote:
>>For instance, instead of adding PROT_DONT/ALWAYSCOPY, you may use
>>an ioproc hook in the fork path. This hook (a function in your driver)
>>would be called for each registered page. It will decide whether
>>the page should be pre-copied or not and update the registration
>>table (or whatever stores address translations in the NIC).
>>In addition, the driver would probably pre-copy cow pages when
>>registering them.
> 
> This doesn't scale well as more cards are added to the box.
> I think I understand why it's good for single cards though.
> 
With the IOPROC patch the device driver hooks are registered on a per process
or perhaps better still, a per VMA basis. And for processes/VMAs where there
are no registrations the overhead is very low.

With multiple cards in a box, all using different device drivers, I guess there
could end up being multiple registrations per process/VMA. But I'm not sure
this will be a common case for RDMA use in real life.

Cheers
Addy.
