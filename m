Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286179AbSBITzc>; Sat, 9 Feb 2002 14:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286161AbSBITzS>; Sat, 9 Feb 2002 14:55:18 -0500
Received: from pD950EABC.dip.t-dialin.net ([217.80.234.188]:1926 "EHLO
	oenone.homelinux.org") by vger.kernel.org with ESMTP
	id <S286179AbSBITyF>; Sat, 9 Feb 2002 14:54:05 -0500
Message-Id: <200202092053.g19Kre705325@oenone.homelinux.org>
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.org>
To: Gerd Knorr <kraxel@bytesex.org>,
        Kernel List <linux-kernel@vger.kernel.org>,
        video4linux list <video4linux-list@redhat.com>
Subject: Re: [PATCH/RFC] videodev.[ch] redesign
Date: Sat, 9 Feb 2002 21:53:17 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020209194602.A23061@bytesex.org>
In-Reply-To: <20020209194602.A23061@bytesex.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 09 February 2002 19:46, Gerd Knorr wrote:
>   Hi,
>

> The patch below does part one of the plan -- for 2.4.x kernels.  It adds
> the fops pointer to struct video_device and makes video_open use it if
> available, so both old + new style drivers will work.
>
> It also provides a ioctl wrapper function which handles copying the
> ioctl args from/to userspace, so we have this at one place can drop all
> the copy_from/to_user calls within the v4l device driver ioctl handlers.

That is a large improvement.
But you don't include a lock against reentry, which is bad.

> Comments?

Could you make a helper for open like for ioctl ?
And please don't use a pointer to the device descriptor
in the file structure. It makes live for USB devices much harder.

	Regards
		Oliver
