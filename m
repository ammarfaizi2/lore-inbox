Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261463AbUK1NTZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbUK1NTZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 08:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbUK1NTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 08:19:25 -0500
Received: from neopsis.com ([213.239.204.14]:48807 "EHLO
	matterhorn.neopsis.com") by vger.kernel.org with ESMTP
	id S261463AbUK1NTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 08:19:09 -0500
Message-ID: <41A9D093.4090908@dbservice.com>
Date: Sun, 28 Nov 2004 14:20:19 +0100
From: Tomas Carnecky <tom@dbservice.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: viro@parcelfarce.linux.theplanet.co.uk, ecki-news2004-05@lina.inka.de,
       linux-kernel@vger.kernel.org
Subject: Re: Problem with ioctl command TCGETS
References: <E1CYMI9-0005PL-00@calista.eckenfels.6bone.ka-ip.net> <E1CYN7z-0001bZ-00@dorka.pomaz.szeredi.hu> <20041128121800.GZ26051@parcelfarce.linux.theplanet.co.uk> <E1CYODw-0001jf-00@dorka.pomaz.szeredi.hu> <20041128124847.GA26051@parcelfarce.linux.theplanet.co.uk> <E1CYOXh-0001nn-00@dorka.pomaz.szeredi.hu>
In-Reply-To: <E1CYOXh-0001nn-00@dorka.pomaz.szeredi.hu>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Neopsis-MailScanner-Information: Please contact the ISP for more information
X-Neopsis-MailScanner: Found to be clean
X-MailScanner-From: tom@dbservice.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi wrote:
>>>>Think read(2)/write(2).  We already have several barfbags too many,
>>>>and that includes both ioctl() and setsockopt().  We are stuck with
>>>>them for compatibility reasons, but why the hell would we need yet
>>>>another one?
>>>
>>>You can't replace either ioctl() or setsockopt() with read/write can
>>>you?  Both of them set out-of-band information on file descriptors.
>>
>>Out-of-band == should be on a separate channel...
> 
> 
> Tell me how?  E.g. how would you set/get sound stream parameters if
> not with ioctl()?
> 

Maybe using sysfs? /sys/device/cdrom/param ?
But then you'd have to open another file :(

And what about somethink like:
cdrom_fd = open("/dev/cdrom", O_RDWR)
cdrom_param_fd = get_param_fd(cdrom_fd) /* a new syscall */
Now read/write to this param fd.
And two new entries in the struct file_operations:
write_param([same args as write])
read_param([same args as read])

tom
