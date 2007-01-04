Return-Path: <linux-kernel-owner+w=401wt.eu-S1751074AbXADEgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbXADEgZ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 23:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbXADEgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 23:36:25 -0500
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:21412 "HELO
	smtp105.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750741AbXADEgY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 23:36:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=A3zhfDGrrAqo5u39jAjYmmKyTFwxh/u4IYWFF6chFNHf+kNEVCtqumiPTeceZPo6eakiVYGI6Y2hb+8zDp1zNqDQnngepJ6mQTJHmqlE7IFV+182bxc5+MBdu+gD7DEGHMw01nE2n2hKjOKizFRPOoRxdVxCbuBpgYTz2huB/DQ=  ;
X-YMail-OSG: JJgOC8AVM1kZ9urtihGx95PEDwGtINwBRPlVllNm830Iptr48aaYW0y5vpHIZVMheXk9LM2zamY7G5o08X.e4rlA2CjZ0.idGqYSO9ptLs12pK6oH8nPsbRqBx_qOqkomtCY8tVU5onC80Y-
Message-ID: <459C8427.9040704@yahoo.com.au>
Date: Thu, 04 Jan 2007 15:35:51 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <jens.axboe@oracle.com>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org, Nick Piggin <npiggin@suse.de>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Neil Brown <neilb@suse.de>, Mark Fasheh <mark.fasheh@oracle.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: Re: [PATCH] 4/4 block: explicit plugging
References: <11678105083001-git-send-email-jens.axboe@oracle.com> <1167810508576-git-send-email-jens.axboe@oracle.com>
In-Reply-To: <1167810508576-git-send-email-jens.axboe@oracle.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> Nick writes:
> 
> This is a patch to perform block device plugging explicitly in the submitting
> process context rather than implicitly by the block device.

Hi Jens,

Hey thanks for doing so much hard work with this, I couldn't have fixed
all the block layer stuff myself. QRCU looks like a good solution for the
barrier/sync operations (/me worried that one wouldn't exist), and a
novel use of RCU!

The only thing I had been thinking about before it is ready for primetime
-- as far as the VM side of things goes -- is whether we should change
the hard calls to address_space operations, such that they might be
avoided or customised when there is no backing block device?

I'm sure the answer to this is "yes", so I have an idea for a simple
implementation... but I'd like to hear thoughts from network fs / raid
people?

Nick

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
