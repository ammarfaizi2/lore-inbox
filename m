Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751207AbVIVWEH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbVIVWEH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 18:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbVIVWEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 18:04:07 -0400
Received: from xenotime.net ([66.160.160.81]:22964 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751206AbVIVWEE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 18:04:04 -0400
Date: Thu, 22 Sep 2005 15:04:02 -0700 (PDT)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Christopher Friesen <cfriesen@nortel.com>
cc: Sonny Rao <sonny@burdell.org>, dipankar@in.ibm.com,
       Al Viro <viro@ftp.linux.org.uk>, Roland Dreier <rolandd@cisco.com>,
       linux-kernel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
       bharata@in.ibm.com, trond.myklebust@fys.uio.no
Subject: Re: dentry_cache using up all my zone normal memory -- also seen on
 2.6.14-rc2
In-Reply-To: <43332854.1070108@nortel.com>
Message-ID: <Pine.LNX.4.58.0509221501490.20059@shark.he.net>
References: <4331CFAD.6020805@nortel.com> <52ll1qkrii.fsf@cisco.com>
 <20050922031136.GE7992@ftp.linux.org.uk> <43322AE6.1080408@nortel.com>
 <20050922041733.GF7992@ftp.linux.org.uk> <4332CAEA.1010509@nortel.com>
 <20050922182719.GA4729@in.ibm.com> <4332FFF5.5060207@nortel.com>
 <20050922191805.GB4729@in.ibm.com> <43332400.2070606@nortel.com>
 <20050922214435.GA31911@kevlar.burdell.org> <43332854.1070108@nortel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Sep 2005, Christopher Friesen wrote:

> Sonny Rao wrote:
>
> > I think your loglevel is too low, set it to seven (using sysrq if
> > necessary) and try again.
>
> I thought the following __handle_sysrq() code would take care of that:
>
> 	spin_lock_irqsave(&sysrq_key_table_lock, flags);
> 	orig_log_level = console_loglevel;
> 	console_loglevel = 7;
> 	printk(KERN_INFO "SysRq : ");

Some code below there is suspicious.  Maybe you could modify
some of it...

(cut-and-paste, may have whitespace damage:)

		if (!check_mask || sysrq_enabled == 1 ||
		    (sysrq_enabled & op_p->enable_mask)) {
			printk ("%s\n", op_p->action_msg);
			console_loglevel = orig_log_level;
			op_p->handler(key, pt_regs, tty);
		}

swap those last 2 lines and see what happens...

-- 
~Randy
