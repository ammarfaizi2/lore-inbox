Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261438AbVBRSRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbVBRSRH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 13:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbVBRSRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 13:17:07 -0500
Received: from cliff.niehs.nih.gov ([157.98.192.45]:19635 "EHLO
	cliff.niehs.nih.gov") by vger.kernel.org with ESMTP id S261426AbVBRSRC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 13:17:02 -0500
Message-ID: <42163118.8090703@niehs.nih.gov>
Date: Fri, 18 Feb 2005 13:16:56 -0500
From: Joe Krahn <krahn@niehs.nih.gov>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andries Brouwer <aebr@win.tue.nl>
CC: Kurt Garloff <garloff@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Bogus REPORT_LUNS responses breaks SCSI LUN detection
References: <41DF1D96.6030109@niehs.nih.gov> <20050214045100.GA27893@tpkurt.garloff.de> <20050218172636.GA8250@pclin040.win.tue.nl>
In-Reply-To: <20050218172636.GA8250@pclin040.win.tue.nl>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:
> On Sun, Feb 13, 2005 at 11:51:00PM -0500, Kurt Garloff wrote:
> 
> 
>>>SuSE 9.1
>>>Vendor: easyRAID Model: X16 Rev: 0001
>>>Type: Direct-Access ANSI SCSI revision: 03
>>>scsi: host 0 channel 0 id 5 lun 0x6500737952414944 has a LUN larger than 
>>>currently supported.
>>
>>Looks like random garbage.
> 
> 
> I read "e syRAID"
> 
> 
>>>Kernel 2.6, unknown distro
>>>Vendor: transtec  Model:                   Rev: 0001
>>>Type:   Direct-Access                      ANSI SCSI revision: 03
>>>On host 1 channel 0 id 1 only 128 (max_scsi_report_luns) of 536870896 
>>>luns reported, try increasing max_scsi_report_luns.
>>>scsi: host 1 channel 0 id 1 lun 0x7400616e73746563 has a LUN larger than 
>>>currently supported.
> 
> 
> I read "t anstec"
> 
> So - you might wish to investigate why the 2nd byte of "easyRAID" and
> of "transtec" was zeroed, and whether contents like this was to be
> expected (maybe the previous command was IDENTIFY?).
> 
> Andries

The problem arises from a bug in the underlying controller made by 
MaxTronic. The good news is that they recently released an upgraded 
firmware to fix it. And, more importantly, it is possible to set 
scsi_mod.default_dev_flags=0x40000 (==BLIST_NOREPORTLUN)

I suspect that your guess of the previous command being IDENTIFY is correct.

Thanks, Joe Krahn
