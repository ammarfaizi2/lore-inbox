Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263363AbTIWOHm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 10:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263361AbTIWOHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 10:07:42 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:31150 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263366AbTIWOHl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 10:07:41 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: viro@parcelfarce.linux.theplanet.co.uk,
       Joe Thornber <ethornber@yahoo.co.uk>
Subject: Re: [PATCH] DM 1/6: Use new format_dev_t macro
Date: Tue, 23 Sep 2003 09:07:02 -0500
User-Agent: KMail/1.5
Cc: torvalds@osdl.org, akpm@zip.com.au, LKML <linux-kernel@vger.kernel.org>
References: <20030922192909.GG7665@parcelfarce.linux.theplanet.co.uk> <877B4BDE-ED9B-11D7-BE69-000393CA5730@yahoo.co.uk> <20030923075736.GK7665@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20030923075736.GK7665@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309230907.02375.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 23 September 2003 02:57, viro@parcelfarce.linux.theplanet.co.uk 
wrote:
> On Tue, Sep 23, 2003 at 08:57:07AM +0100, Joe Thornber wrote:
> > On Monday, September 22, 2003, at 08:29 PM,
> >
> > viro@parcelfarce.linux.theplanet.co.uk wrote:
> > >On Mon, Sep 22, 2003 at 10:51:27AM -0500, Kevin Corry wrote:
> > >>Use the format_dev_t function for target status functions.
> > >
> > >[instead of bdevname, that is]
> > >
> > >It's wrong.  Simply because "sdb3" is immediately parsed by admin and
> > >08:13 is nowhere near that convenient.  These are error messages, let's
> > >keep them readable.
> >
> > No they are not just error messages, userland tools use them.
>
> In which case the change in question would break said userland tools,
> wouldn't it?

No, actually this change brings the status info back in-line with how the 2.4 
version of DM behaves. A while back the bdevname() function changed to return 
a text name (it used to return a major:minor, similar to kdevname in 2.4). In 
many cases the only way to make any sense of this text name is to search 
around in sysfs for a matching entry (provided, of course, that sysfs is 
mounted, which many people still don't realize they should be doing. :) And 
if you find that entry in sysfs, the info you're really looking for is in the 
"dev" file, whose contents are displayed using format_dev_t().

-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net/

