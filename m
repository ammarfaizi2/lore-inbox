Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291582AbSBAHX7>; Fri, 1 Feb 2002 02:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291585AbSBAHXu>; Fri, 1 Feb 2002 02:23:50 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:8202 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S291582AbSBAHXh>;
	Fri, 1 Feb 2002 02:23:37 -0500
Date: Thu, 31 Jan 2002 23:22:02 -0800
From: Greg KH <greg@kroah.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Werner Almesberger <wa@almesberger.net>,
        "Erik A. Hendriks" <hendriks@lanl.gov>
Subject: Re: [RFC] x86 ELF bootable kernels/Linux booting Linux/LinuxBIOS
Message-ID: <20020201072201.GA5666@kroah.com>
In-Reply-To: <m1zo2vb5rt.fsf@frodo.biederman.org> <8200.1012446189@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8200.1012446189@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Fri, 04 Jan 2002 05:11:17 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 02:03:09PM +1100, Keith Owens wrote:
> On 30 Jan 2002 19:42:14 -0700, 
> ebiederm@xmission.com (Eric W. Biederman) wrote:
> >I like the other suggestion of extending the Hot-plug infrastructure.
> >In that case I just need to figure out how to logically Hot-unplug all
> >the devices in the system.  That may be better than a
> >do_exitcalls()...  As it automatically gets the discrimination right. 
> 
> In an ideal world, it should be enough to call the module_exit()
> functions in reverse order to the module_init(), LIFO.  But check with
> the hotplug list, they have done most of the work on this problem.

Actually, no we haven't :)

We punt on the "do we remove the driver when the device disappears"
issue, and instead ignore the hotplug REMOVE events right now.

So far, no one's complained.

But to unplug all of the devices in the system in the proper order,
you're probably going to have to use the driverfs tree that is slowly
taking shape.  That's the only representation of all physical devices in
the system that shows the topology correctly.

Hope this helps,

greg k-h
