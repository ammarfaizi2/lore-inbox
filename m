Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964977AbWKDJTv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964977AbWKDJTv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 04:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964975AbWKDJTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 04:19:51 -0500
Received: from mail.kroah.org ([69.55.234.183]:63619 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964913AbWKDJTu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 04:19:50 -0500
Date: Sat, 4 Nov 2006 00:22:28 -0800
From: Greg KH <greg@kroah.com>
To: Yu Luming <luming.yu@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       len.brown@intel.com, Matt Domsch <Matt_Domsch@dell.com>,
       Alessandro Guido <alessandro.guido@gmail.com>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       jengelh@linux01.gwdg.de, gelma@gelma.net, ismail@pardus.org.tr,
       Richard Hughes <hughsient@gmail.com>
Subject: Re: [patch 4/6] Add output class document
Message-ID: <20061104082228.GA30489@kroah.com>
References: <200611042122.00950.luming.yu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611042122.00950.luming.yu@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 04, 2006 at 09:22:00PM +0800, Yu Luming wrote:
> Add output class document
> 
> signed-off-by ? Luming.yu@gmail.com
> ---
> [patch 4/6] Add output class document
>  video-output.txt |   34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/Documentation/video-output.txt b/Documentation/video-output.txt
> new file mode 100644
> index 0000000..71b1dba
> --- /dev/null
> +++ b/Documentation/video-output.txt
> @@ -0,0 +1,34 @@
> +
> +		Video Output Switcher Control
> +		~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +		2006 luming.yu@gmail.com
> +
> +The output sysfs class driver is to provide video output abstract layer that 
> +can be used to hook platform specific methods to enable/disable video output
> +device through common sysfs interface. For example, on my IBM Thinkpad T42 
> +aptop, acpi video driver registered its output devices and read/write method
> +for state with output sysfs class. The user interface under sysfs is :
> +
> +linux:/sys/class/video_output # tree .
> +.
> +|-- CRT0
> +|   |-- device -> ../../../devices/pci0000:00/0000:00:01.0
> +|   |-- state
> +|   |-- subsystem -> ../../../class/video_output
> +|   `-- uevent
> +|-- DVI0
> +|   |-- device -> ../../../devices/pci0000:00/0000:00:01.0
> +|   |-- state
> +|   |-- subsystem -> ../../../class/video_output
> +|   `-- uevent
> +|-- LCD0
> +|   |-- device -> ../../../devices/pci0000:00/0000:00:01.0
> +|   |-- state
> +|   |-- subsystem -> ../../../class/video_output
> +|   `-- uevent
> +`-- TV0
> +   |-- device -> ../../../devices/pci0000:00/0000:00:01.0
> +   |-- state
> +   |-- subsystem -> ../../../class/video_output
> +   `-- uevent

Use a struct device instead of a struct class_device please.  That will
change your tree a bit here (you will have symlinks at the top level.

Have you been working with the X developers that have been doing a lot
of work in describing and interacting with these different video
devices?  I think you might want to work with them so that you don't
create an interface that will not be used by them.

thanks,

greg k-h
