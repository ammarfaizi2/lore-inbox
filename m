Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751232AbWF2SLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbWF2SLM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 14:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbWF2SLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 14:11:11 -0400
Received: from smtp-out.google.com ([216.239.45.12]:3817 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751232AbWF2SLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 14:11:10 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=gc17+mveyu8+Jl7CbAfnd2TWvcwws/Vp10k8i9QC4JX9hF5xq4Mij1kGIbviLTJla
	WVT0Y83KzSeIoyPcyo68g==
Message-ID: <44A417A3.80001@google.com>
Date: Thu, 29 Jun 2006 11:10:43 -0700
From: Daniel Phillips <phillips@google.com>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Dilger <adilger@clusterfs.com>
CC: Johann Lombardi <johann.lombardi@bull.net>, sho@tnes.nec.co.jp,
       cmm@us.ibm.com, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/2] ext3: enlarge blocksize and fix rec_len overflow
References: <20060628205238sho@rifu.tnes.nec.co.jp> <20060628155048.GG2893@chiva> <20060628202421.GL5318@schatzie.adilger.int>
In-Reply-To: <20060628202421.GL5318@schatzie.adilger.int>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

Andreas Dilger wrote:
> On Jun 28, 2006  17:50 +0200, Johann Lombardi wrote:
>>ext2/ext3_dir_entry_2 has a 16-bit entry(rec_len) and it would overflow
>>with 64KB blocksize.  This patch prevent from overflow by limiting
>>rec_len to 65532.
> 
> Having a max rec_len of 65532 is rather unfortunate, since the dir
> blocks always need to filled with dir entries.  65536 - 65532 = 4, and
> the minimum ext3_dir_entry size is 8 bytes.  I would instead make this
> maybe 64 bytes less so that there is room for a filename in the "tail"
> dir_entry.

Then why not introduce a little symmetry by making max rec_len 2**15 and
treat big directory blocks as an array of smaller ones?  I dimly recall
the page-cache oriented Ext2 dir code already does this.

Regards,

Daniel
