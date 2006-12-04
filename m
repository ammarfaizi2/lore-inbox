Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758398AbWLDRdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758398AbWLDRdZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 12:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758558AbWLDRdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 12:33:24 -0500
Received: from smtp-out001.kontent.com ([81.88.40.215]:35484 "EHLO
	smtp-out.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758398AbWLDRdX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 12:33:23 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: race in sysfs between sysfs_remove_file() and read()/write() #2
Date: Mon, 4 Dec 2006 18:34:33 +0100
User-Agent: KMail/1.8
Cc: Maneesh Soni <maneesh@in.ibm.com>, gregkh@suse.com,
       linux-usb-devel@lists.sourceforge.net,
       kernel list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.0612041153160.3642-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0612041153160.3642-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612041834.34355.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 4. Dezember 2006 17:57 schrieb Alan Stern:

> I was referring to sysfs_remove_file(), not sysfs_open_file() -- I agree 
> that getting rid of the check_perm() routine is good.  But this isn't:
> 
> >  void sysfs_remove_file(struct kobject * kobj, const struct attribute * attr)
> >  {
> > -       sysfs_hash_and_remove(kobj->dentry,attr->name);
> > +       struct dentry *d = kobj->dentry;
> > +
> > +       sysfs_hash_and_remove(d, attr->name);
> >  }
> 
> There's no apparent advantage to introducing the local variable d, either 
> in terms of execution speed or readability.  (Although the original source 
> line should have a space after the comma.)

Yes, correct, it is a remainder of using the dentry twice in that routine.
Then a local variable saved a recomputation. I can redo it, sorry.
However, it doesn't affect correctness, so I won't distract further by
doing an essentially cosmetic change.

	Regards
		Oliver
