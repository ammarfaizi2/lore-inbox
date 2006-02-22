Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751386AbWBVSh0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbWBVSh0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 13:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWBVShZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 13:37:25 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:41926
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751386AbWBVShX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 13:37:23 -0500
Date: Wed, 22 Feb 2006 10:37:31 -0800
From: Greg KH <greg@kroah.com>
To: Douglas Gilbert <dougg@torque.net>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: lsscsi-0.17 released
Message-ID: <20060222183731.GB12542@kroah.com>
References: <43FCA686.5020508@torque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FCA686.5020508@torque.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 12:59:34PM -0500, Douglas Gilbert wrote:
> Greg KH wrote:
> >>/sys/class/scsi_device/<hcil>/device/block symlink
> >>changed to ".../block:sd<x>" breaking lsscsi 0.16 (and
> >>earlier) and sg_map26 (in sg3_utils).
> 
> > It was changed as there would be more than one "block" symlink in a
> > device's directory if more than one block device was attached to a
> > single struct device.  For example, ub and multi-lun devices (there were
> > other reports of this happening for scsi devices too at the time from
> > what I remember.)
> 
> A "scsi_device" is a logical unit, hence the "l" at
> the end of the "<hcil>" acronym in the above path.
> So it wasn't broken. However there is some fuzziness
> in this area, for example the term "scsi_device".

Yes, but the block layer was not creating the proper symlink name, and
it would create multiple symlinks with the same name, in the same
directory, pointing to different places.  That had to be fixed, as it
was broken.  The block layer itself, has no way to determine if it is
using a scsi device, or another type of device, nor should it care.

thanks,

greg k-h
