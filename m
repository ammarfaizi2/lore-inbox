Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751378AbWBVROo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbWBVROo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 12:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbWBVROn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 12:14:43 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:18321
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751140AbWBVROm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 12:14:42 -0500
Date: Wed, 22 Feb 2006 09:14:39 -0800
From: Greg KH <greg@kroah.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Douglas Gilbert <dougg@torque.net>,
       Matthias Andree <matthias.andree@gmx.de>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: lsscsi-0.17 released
Message-ID: <20060222171438.GA20272@kroah.com>
References: <43FBA4CD.6000505@torque.net> <m34q2r93q2.fsf@merlin.emma.line.org> <43FC7CCB.4090508@torque.net> <20060222160602.GB17473@merlin.emma.line.org> <43FC90E4.10805@torque.net> <20060222163426.GG28587@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060222163426.GG28587@parisc-linux.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 09:34:26AM -0700, Matthew Wilcox wrote:
> On Wed, Feb 22, 2006 at 11:27:16AM -0500, Douglas Gilbert wrote:
> > Matthias Andree wrote:
> > > On Wed, 22 Feb 2006, Douglas Gilbert wrote: 
> > >>Matthias Andree wrote:
> > >>>Does this work around new incompatibilities in the kernel
> > >>>or does this fix lsscsi bugs?
> > >>
> > >>The former. In lk 2.6.16-rc1 the
> > >>/sys/class/scsi_device/<hcil>/device/block symlink
> > >>changed to ".../block:sd<x>" breaking lsscsi 0.16 (and
> > >>earlier) and sg_map26 (in sg3_utils).
> > > 
> > > Heck, what was the reason for breaking userspace again?
> > 
> > Maybe the person responsible can answer. I'm only reacting
> > to a change that broke two of my utilities.
> 
> Probably better to cc the person responsible if you want an answer.

It was changed as there would be more than one "block" symlink in a
device's directory if more than one block device was attached to a
single struct device.  For example, ub and multi-lun devices (there were
other reports of this happening for scsi devices too at the time from
what I remember.)

So, in that case, your tool would have been broken anyway, so this fix
was required to make it correct :)

The fix was to make block devices work the same way as all other class
devices, which had this fix a while ago.

thanks,

greg k-h
