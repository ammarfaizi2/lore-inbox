Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317730AbSGKC6l>; Wed, 10 Jul 2002 22:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317735AbSGKC6k>; Wed, 10 Jul 2002 22:58:40 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50704 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317730AbSGKC6j>;
	Wed, 10 Jul 2002 22:58:39 -0400
Message-ID: <3D2CF4FB.5030600@mandrakesoft.com>
Date: Wed, 10 Jul 2002 23:01:15 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Grover, Andrew" <andrew.grover@intel.com>
CC: "'CaT'" <cat@zip.com.au>, Benjamin LaHaise <bcrl@redhat.com>,
       Andrew Morton <akpm@zip.com.au>, Linux <linux-kernel@vger.kernel.org>
Subject: Re: HZ, preferably as small as possible
References: <59885C5E3098D511AD690002A5072D3C02AB7F94@orsmsx111.jf.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-RBL-Warning: (relays.osirusoft.com) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grover, Andrew wrote:
> So, a changing tick *can* be done. If Linux does the same thing, seems like
> everyone is happy. What are the obstacles to this for Linux? If code is
> based on the assumption of a constant timer tick, I humbly assert that the
> code is broken.

Unfortunately code in Linux has traditionally compiled in a constant HZ 
all over the place, and jiffies instead of real time units are at the 
heart of all Linux timer-related activities.

I don't see that making 'HZ' a variable is really an option, because 
many drivers and scheduler-related code will be wildly inaccurate as 
soon as HZ actually changes values.

So that leaves us with the option of changing all the code related to 
waiting to be based on msecs and usecs.  Which I would love to do, but 
that's a lot of work, both code- and audit-wise.

	Jeff



