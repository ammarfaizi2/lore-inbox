Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261511AbULNNui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261511AbULNNui (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 08:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261516AbULNNui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 08:50:38 -0500
Received: from main.gmane.org ([80.91.229.2]:47783 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261511AbULNNuV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 08:50:21 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ed L Cashin <ecashin@coraid.com>
Subject: Re: [PATCH] ATA over Ethernet driver for 2.6.9 (with changes)
Date: Tue, 14 Dec 2004 08:50:12 -0500
Message-ID: <87is75oup7.fsf@coraid.com>
References: <87k6rmuqu4.fsf@coraid.com> <20041213215434.GA22215@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-34-230-221.asm.bellsouth.net
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
Cancel-Lock: sha1:Y65uxbD9Rh9wRaLDVD2JKPdwQnQ=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:

...
>> +enum {
>> +	DEVFL_UP = 1,	/* device is installed in system and ready for AoE->ATA commands */
>> +	DEVFL_TKILL = (1<<1),	/* flag for timer to know when to kill self */
>> +	DEVFL_EXT = (1<<2),	/* device accepts lba48 commands */
>> +	DEVFL_CLOSEWAIT = (1<<3), /* device is waiting for all closes to revalidate */
>> +	DEVFL_WC_UPDATE = (1<<4), /* this device needs to update write cache status */
>> +	DEVFL_WORKON = (1<<4),
>> +
>> +	BUFFL_FAIL = 1,
>> +};
>
> Any reason why BUFFL_FAIL and DEVFL_UP are the same value?  It looks
> like they can be used in the same variable right?

The struct Buf and the struct Aoedev both have a flags member.
BUFFL_* is for the flags member of the Buf, while DEVFL_* are bits for
the flags member of the struct Aoedev.

Although they both happen to be 1, they are conceptually unrelated, so
they have different names.  They should not be used in the same
variable.  BUFFL_ for the flags of a struct Buf, and DEVFL_ for the
flags of a struct Aoedev.

>
> The class_simple stuff looked sane, nice job.

Thanks!  It was pretty easy.

-- 
  Ed L Cashin <ecashin@coraid.com>

