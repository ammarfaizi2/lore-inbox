Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262517AbVCIXFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262517AbVCIXFV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 18:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262292AbVCIWys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 17:54:48 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:50056 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S262503AbVCIV6D convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 16:58:03 -0500
From: Kristian =?utf-8?q?S=C3=B8rensen?= <ks@cs.aau.dk>
Organization: Aalborg University
To: Bob Bennett <robert.bennett@ca.com>
Subject: Re: Reading large /proc entry from kernel module
Date: Wed, 9 Mar 2005 22:59:13 +0100
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <200503081445.56237.ks@cs.aau.dk> <loom.20050309T161017-339@post.gmane.org>
In-Reply-To: <loom.20050309T161017-339@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200503092259.14063.ks@cs.aau.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 March 2005 16:17, Bob Bennett wrote:
> Kristian Sørensen <ks <at> cs.aau.dk> writes:
> > Hi all!
> >
> > I have some trouble reading a 2346 byte /proc entry from our Umbrella
> > kernel module.
> >
> > 	if (count != UMB_POLICY_SIZE) {
> > 		printk("Umbrella: Error - /proc/umbrella is of invalid size\n");
> > 		return -EFAULT;
> >
> > 	if (copy_from_user(lbuf, buffer, count)) {
> > 		kfree(lbuf);
> > 		kfree(policy);
> > 		return -EFAULT;
> > 	}
> >
> > 	strcpy(policy, lbuf);
> > 	umb_parse_proc(policy);
> >
> > }
> >
> >
> > Now that everything works, I want to write a string of excactly 2346
> > characters to the /proc/umbrella file. However when I make the
> > copy_from_user, I only get the first 1003 characters (
> > - Do you have a pointer to where I do this thing wrong?
> >
> > What is the limit regarding the size of writing a /proc entry? (we
> > consider importing binary public keys to the kernel this way in the
> > future).
> >
> > Best regards,
> > Kristian.
>
> What makes you think you only have 1003 bytes?  If UMB_POLICY_SIZE is
> defined as 2346, then user space must have written that amount.  Probably
> the problem is that you used strcpy() to copy the data from lbuf to policy,
> and there is a null character after 1003 bytes.  It is an unnecessary extra
> step to allocate two buffers (lbuf & policy) and copy data from one to the
> other.  Why not just pass lbuff to umb_parse_proc()??
You are right - that does not make sense having both the buffers :-)))

The input that I write to the /proc/umbrella file is stored in a file in 
usermode Linux... Can the '\0' be hidden somewhere in the text file - even 
though everything looks normal in the vi editor?

Thanks for your answer!

Cheers, Kristian.

-- 
Kristian Sørensen
E-mail: ipqw@users.sf.net
