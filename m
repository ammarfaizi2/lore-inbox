Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261245AbVEaTJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbVEaTJz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 15:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbVEaTIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 15:08:52 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:953 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261184AbVEaTF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 15:05:57 -0400
Date: Tue, 31 May 2005 15:05:56 -0400
To: Gerd Knorr <kraxel@suse.de>
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, mrmacman_g4@mac.com,
       toon@hout.vanvergehaald.nl, ltd@cisco.com, linux-kernel@vger.kernel.org,
       dtor_core@ameritech.net, 7eggert@gmx.de
Subject: Re: OT] Joerg Schilling flames Linux on his Blog
Message-ID: <20050531190556.GK23621@csclub.uwaterloo.ca>
References: <26A66BC731DAB741837AF6B2E29C10171E60DE@xmb-hkg-413.apac.cisco.com> <20050530093420.GB15347@hout.vanvergehaald.nl> <429B0683.nail5764GYTVC@burner> <46BE0C64-1246-4259-914B-379071712F01@mac.com> <429C4483.nail5X0215WJQ@burner> <87acmbxrfu.fsf@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87acmbxrfu.fsf@bytesex.org>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2005 at 06:59:01PM +0200, Gerd Knorr wrote:
> Not really.  Yes, it runs on different operating systems.  But to send
> the SCSI commands to the device you have OS-specific code in there,
> simply because it's handled in different ways on Solaris / Linux /
> whatever OS.  You could make the device addressing OS-specific as well
> instead of expecting everyone in the world follow the Solaris model,
> that would make life a bit easier for everyone involved.
> 
> Addressing IDE devices (try to get a real SCSI burner these days)
> using scsi host+target+lun is sort-of silly IMHO ...

Well I remember the first time I saw devfs running, I thought "Wow
finally I have a way to find the disc that is scsi id 3 on controller 0
even if I add a device at id 2 after setting up the system", something
most unix systems have always had, but linux made hard (you had to
somehow figure out which id mapped to which /dev/sd* entry, which from a
users perspective wasn't trivial, and of course keeping your fstab in
sync with the mapping was a pain).

I think sysfs can do it too, although I haven't looked to much at sysfs
yet.

For IDE devices the /dev entry always mapped to a specific device
(modulo your ide drivers loading in a consistant order, but scsi host
controller load order has the same issue).  Scsi just assigned /dev
entries in the order devices were discovered.  In some ways it is handy
to know your first scsi drive is sda if you are doing raid1 or something
and a drive dies, but on the other hand it is annoying that drives move
around if you add drives with a lower id than your existing drives.
Having both would be preferable.

I don't know if the ide or scsi method is currently more sane, but it
sure would be nice to have a consistent behaviour between the two.

Len Sorensen
