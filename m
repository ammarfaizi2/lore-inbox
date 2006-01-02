Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751054AbWABUfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbWABUfe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 15:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbWABUfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 15:35:33 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:4496 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751037AbWABUfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 15:35:33 -0500
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH 0 of 20] [RFC] ipath - PathScale InfiniPath driver
References: <patchbomb.1135816279@eng-12.pathscale.com>
	<20051230080002.GA7438@kroah.com>
	<1135984304.13318.50.camel@serpentine.pathscale.com>
	<20051231001051.GB20314@kroah.com>
	<1135993250.13318.94.camel@serpentine.pathscale.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 02 Jan 2006 13:35:07 -0700
In-Reply-To: <1135993250.13318.94.camel@serpentine.pathscale.com> (Bryan
 O'Sullivan's message of "Fri, 30 Dec 2005 17:40:50 -0800")
Message-ID: <m1irt25pxg.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Bryan O'Sullivan" <bos@pathscale.com> writes:

> On Fri, 2005-12-30 at 16:10 -0800, Greg KH wrote:
>
>> But we (the kernel community), don't really accept that as a valid
>> reason to accept this kind of code, sorry.
>
> Fair enough.  I'd like some guidance in that case.  Some of our ioctls
> access the hardware more or less directly, while others do things like
> read or reset counters.

As a general rule a driver should push as much functionality to
libraries and the infrastructure code as possible. 

> Which of these kinds of operations are appropriate to retain as ioctls,
> in your eyes, and which are best converted to sysfs or configfs
> alternatives?
>
> As an example, take a look at ipath_sma_ioctl.  It seems to me that
> receiving or sending subnet management packets ought to remain as
> ioctls, while getting port or node data could be turned into sysfs
> attributes.  Lane identification could live in configfs.  If you think
> otherwise, please let me know what's more appropriate.

I haven't looked closely enough at the state of the openib tree but
you should not need an additional interface to send/receive standard
IB subnet management packets.  That is something that should be provided
the same way by all infiniband drivers.

The only case I can think of where this might not already exist
is the code that responds to the subnet manager.  If the current
interfaces are not sufficient then the infiniband layer needs
more work.

> The less blind I am in doing these conversions, the fewer rounds we'll
> have to go in reviewing humongous driver submission patches :-)

Given Linus's comments and looking at where you are getting stuck I
would recommend you split out support for the nonstandard ipath
protocol from the rest of the driver.  If the standard infiniband
interfaces for kernel bypass are not sufficient for flinging packets
then we need to re-examine them.

Eric
