Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262899AbVCWJPL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262899AbVCWJPL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 04:15:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262888AbVCWJOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 04:14:12 -0500
Received: from rproxy.gmail.com ([64.233.170.193]:43883 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262889AbVCWJNe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 04:13:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=nCGcNAAmYhcBsylm9ulEoymKkBSgeiqKo2FyE5iZAGFukOsplb5u018U0JvILbJc+NbtqLeQyLoUcPIlNjZLY781JCQR3ZVgXSK8YwiIf6pBf5acmjEriEPXYFW7mkExieHzmtd/cNmrdcLTW3HI5My1HnSiQl7KmJ2nnlCtLUE=
Message-ID: <42413336.2010004@gmail.com>
Date: Wed, 23 Mar 2005 18:13:26 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050118)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Jens Axboe <axboe@suse.de>, SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH scsi-misc-2.6 07/08] scsi: remove bogus	{get|put}_device()
 calls
References: <20050323021335.960F95F8@htj.dyndns.org>	 <20050323021335.0D9E25EE@htj.dyndns.org> <1111551355.5520.100.camel@mulgrave>
In-Reply-To: <1111551355.5520.100.camel@mulgrave>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

James Bottomley wrote:
> On Wed, 2005-03-23 at 11:14 +0900, Tejun Heo wrote:
> 
>>	So, basically, SCSI high-level object (scsi_disk) and
>>	mid-level object (scsi_device) are reference counted by users,
>>	not the requests they submit.  Reference count cannot go zero
>>	with active users and users cannot access the object once the
>>	reference count reaches zero.
> 
> 
> Actually, no.  Unfortunately we still have some fire and forget APIs, so
> the contention that we always have an open refcounted descriptor isn't
> always true.

  Yeap, you're right.  So, what we have is

  * All high-level users have open access to the scsi high-level
    object on issueing requests, but may close it before its requests
    complete.
  * All mid-layer users do get_device() before submitting requests,
    but may put_device() before its requests complete.

  Thanks for pointing that out.  :-)

-- 
tejun

