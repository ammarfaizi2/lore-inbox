Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751873AbWCIN1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873AbWCIN1U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 08:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751878AbWCIN1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 08:27:20 -0500
Received: from mx1.redhat.com ([66.187.233.31]:60649 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751873AbWCIN1T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 08:27:19 -0500
Date: Thu, 9 Mar 2006 08:26:55 -0500
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>,
       linux-kernel@vger.kernel.org, Max Asbock <masbock@us.ibm.com>,
       Vernon Mauery <vernux@us.ibm.com>
Subject: Re: Oops on ibmasm
Message-ID: <20060309132655.GA26354@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>,
	Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>,
	linux-kernel@vger.kernel.org, Max Asbock <masbock@us.ibm.com>,
	Vernon Mauery <vernux@us.ibm.com>
References: <20060308224145.47332.qmail@web52607.mail.yahoo.com> <20060309014023.2caa42d2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060309014023.2caa42d2.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2006 at 01:40:23AM -0800, Andrew Morton wrote:

 > I assume this'll fix it?
 > 
 > I suspect there's no point in the locking around that kobject_put() anyway.
 > Or if there is, it wasn't the right way to fix the race.
 > 
 > diff -puN drivers/misc/ibmasm/ibmasm.h~ibmasm-use-after-free-fix drivers/misc/ibmasm/ibmasm.h
 > --- devel/drivers/misc/ibmasm/ibmasm.h~ibmasm-use-after-free-fix	2006-03-09 01:35:05.000000000 -0800
 > +++ devel-akpm/drivers/misc/ibmasm/ibmasm.h	2006-03-09 01:35:16.000000000 -0800
 > @@ -100,11 +100,7 @@ struct command {
 >  
 >  static inline void command_put(struct command *cmd)
 >  {
 > -	unsigned long flags;
 > -
 > -	spin_lock_irqsave(cmd->lock, flags);
 >          kobject_put(&cmd->kobj);
 > -	spin_unlock_irqrestore(cmd->lock, flags);
 >  }

I don't think this is right.  This is just a kobject-convoluted
use-after-free afaics.

		Dave

-- 
http://www.codemonkey.org.uk
