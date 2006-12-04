Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937106AbWLDQeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937106AbWLDQeF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 11:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937099AbWLDQeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 11:34:05 -0500
Received: from smtp-out001.kontent.com ([81.88.40.215]:34924 "EHLO
	smtp-out.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937102AbWLDQeD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 11:34:03 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: race in sysfs between sysfs_remove_file() and read()/write() #2
Date: Mon, 4 Dec 2006 17:35:13 +0100
User-Agent: KMail/1.8
Cc: Maneesh Soni <maneesh@in.ibm.com>, gregkh@suse.com,
       linux-usb-devel@lists.sourceforge.net,
       kernel list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.0612041101410.3606-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0612041101410.3606-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612041735.13615.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 4. Dezember 2006 17:06 schrieb Alan Stern:
> On Mon, 4 Dec 2006, Maneesh Soni wrote:
> 
> > hmm, I guess Greg has to say the final word. The question is either to fail
> > the IO (-ENODEV) or fail the file removal (-EBUSY). If we are not going to
> > fail the removal then your patch is the way to go.
> > 
> > Greg?
> 
> Oliver is right that we cannot allow device_remove_file() to fail.  In 
> fact we can't even allow it to block until all the existing open file 
> references are closed.

Yes, we must have an upper bound with respect to time.

> Our major questions have to do with the details of the patch itself.  In 
> particular, we are worried about possible races with the VFS and the 
> handling of the inode's usage count.  Can you examine the patch carefully 
> to see if it is okay?
> 
> Also, Oliver, it looks like the latest version of your patch makes an 
> unnecessary change to sysfs_remove_file().

Code like:

int d(int a, int b)
{
	return a + b;
}

int c(int a, int b)
{
	return d(a, b);
}

is a detrimental to correct understanding and thence coding.
In fact reading sysfs source code is like jumping all around the kernel
tree. Such changes made it readable by normal people. I have to
understand which method I am coding on to do reasonable work. ;-)

	Regards
		Oliver
