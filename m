Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751789AbWJMSQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751789AbWJMSQx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 14:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751793AbWJMSQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 14:16:53 -0400
Received: from elasmtp-banded.atl.sa.earthlink.net ([209.86.89.70]:6618 "EHLO
	elasmtp-banded.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S1751796AbWJMSQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 14:16:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk20050327; d=earthlink.net;
  b=Drqz95odIkFENEGddaq8eRSDWlLKffI3vS48sxhfe7YCLT8HWEfCVpTgRBypfkxv;
  h=Received:Message-ID:From:To:Cc:References:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Priority:X-MSMail-Priority:X-Mailer:X-MimeOLE:X-ELNK-Trace:X-Originating-IP;
Message-ID: <105201c6eef3$ab64c750$0225a8c0@Wednesday>
From: "jdow" <jdow@earthlink.net>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, "Neil Brown" <neilb@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <aeb@cwi.nl>,
       "Jens Axboe" <jens.axboe@oracle.com>
References: <17710.54489.486265.487078@cse.unsw.edu.au> <1160752047.25218.50.camel@localhost.localdomain>
Subject: Re: Why aren't partitions limited to fit within the device?
Date: Fri, 13 Oct 2006 11:16:08 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
X-ELNK-Trace: bb89ecdb26a8f9f24d2b10475b57112043d6cd5ae92be3c01608d433651204176f22d7f45f6ea5ad350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 71.116.187.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>

> Ar Gwe, 2006-10-13 am 09:50 +1000, ysgrifennodd Neil Brown:
>> So:  Is there any good reason to not clip the partitions to fit
>> within the device - and discard those that are completely beyond
>> the end of the device??
> 
> Its close but not quite the right approach
> 
>> The patch at the end of the mail does that.  Is it OK to submit this
>> to mainline?
> 
> No I think not. Any partition which is partly outside the disk should be
> ignored entirely, that ensures it doesn't accidentally get mounted and
> trashed by an HPA or similar mixup.

This is also a risk for users who have a partition that was poorly
setup with an earlier version that allowed it to almost work. If there
is data on that partition refusing to mount it can lead to massive
data loss akin to a broken disk drive.

<<jdow>> I'd propose allowing it to mount read-only and forcing
read-only mode when attempts to mount read-write are made. That way
the user never perceives a data loss situation and can take the
appropriate steps to repair the partitioning error.

{^_^}   Joanne Dow
