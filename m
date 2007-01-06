Return-Path: <linux-kernel-owner+w=401wt.eu-S1751403AbXAFOkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbXAFOkA (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 09:40:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbXAFOkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 09:40:00 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:37590 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751403AbXAFOj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 09:39:59 -0500
Date: Sat, 6 Jan 2007 15:38:18 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: David Rientjes <rientjes@cs.washington.edu>
cc: "Ahmed S. Darwish" <darwish.07@gmail.com>, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc3] TTY_IO code cleanups
In-Reply-To: <Pine.LNX.4.64N.0701051559080.27059@attu4.cs.washington.edu>
Message-ID: <Pine.LNX.4.61.0701061537360.22558@yvahk01.tjqt.qr>
References: <20070105235604.GA24091@Ahmed> <Pine.LNX.4.64N.0701051559080.27059@attu4.cs.washington.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jan 5 2007 16:00, David Rientjes wrote:
>> @@ -791,17 +790,15 @@ static int tty_ldisc_try(struct tty_struct *tty)
>>  {
>>  	unsigned long flags;
>>  	struct tty_ldisc *ld;
>> -	int ret = 0;
>>  	
>>  	spin_lock_irqsave(&tty_ldisc_lock, flags);
>>  	ld = &tty->ldisc;
>> -	if(test_bit(TTY_LDISC, &tty->flags))
>> -	{
>> +	if(test_bit(TTY_LDISC, &tty->flags)) {
>>  		ld->refcount++;
>> -		ret = 1;
>> +		return 1;
>>  	}
>>  	spin_unlock_irqrestore(&tty_ldisc_lock, flags);
>> -	return ret;
>> +	return 0;
>>  }
>>  
>>  /**
>
>You leave tty_ldisk_lock locked.

Hence it was not redundant. Either way,

if(test_bit(...)) {
   spin_unlock_irqrestore(..)
   return 1;
}

would probably generate the same ASM as the original, hence it is not
really an improvement.


	-`J'
-- 
