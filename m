Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262316AbVCITV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262316AbVCITV6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 14:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262189AbVCITQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 14:16:59 -0500
Received: from main.gmane.org ([80.91.229.2]:9700 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262393AbVCITOa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 14:14:30 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Bob Bennett <robert.bennett@ca.com>
Subject: Re: Reading large /proc entry from kernel module
Date: Wed, 9 Mar 2005 15:17:07 +0000 (UTC)
Message-ID: <loom.20050309T161017-339@post.gmane.org>
References: <200503081445.56237.ks@cs.aau.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 141.202.248.11 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030821)
X-Gmane-MailScanner: Found to be clean
X-Gmane-MailScanner: Found to be clean
X-MailScanner-From: glk-linux-kernel@m.gmane.org
X-MailScanner-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kristian Sørensen <ks <at> cs.aau.dk> writes:

> 
> Hi all!
> 
> I have some trouble reading a 2346 byte /proc entry from our Umbrella kernel 
> module.

> 	if (count != UMB_POLICY_SIZE) {
> 		printk("Umbrella: Error - /proc/umbrella is of invalid size\n");
> 		return -EFAULT;

> 	if (copy_from_user(lbuf, buffer, count)) {
> 		kfree(lbuf);
> 		kfree(policy);
> 		return -EFAULT;
> 	}
> 
> 	strcpy(policy, lbuf);
> 	umb_parse_proc(policy);
> 
> }
> 

> Now that everything works, I want to write a string of excactly 2346 
> characters to the /proc/umbrella file. However when I make the 
> copy_from_user, I only get the first 1003 characters (
> - Do you have a pointer to where I do this thing wrong?
> 
> What is the limit regarding the size of writing a /proc entry? (we consider 
> importing binary public keys to the kernel this way in the future).
> 
> Best regards,
> Kristian.
> 

What makes you think you only have 1003 bytes?  If UMB_POLICY_SIZE is defined as
2346, then user space must have written that amount.  Probably the problem is
that you used strcpy() to copy the data from lbuf to policy, and there is a null
character after 1003 bytes.  It is an unnecessary extra step to allocate two
buffers (lbuf & policy) and copy data from one to the other.  Why not just pass
lbuff to umb_parse_proc()??

Regards,
   Bob Bennett

