Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278673AbRJ1U5z>; Sun, 28 Oct 2001 15:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278668AbRJ1U5o>; Sun, 28 Oct 2001 15:57:44 -0500
Received: from smtp03.uc3m.es ([163.117.136.123]:20491 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S278672AbRJ1U5b>;
	Sun, 28 Oct 2001 15:57:31 -0500
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200110282057.f9SKvxo15573@oboe.it.uc3m.es>
Subject: Re: Poor floppy performance in kernel 2.4.10
In-Reply-To: <200110282040.f9SKe6M02113@hitchhiker.org.lu> from "Alain Knaff"
 at "Oct 28, 2001 09:40:05 pm"
To: alain@linux.lu
Date: Sun, 28 Oct 2001 21:57:59 +0100 (MET)
Cc: "linux kernel" <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Alain Knaff wrote:"
> Appended to this mail is the "long live the struct block_device"
> patch. It includes the stuff covered in the last patch as well. The
> issue of stopping transfers in progress is not yet addressed.

Errr .. haven't read the patches. But are you doing something so that
the semantics of the action taken after a media check fails can
be overridden? The current invalidate_inodes is too strong for me,
since I am proxying a remote device, and I don't want to kill 
_all_ the local file descriptors when the remote media disappears. 
I need to at least continue to send down local ioctls!

No, no suggestions of an extra control device, please. Simplicity.

> +
>  static struct block_device_operations floppy_fops = {
>  	open:			floppy_open,
>  	release:		floppy_release,
>  	ioctl:			fd_ioctl,
>  	check_media_change:	check_floppy_change,
>  	revalidate:		floppy_revalidate,
> +	can_trust_media_change: floppy_can_trust_media_change
>  };

and I'd like to have "invalidate" as a method too.

Peter
