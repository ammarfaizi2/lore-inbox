Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbUBYR30 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 12:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261461AbUBYR30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 12:29:26 -0500
Received: from lists.us.dell.com ([143.166.224.162]:40420 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S261471AbUBYR3X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 12:29:23 -0500
Date: Wed, 25 Feb 2004 11:28:39 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: "'Christoph Hellwig'" <hch@infradead.org>, "Mukker, Atul" <Atulm@lsil.com>,
       "'Arjan van de Ven'" <arjanv@redhat.com>,
       "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       "'Paul Wagland'" <paul@wagland.net>, Matthew Wilcox <willy@debian.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>
Subject: Re: [SUBJECT CHANGE]: megaraid unified driver version 2.20.0.0-alpha1
Message-ID: <20040225112839.A14838@lists.us.dell.com>
References: <0E3FA95632D6D047BA649F95DAB60E57033BC3E2@exa-atlanta.se.lsil.com> <20040225131640.A3966@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040225131640.A3966@infradead.org>; from hch@infradead.org on Wed, Feb 25, 2004 at 01:16:40PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 25, 2004 at 01:16:40PM +0000, 'Christoph Hellwig' wrote:
> On Tue, Feb 24, 2004 at 07:34:01PM -0500, Mukker, Atul wrote:
> > 2.	Controller and device re-ordering on both lk 2.4 and lk 2.6. If this
> > is not desired, the driver code would be modified to make it PCI ordered
> > detection. The driver also re-orders the drives, based on which one is
> > chosen as boot drive. Matt, please add your comments here.
> 
> This is a bad thing for 2.6, don't do it.  For 2.4 just leave the probe code as
> it is there currently - any change during the stable series just confuses
> users.

I agree with Christoph here.  megaraid is the only driver that I've
worked with that does this device reordering thing; none of the other
SCSI drivers we use regularly does, and it's not a feature that I've
advertised to customers when they come asking.  It would help greatly
if the firmware could export unique numbers akin to SCSI inquiry page
83 for each logical drive on each controller, such that we could
actually use udev and friends well.  I've asked for this feature for
several years, and I know it's not yet on the firmware roadmaps.

The list of PCI devices should be ordered in two buckets: ROMBs first,
then add in cards; secondarily, oldest to newest.  We do this with
aacraid today.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
