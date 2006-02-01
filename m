Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030209AbWBACog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030209AbWBACog (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 21:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030217AbWBACog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 21:44:36 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:49076 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030209AbWBACof (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 21:44:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=EOKzYY1dAwvZABQiwKgdJZoHcsBLR1nj4g9/sMFS9UE1xL4Op2Q4r2aMyqPi8nmMZn6R/GtEItIQU3XSJsKOEV7Hvg6XybYynFnGjGHNSJtMIQGmxUF6L/vzuQkjPNyB4ih50u0CrxOQC/tAy1q4H1C/sgdZ3ih/5Z/W91pLZS4=
Date: Wed, 1 Feb 2006 11:44:29 +0900
From: Tejun Heo <htejun@gmail.com>
To: tronic+bpsk@trn.iki.fi
Cc: linux-kernel@vger.kernel.org
Subject: Re: Libata, bug 5700.
Message-ID: <20060201024429.GA19395@htj.dyndns.org>
References: <43DB5BE5.8050900@trn.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43DB5BE5.8050900@trn.iki.fi>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2006 at 01:56:21PM +0200, Lasse K??rkk??inen / Tronic wrote:
> http://bugzilla.kernel.org/show_bug.cgi?id=5700
> 
> I reported this bug a while back, but it hasn't received any feedback.
> Jeff Garzik didn't respond to the email that I sent to him either. What's up?
> 

Hello, Lasse.

Can you please apply the following patch and report the result?  It
seems that your drive/controller times once in a while and the timed
out command gets completed twice somehow.  The following patch will
show us what's completing it the second time.  Also, posting full
kernel log will be helpful too.  Among other things, I'm curious
whether there were any recovered timeouts before.

diff --git a/include/linux/libata.h b/include/linux/libata.h
index 41ea7db..28f247a 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -68,6 +68,7 @@
         if(unlikely(!(expr))) {                                   \
         printk(KERN_ERR "Assertion failed! %s,%s,%s,line=%d\n", \
         #expr,__FILE__,__FUNCTION__,__LINE__);          \
+        dump_stack(); \
         }
 #endif
 

