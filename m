Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752077AbWJNFMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077AbWJNFMU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 01:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932093AbWJNFMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 01:12:19 -0400
Received: from hera.kernel.org ([140.211.167.34]:8171 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1752077AbWJNFMS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 01:12:18 -0400
From: Len Brown <len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: Dave Jones <davej@redhat.com>
Subject: Re: patch [0/2]: acpi: add generic removable drive bay support
Date: Sat, 14 Oct 2006 01:13:37 -0400
User-Agent: KMail/1.8.2
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>,
       Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org
References: <20060907161305.67804d14.kristen.c.accardi@intel.com> <20060908132123.16137ea3.kristen.c.accardi@intel.com> <20060908203310.GM28592@redhat.com>
In-Reply-To: <20060908203310.GM28592@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610140113.37934.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 September 2006 16:33, Dave Jones wrote:
> On Fri, Sep 08, 2006 at 01:21:23PM -0700, Kristen Carlson Accardi wrote:
>  > On Fri, 8 Sep 2006 20:58:42 +0100
>  > Matthew Garrett <mjg59@srcf.ucam.org> wrote:
>  > 
>  > > > can then be used by udev to unmount or rescan depending on the event.  It will
>  > > > create a proc entry under /proc/acpi/bay for "eject" and for "status".  Writing 
>  > > 
>  > > Do we really want it under /proc? It would seem to make more sense for 
>  > > it to be under /sys.
>  > 
>  > I agree - this is under proc because this is an acpi driver, and the acpi
>  > subsystem is still using the /proc fs for driver/user space interface. I
>  > thought I would just conform to their standard.
> 
> It's my understanding from talking with Len that he'd like to see /proc/acpi/
> go away over time, so adding more to it seems to be at odds with that goal.

Dave is right.  We've had a moratorium on new files under /proc/acpi for some time now.
The reason is that user-space should not know or care that something is supplied
by ACPI -- for on other systems it may be supplied by something else.

So new stuff should have generic names under sys -- even if on a large body of
systems the functionality beneath happens to be  supplied via ACPI.

an example of old is the brightness stuff under /proc/acpi and in various platform
specific drivers that scribble under /proc/acpi.
The corresponding example of new is the backlight I/F under /sys.

thanks,
-Len
