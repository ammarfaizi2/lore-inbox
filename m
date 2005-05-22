Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261817AbVEVPd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbVEVPd7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 11:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbVEVPd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 11:33:59 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:19024 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261818AbVEVPd4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 11:33:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FHl9GfYOArImsHfsAM8RWtsXbYuxQ0Rk8I/huHdngPVL/9muT1BQYD9Txbk5iXABvcY1GfHtIDMDstMiBBgZGVT7LfF2a/kgOqkyZTG6zBIe3X9JiAqBvUplihtxuTqdhWIcu9p0tNTRH4ZSBFAG3/HKIXEyxKTHtlBqvAktCtg=
Message-ID: <9a87484905052208336a50c658@mail.gmail.com>
Date: Sun, 22 May 2005 17:33:55 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: Double 'block' link for floppy
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       viro@parcelfarce.linux.theplanet.co.uk
In-Reply-To: <20050521225454.B25980@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050521225454.B25980@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/21/05, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> I'm seeing an oddity with floppy:
> 
> $ vdir /sys/devices/platform/floppy.0/
> total 0
> lrwxrwxrwx    1 root     root            0 May 21 22:43 block -> ../../../block/fd1
> lrwxrwxrwx    1 root     root            0 May 21 22:43 block -> ../../../block/fd1
> lrwxrwxrwx    1 root     root            0 May 21 22:43 bus -> ../../../bus/platform
> -rw-r--r--    1 root     root         4096 May 21 22:43 detach_state
> 
> I suspect the first is actually supposed to be 'fd0' since:
> 
> $ vdir /sys/block/fd*/device
> lrwxrwxrwx    1 root     root            0 May 21 22:52 /sys/block/fd0/device -> ../../devices/platform/floppy.0
> lrwxrwxrwx    1 root     root            0 May 21 22:52 /sys/block/fd1/device -> ../../devices/platform/floppy.0
> 

I just took a look here, and I don't see what you see : 

juhl@dragon:~$ uname -a
Linux dragon 2.6.12-rc4-mm2 #2 Mon May 16 18:14:13 CEST 2005 i686
unknown unknown GNU/Linux
juhl@dragon:~$ vdir /sys/devices/platform/floppy.0/
total 0
lrwxrwxrwx  1 root root 0 2005-05-22 17:35 block -> ../../../block/fd0/
lrwxrwxrwx  1 root root 0 2005-05-22 13:02 bus -> ../../../bus/platform/
drwxr-xr-x  2 root root 0 2005-05-22 13:01 power/
juhl@dragon:~$ vdir /sys/block/fd*/device
lrwxrwxrwx  1 root root 0 2005-05-22 13:02 /sys/block/fd0/device ->
../../devices/platform/floppy.0/
juhl@dragon:~$
