Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030208AbWD0Tes@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030208AbWD0Tes (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 15:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965069AbWD0Tes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 15:34:48 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:54923 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964928AbWD0Tes (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 15:34:48 -0400
Message-ID: <44511CCF.1080504@engr.sgi.com>
Date: Thu, 27 Apr 2006 12:34:39 -0700
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040906
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: balbir@in.ibm.com
Cc: Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: [Patch 5/8] taskstats interface
References: <444991EF.3080708@watson.ibm.com> <444996FB.8000103@watson.ibm.com> <44501A97.2060104@engr.sgi.com> <445041EB.7080205@watson.ibm.com> <20060427064237.GA14496@in.ibm.com> <445104DC.90401@engr.sgi.com> <20060427182719.GC14496@in.ibm.com>
In-Reply-To: <20060427182719.GC14496@in.ibm.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Balbir,

Balbir Singh wrote:
>>Are TASKSTATS_GENL_VERSION and TASKSTATS_VERSION the same thing?
>>If they are meant to serve different purposes, we still need it.
>>
> 
> 
> Yes, thats true. But for now from what I can see, one version should
> be sufficient.

If we envision a need of it in the future, we'd better put it in
today. It would be nice to have the revision number at beginning of
the struct. Shailabh's instruction says to add new field after existing
fields.

> 
> <snip> 
> 
> 
>>I was thinking of a bitmask thing. But instead of keying specific
>>fields, one bit may be used to key delay accounting, and another bit
>>for CSA, el at. This way you do not need to have CSA-specifc fields
>>in the payload and applications know how to correctly interpret the
>>payload. Taskstats and application do not need to have knowledge of
>>accounting packages, only need to set the bitmasks correctly.
>>
> 
> 
> Yes, but scanning the entire payload for various types is also feasible. It is
> a bit slow, but feasible and generally the recommended approach for
> dealing with genetlink types. What you are saying is still possible, the
> application can ignore types it does not understand.
> 
> 
>>When we start sending sys stats of each tasks to userland, that is
>>s lot of data. Note that BSD accounting even uses encode_comp_t()
>>routine to compress data into a 13-bit fraction with 3-bit exponent
>>field to shrink its size. Even though you do not need to care
>>about those zero's in taskstats, they still need to be delievered
>>through netlink socket.
> 
> 
> Yes, thats true. We can leave the decision of compressing, etc to the
> specific subsystem. It can encode it and the user level application
> can decode the data.

I am sorry that i did not make myself clear. My suggestion of using
the bitmask payload info is to be combined with #ifdef CONFIG_* to
eliminate unnecessary fields from the traffic. I am concerned about
losing data due to application not reading data fast enough.

Well, we can revisit this suggestion when we start losing data
though. ;-)

Regards,
  - jay

