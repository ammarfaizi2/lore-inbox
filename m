Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751637AbWF1WkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637AbWF1WkP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 18:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751640AbWF1WkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 18:40:14 -0400
Received: from terminus.zytor.com ([192.83.249.54]:59815 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751637AbWF1WkM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 18:40:12 -0400
Message-ID: <44A3053F.9040600@zytor.com>
Date: Wed, 28 Jun 2006 15:39:59 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: Erik Frederiksen <erik_frederiksen@pmc-sierra.com>,
       linux-kernel@vger.kernel.org
Subject: Re: IS_ERR Threshold Value
References: <1151528227.3904.1110.camel@girvin.pmc-sierra.bc.ca> <20060628140825.692f31be.rdunlap@xenotime.net>
In-Reply-To: <20060628140825.692f31be.rdunlap@xenotime.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> On Wed, 28 Jun 2006 14:57:07 -0600 Erik Frederiksen wrote:
> 
>> from include/asm-mips/errno.h
>> #define EDQUOT      1133    /* Quota exceeded */
>>
>> I noticed that the errno value for EDQUOT on MIPS is considerably larger
>> than all others.  This can lead to a situation where functions using
>> ERR_PTR() to return error codes in pointers cannot return this error
>> code without IS_ERR() thinking that the pointer is valid.  In my case,
>> it caused an alignment exception in the XFS open call when quota has
>> been exceeded in the linux-mips 2.6.14 kernel.  I think that the XFS
>> code has changed enough that this bug isn't in newer versions, though I
>> haven't done a thorough investigation.  
>>
>> I've supplied a patch that addresses this situation by changing the
>> threshold used by IS_ERR if EMAXERRNO is defined and greater than 1000. 
>> Perhaps permanently raising the threshold value to something >1133 is
>> sufficient.
>>
>> Looking forward to your feedback.  
>>
>> Erik Frederiksen
>> Firmware Design Engineer Co-op
>> PMC-Sierra Saskatoon
> 
> Hi,
> Peter Anvin mentioned just a few days ago that this threshold value
> should be 4095 for all arches.  I think we need to get that patch
> done & submitted to Andrew for -mm.
> 

Indeed.

	-hpa
