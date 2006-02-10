Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751098AbWBJFQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbWBJFQa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 00:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbWBJFQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 00:16:30 -0500
Received: from ms-smtp-05-smtplb.tampabay.rr.com ([65.32.5.135]:21713 "EHLO
	ms-smtp-05.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S1751098AbWBJFQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 00:16:29 -0500
Message-ID: <43EC218A.9000402@cfl.rr.com>
Date: Fri, 10 Feb 2006 00:15:54 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Mail/News 1.5 (X11/20060119)
MIME-Version: 1.0
To: "Darrick J. Wong" <djwong@us.ibm.com>
CC: dm-devel@redhat.com, Chris McDermott <lcm@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Support HDIO_GETGEO on device-mapper volumes
References: <43EBEDD0.60608@us.ibm.com>
In-Reply-To: <43EBEDD0.60608@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hrm... when I setup my system on a dmraid controlled hardware fakeraid 
raid-0, I just gave grub a suitable geometry command since it couldn't 
auto detect it.  I suppose this would make that unnecessary.

I think that ultimately, grub shouldn't care about the geometry since 
that information has been obsolete for years.  If it can't detect the 
geometry, then it should just assume the system supports LBA and to hell 
with using made up geometry numbers.


Darrick J. Wong wrote:
> Hi again,
> 
> I'm trying to install grub on a device-mapper RAID1 array that I set up 
> via dmraid (in other words, a bootable software fakeraid).  Since dm 
> doesn't implement the HDIO_GETGEO ioctl, grub assumes that the CHS 
> geometry is 620/128/63, which makes it impossible to configure it to 
> boot a filesystem that lives beyond the 2GB mark, even if the system 
> BIOS supports that.
> 
> The attached patch implements a simple ioctl handler that supplies a 
> compatible geometry when HDIO_GETGEO is called against a device-mapper 
> device.  Its behavior is somewhat similar to what sd_mod does if the 
> scsi controller doesn't provide its own geometry.  Granted, the notion 
> of cylinders, heads and sectors is silly on a RAID array, but with this 
> patch, interested programs can obtain CHS data that's somewhat close to 
> correct; this seems to be a better option than having each program make 
> up its own potentially different geometry, or making an arbitrary guess. 
>  Assuming that all of the programs that need to know CHS geometry will 
> query the kernel via HDIO_GETGEO, this patch makes it so that all of 
> those programs end up using the same geometry.
> 
> The patch applies cleanly against 2.6.15.3; if there aren't any 
> objections then I'm submitting this for upstream.  However, I'm all ears 
> for suggestions.
> 
> Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
> 
> --Darrick
> 

