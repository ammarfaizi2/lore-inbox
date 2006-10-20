Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946228AbWJTFMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946228AbWJTFMJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 01:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161449AbWJTFMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 01:12:09 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:27841 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1161444AbWJTFMH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 01:12:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TI4MRK6qjORM5voY5jMfkfPrqWd47pO67t4uu7lnXQTfke8qU0QsyAl1BybJJUaSDJqnvC5lNvaRDJA6YDTIJ+PhDG9T2xN63igiZBuphaiEkYedvmMu7xioZZHpb5eQKPg+7Furucp8IEx8ZpR+Y/CKUyCicykKXFC/Ogvx1Yg=
Message-ID: <4df04b840610192210x3d7de930k7be7dbf9e38819bd@mail.gmail.com>
Date: Fri, 20 Oct 2006 13:10:45 +0800
From: "yunfeng zhang" <zyf.zeroos@gmail.com>
To: "David Miller" <davem@davemloft.net>
Subject: Re: BUG: about flush TLB during unmapping a page in memory subsystem
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061019.200211.88476455.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4df04b840610191947r2b48c2ddo45f0cd94d94a614b@mail.gmail.com>
	 <20061019.200211.88476455.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe, the solution is below

...
// >>> ptep_clear((__vma)->vm_mm, __address, __ptep);
// >>> flush_tlb_page(__vma, __address);
// >>> __ptep;
...

And even so, we also get a pte with present = 0 AND its dirty = 1, an odd pte.

Remember B dirtied the pte before A executes flush_tlb_page.
