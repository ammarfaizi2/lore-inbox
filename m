Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263003AbUDTOgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263003AbUDTOgl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 10:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262906AbUDTOgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 10:36:41 -0400
Received: from users.linvision.com ([62.58.92.114]:1721 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S263003AbUDTOgh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 10:36:37 -0400
Date: Tue, 20 Apr 2004 16:36:35 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Remi Colinet <remi.colinet@free.fr>, linux-kernel@vger.kernel.org
Subject: Re: Questions : disk partition re-reading
Message-ID: <20040420143634.GA12132@bitwizard.nl>
References: <4082819E.10106@free.fr> <20040420074650.GA3040@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040420074650.GA3040@pclin040.win.tue.nl>
User-Agent: Mutt/1.3.28i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2004 at 09:46:50AM +0200, Andries Brouwer wrote:
> You must distinguish the on-disk partition table and the kernel
> partition table. You can change the on-disk partition table just by
> writing to it, but that does not change the kernel's ideas.
> You can change the kernel partition table using the right ioctls
> but that does not change the bits on disk.
> 
> Usually one does
> 	blockdev --rereadpt /dev/something
> after changing media, or after writing to the partition table,
> but that will fail if the disk is busy.

Which reminds me: Too bad the kernel says "Busy" without really
thinking aboutit. 

Assume that I have a 
	<hda1> swap 1G    (*)
	<hda2> root 19G   (active)
        <free space> 

disk, and want to add an extra partition. Maybe I have a 20G image
which I want to copy onto 20, 40, 60, 80, 120 and 200Gb disks. I can
then add the third partition as a /data or a /tmp partition. However
as the active root is on that disk I have to reboot. But in fact I
don't intend to change the active partition. 

So, there should be objections if I want the new partitioning scheme
to be: 

	<hda1> swap 1.5G 
	<hda2> root 19G   (active)
        <free space> 

then there is a problem and I can understand "Busy".  But if the new
scheme is: 

	<hda1> swap 1G  
	<hda2> root 19G   (active)
        <hda3> data 20G   <unformatted>

then I don't understand the reason for refusing the rereadpt request.

Anybody want to code this up?


	Roger. 


(*) usually active as well, but easily deactivated. So lets pretend
it's inactive for this discussion. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
**** "Linux is like a wigwam -  no windows, no gates, apache inside!" ****
