Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751748AbWB0Tbi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748AbWB0Tbi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 14:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751744AbWB0Tbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 14:31:38 -0500
Received: from cantor2.suse.de ([195.135.220.15]:38874 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932098AbWB0Tbh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 14:31:37 -0500
To: Greg KH <greg@kroah.com>
Cc: gregkh@suse.de, Kay Sievers <kay.sievers@vrfy.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Add kernel<->userspace ABI stability documentation
References: <20060227190150.GA9121@kroah.com>
From: Andi Kleen <ak@suse.de>
Date: 27 Feb 2006 20:31:28 +0100
In-Reply-To: <20060227190150.GA9121@kroah.com>
Message-ID: <p7364n01tv3.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:

> Hi all,
> 
> As has been noticed recently by a lot of different people, it seems like
> we are breaking the userspace<->kernelspace interface a lot.  Well, in
> looking back over time, we always have been doing this, but no one seems
> to notice (proc files changing format and location, netlink library
> bindings, etc.)

Ok, but how do you plan to address the basic practical problem?
People cannot freely upgrade/downgrade kernels anymore since udev/hal
are used widely in distributions.

Does it imply you plan to change udev/hal to only use stable interfaces
for now? I would applaud such a move, but I guess it would come
at the cost of functionality.

If these applications are not changed then the documentation is likely useless
because it won't help anyways - things will still break, kernel
hackers and users will curse you all the time when they want
to test kernels etc.

> --- /dev/null
> +++ gregkh-2.6/Documentation/ABI/stable/syscalls
> @@ -0,0 +1,10 @@
> +What:		The kernel syscall interface
> +Description:
> +	This interface matches much of the POSIX interface and is based
> +	on it and other Unix based interfaces.  It will only be added to
> +	over time, and not have things removed from it.

Some ioctls and socket options unfortunately don't follow this. I
guess you will need to document them separately.

Could be ugly to have hundreds of files for ioctls though.
Perhaps define core ioctls and then driver ioctls and define
all the driver ioctls unstable by default? But that also
would just mean the category stable would be useless
because people always would need to use unstable interfaces
too.

> --- /dev/null
> +++ gregkh-2.6/Documentation/ABI/testing/sysfs-class
> @@ -0,0 +1,16 @@
> +What:		/sys/class/
> +Date:		Febuary 2006
> +Contact:	Greg Kroah-Hartman <gregkh@suse.de>
> +Description:
> +		The /sys/class directory will consist of a group of
> +		subdirectories describing individual classes of devices
> +		in the kernel.  The individual directories will consist
> +		of either subdirectories, or symlinks to other
> +		directories.
> +
> +		All programs that use this directory tree must be able
> +		to handle both subdirectories or symlinks in order to
> +		work properly.

What good is it if you don't say anything about the stability of its contents?
Looks far too vague to me.

-Andi
