Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264445AbTEPO17 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 10:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264451AbTEPO17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 10:27:59 -0400
Received: from smtp4.wanadoo.fr ([193.252.22.26]:894 "EHLO
	mwinf0502.wanadoo.fr") by vger.kernel.org with ESMTP
	id S264445AbTEPO16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 10:27:58 -0400
From: Duncan Sands <baldrick@wanadoo.fr>
To: chas williams <chas@locutus.cmf.nrl.navy.mil>, Greg KH <greg@kroah.com>,
       davem@redhat.com
Subject: Re: [PATCH][ATM] add reference counting to atm_dev
Date: Fri, 16 May 2003 16:40:43 +0200
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <200305151432.h4FEW5Gi012599@locutus.cmf.nrl.navy.mil>
In-Reply-To: <200305151432.h4FEW5Gi012599@locutus.cmf.nrl.navy.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305161640.43804.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 May 2003 16:32, chas williams wrote:
> In message <20030515052041.GA5995@kroah.com>,Greg KH writes:
> >It's not really bothering me, just wondering when it will go away (I see
> >it when building one of the USB ATM drivers...)
>
> the MOD_* functions in the speedtch driver don't need to be there.
> since 2.3.something (if i remember correctly) the reference counting
> has been handled by the upper layer (ala fops_get/fops_put).  the
> following patch removes these extra bits:

Hi Chas, thanks for the patch.  I agree that it is correct.  However,
I was wondering about ioctl and proc calls.  Can the ATM layer call
a driver's ioctl routine before opening a vcc?  If so, does it take a
reference to the module first (I didn't spot anything)?  Also, are
calls to a driver's proc_read routine protected against module
unloading races (I confess I didn't take the time to look into this,
because my own driver does not sleep in proc_read)?

All the best,

Duncan.
