Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312525AbSDJHm4>; Wed, 10 Apr 2002 03:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312529AbSDJHmz>; Wed, 10 Apr 2002 03:42:55 -0400
Received: from [195.157.147.30] ([195.157.147.30]:35593 "HELO
	pookie.dev.sportingbet.com") by vger.kernel.org with SMTP
	id <S312525AbSDJHmy>; Wed, 10 Apr 2002 03:42:54 -0400
Date: Wed, 10 Apr 2002 08:45:05 +0100
From: Sean Hunter <sean@dev.sportingbet.com>
To: Geoffrey Gallaway <geoffeg@sin.sloth.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ramdisks and tmpfs problems
Message-ID: <20020410084505.A4493@dev.sportingbet.com>
Mail-Followup-To: Sean Hunter <sean@dev.sportingbet.com>,
	Geoffrey Gallaway <geoffeg@sin.sloth.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020409144639.A14678@sin.sloth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2002 at 02:46:39PM -0400, Geoffrey Gallaway wrote:
> So no go with ram disks (this is kernel 2.4.18 on a 3 gig RAM dual PIII
> 1gig, BTW). So now to try tmpfs. Since I need to copy the existing files in
> /etc off to tmpfs I have to create a "temporary" tmpfs, copy /etc off to it
> then create another tmpfs on top of the existing /etc and copy from the
> "temporary" tempfs back to the new /etc. I came up with the following 
> commands:
> mount -w -n -t tmpfs -o defaults tmpfs /mnt
> cp -axf /etc /mnt
> mount -w -t tmpfs -o defaults tmpfs /etc
> cp -axf /mnt/etc/* /etc/
> umount /mnt
> # -- Reapeat for /var and /tmp --

Wouldn't this be easier?

mount -t tmpfs none /dev/shm
cp -axf /etc/* !$
mount --bind /dev/shm /etc

