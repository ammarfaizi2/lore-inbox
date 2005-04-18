Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262089AbVDRO7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262089AbVDRO7J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 10:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262091AbVDRO7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 10:59:09 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:33008 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262089AbVDRO66 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 10:58:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=DuEkgdhxThUD6yUyFQEqJ23kmgcl6s8B7EvxbufP6pl/Ci3i9wkJiX1NL6MJZOcHPHgbQn16dM+0c0Mo4Bp7YrQ9/6THgSEchhSYDqQ7TktsCSjUuq9PHsdfcb1HhDpMnoUUia68BrnU2NrxfvZQs+BcgyV84Cvoluw79G3YJ0I=
Message-ID: <4263CB26.2070609@gmail.com>
Date: Mon, 18 Apr 2005 23:58:46 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050402)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>, Jens Axboe <axboe@suse.de>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Regarding posted scsi midlyaer patchsets
References: <20050417224101.GA2344@htj.dyndns.org> <1113833744.4998.13.camel@mulgrave>
In-Reply-To: <1113833744.4998.13.camel@mulgrave>
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, James.
 Hello, Jens.

James Bottomley wrote:
> On Mon, 2005-04-18 at 07:41 +0900, Tejun Heo wrote:
> 
>> As it's been almost a week since I posted scsi midlayer patchsets and
>>haven't heard anything yet, I've been wondering what's going on.  Are
>>they under review or all dropped?  If they are dropped, can you please
>>tell me why they are dropped?
> 
> 
> I have about four of them in the scsi-misc-2.6 tree, if you look.
> 
> Your request path rewrite I already gave you feedback that I didn't want
> REQ_SOFTBARRIER in scsi ... it needs to be in the block submit API for
> special requests.  Also, you have a patch for block in this code so I
> can't apply it without an ack from Jens.  And all the rest of your
> patches depend on this one.

 This thread started as an private inquiry to James regarding the status
of four patchsets I posted about a week ago.  I'm replying publicly as I
think we can use some discussion.  The four patchsets are... (in the
following order)

 * timer updates
 * REQ_SPECIAL/REQ_SOFTBARRIER usage change
 * scsi_request_fn reimpl
 * requeue path consolidation.

 Accepted patches are

 * scsi_cmnd->internal_timeout kill
 * scsi_cmnd->serial_number_at_timeout
 * remove volatile
 * scsi_send_eh_cmnd() clean up

 All four accepted patches are not included in any of above patchsets
and the timer update patchset doesn't depend on
REQ_SPECIAL/REQ_SOFTBARRIER usage change patchset, so please review the
timer update patchset.

 And, James, regarding REQ_SOFTBARRIER, if the REQ_SOFTBARRIER thing can
be removed from SCSI midlayer, do you agree to change REQ_SPECIAL to
mean special requests?  If so, I have three proposals.

 * move REQ_SOFTBARRIER setting to right after the allocation of
scsi_cmnd in scsi_prep_fn().  This will be the only place where
REQ_SOFTBARRIER is used in SCSI midlayer, making it less pervasive.
 * Or, make another API which sets REQ_SOFTBARRIER on requeue.  maybe
blk_requeue_ordered_request()?
 * Or, make blk_insert_request() not set REQ_SPECIAL on requeue.  IMHO,
this is a bit too subtle.

 I like #1 or #2.  Jens, what do you think?  Do you agree to remove
requeue feature from blk_insert_request()?

 Thanks a lot. :-)

-- 
tejun

