Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161114AbWBVRXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161114AbWBVRXS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 12:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030315AbWBVRXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 12:23:18 -0500
Received: from mx1.redhat.com ([66.187.233.31]:18890 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030314AbWBVRXR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 12:23:17 -0500
Message-ID: <43FC9DFC.4040504@redhat.com>
Date: Wed, 22 Feb 2006 12:23:08 -0500
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.4.1 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
CC: christoph <hch@lst.de>, mcao@us.ibm.com, akpm@osdl.org,
       lkml <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>, vs@namesys.com,
       zam@namesys.com
Subject: Re: [PATCH 0/3] map multiple blocks in get_block() and	mpage_readpages()
References: <1140470487.22756.12.camel@dyn9047017100.beaverton.ibm.com>	 <20060222151216.GA22946@lst.de> <1140627510.22756.81.camel@dyn9047017100.beaverton.ibm.com>
In-Reply-To: <1140627510.22756.81.camel@dyn9047017100.beaverton.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty wrote:

>
>Thanks. Only current issue Nathan raised is, he wants to see
>b_size change to u64 (instead of u32) to support really-huge-IO
>requests. Does this sound reasonable to you ?
>

I believe that the various read and write system calls impose a 32 bit limit
on the size of the i/o request, so you may need to look at that too.

Increasing the size of b_size would address a bug which exists when trying
to read more than 4GB from a block device which is greater than 4GB in size.
Currently, that bug is masked because the maximum system call size is
arbitrarily limited.

    Thanx...

       ps
