Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030722AbWJDR5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030722AbWJDR5S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 13:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030725AbWJDR5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 13:57:18 -0400
Received: from mga09.intel.com ([134.134.136.24]:50261 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S1030722AbWJDR5R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 13:57:17 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,256,1157353200"; 
   d="scan'208"; a="140417919:sNHT19240669"
Message-ID: <4748.10.24.192.177.1159984635.squirrel@linux.intel.com>
In-Reply-To: <20061004171436.GA25461@tsunami.ccur.com>
References: <200610030816.27941.reinette.chatre@linux.intel.com>
    <20061003163936.d8e26629.akpm@osdl.org>
    <20061004141405.GA22833@tsunami.ccur.com>
    <20061004094029.cdfef098.akpm@osdl.org>
    <20061004171436.GA25461@tsunami.ccur.com>
Date: Wed, 4 Oct 2006 10:57:15 -0700 (PDT)
Subject: Re: [PATCH] bitmap: bitmap_parse takes a kernel buffer instead of 
     a user buffer
From: "Inaky Perez-Gonzalez" <inaky@linux.intel.com>
To: "Joe Korty" <joe.korty@ccur.com>
Cc: "Andrew Morton" <akpm@osdl.org>,
       "Reinette Chatre" <reinette.chatre@linux.intel.com>,
       linux-kernel@vger.kernel.org,
       "Inaky Perez-Gonzalez" <inaky@linux.intel.com>,
       "Paul Jackson" <pj@sgi.com>
User-Agent: SquirrelMail/1.4.6-7.el4.centos4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Joe Korty wrote:
> On Wed, Oct 04, 2006 at 09:40:29AM -0700, Andrew Morton wrote:
>> I think we can do a version which omits the kmalloc altogether:
>
>> 			if (__get_user(c, ubuf++))
>> 				return -EFAULT;
>>
>> (Note the s/get_user/__get_user/)
>
> Nice.  This eliminates the bulk of the get_user() overhead.  And
> it can be merged into Inaky's enum solution too, for something
> that is both simple and efficient.

Then bitmap_parse_user() will need a quick access_ok() check
before calling down on __bitmap_parse(). Nice.

-- 
Inaky
