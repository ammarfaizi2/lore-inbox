Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264532AbTCZEBW>; Tue, 25 Mar 2003 23:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264531AbTCZEBW>; Tue, 25 Mar 2003 23:01:22 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:24836 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264532AbTCZEBT>;
	Tue, 25 Mar 2003 23:01:19 -0500
Date: Tue, 25 Mar 2003 20:11:46 -0800
From: Greg KH <greg@kroah.com>
To: Pavel Roskin <proski@gnu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Preferred way to load non-free firmware
Message-ID: <20030326041146.GD20858@kroah.com>
References: <Pine.LNX.4.50.0303252007420.6656-100000@marabou.research.att.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0303252007420.6656-100000@marabou.research.att.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 25, 2003 at 08:32:50PM -0500, Pavel Roskin wrote:
> 
> 1) Register a file on procfs and use "cat" to load the firmware into the
> kernel.

That would work.

> 2) Register a device for the same purpose.
> 
> 3) Register a device, but use ioctl().
> 
> 4) Open a network socket and use ioctl() on it (like ifconfig does).

That's a nice way, as you don't need to register a device.

> 5) Use one of the the above ways to send the filename to the module and
> let the module load the firmware from file using do_generic_file_read().

Ick, I wouldn't recommend having the kernel do this, it's nicer to have
userspace do the firmware send.

> 6) Provide a script to wrap firmware into a module and load it using
> modprobe.

I don't think that this would be accepted into the main kernel tree, and
vendors might have a problem with it.

> 7) Encode the firmware into a header file, add it to the driver and
> pretend that the copyright issue doesn't exist (like it's done in the
> Keyspan USB driver).

Hey, that's the way I like doing this stuff :)

Almost any of the above would probably work well, and I think all except
#5 and #6 are currently done in the main kernel tree.

Good luck,

greg k-h
