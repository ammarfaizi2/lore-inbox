Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261269AbVARLsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbVARLsE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 06:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261261AbVARLsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 06:48:04 -0500
Received: from piggy.rz.tu-ilmenau.de ([141.24.4.8]:13975 "EHLO
	piggy.rz.tu-ilmenau.de") by vger.kernel.org with ESMTP
	id S261263AbVARLrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 06:47:07 -0500
Date: Tue, 18 Jan 2005 12:47:01 +0100
From: Mario Holbe <Mario.Holbe@TU-Ilmenau.DE>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4: "access beyond end of device" after ext2 mount
Message-ID: <20050118114701.GD2839@darkside.22.kls.lan>
Mail-Followup-To: Mario Holbe <Mario.Holbe@TU-Ilmenau.DE>,
	Andries Brouwer <aebr@win.tue.nl>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux-kernel@vger.kernel.org
References: <20050115233530.GA2803@darkside.22.kls.lan> <20050117194635.GD22202@logos.cnet> <20050118105547.GD8747@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050118105547.GD8747@pclin040.win.tue.nl>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2005 at 11:55:47AM +0100, Andries Brouwer wrote:
> I suppose that what happens is the following:
> mounting sets the blocksize to 4096.
> After reading 9992360 sectors, reading the next block means reading
> the next 8 sectors and that fails because only 6 sectors are left.
> Test that this is what happens using blockdev --getbsz.

Yes! This was the command I was looking for ;)

root@darkside:~# blockdev --getbsz /dev/hdg7
4096
root@darkside:~# blockdev --getbsz /dev/hdg6
1024
root@darkside:~# mount -t ext3 -o ro /dev/hdg6 /mnt
root@darkside:~# umount /dev/hdg6 
root@darkside:~# blockdev --getbsz /dev/hdg6
4096

> If you want to restore the device to full size, use
> blockdev --setbsz 512.

Does that in any way hurt, if a filesystem is just mounted?
I mean, what would happen, if I mount /dev/hdg7 and then
set the block size back to 1024? Would that perhaps corrupt
my filesystem or something like that?


Mario
-- 
<jv> Oh well, config
<jv> one actually wonders what force in the universe is holding it
<jv> and makes it working
<Beeth> chances and accidents :)
