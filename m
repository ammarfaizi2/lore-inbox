Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261469AbVFARAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbVFARAu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 13:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbVFARAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 13:00:49 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:61331 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261469AbVFARAl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 13:00:41 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Wed, 1 Jun 2005 18:55:26 +0200
From: Gerd Knorr <kraxel@suse.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: lsorense@csclub.uwaterloo.ca, toon@hout.vanvergehaald.nl,
       mrmacman_g4@mac.com, ltd@cisco.com, linux-kernel@vger.kernel.org,
       dtor_core@ameritech.net, 7eggert@gmx.de
Subject: Re: OT] Joerg Schilling flames Linux on his Blog
Message-ID: <20050601165526.GA7815@bytesex>
References: <26A66BC731DAB741837AF6B2E29C10171E60DE@xmb-hkg-413.apac.cisco.com> <20050530093420.GB15347@hout.vanvergehaald.nl> <429B0683.nail5764GYTVC@burner> <46BE0C64-1246-4259-914B-379071712F01@mac.com> <429C4483.nail5X0215WJQ@burner> <87acmbxrfu.fsf@bytesex.org> <20050531190556.GK23621@csclub.uwaterloo.ca> <20050531195603.GB28168@bytesex> <429DDAA4.nail7BFB1SXEV@burner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429DDAA4.nail7BFB1SXEV@burner>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2005 at 05:56:20PM +0200, Joerg Schilling wrote:
> Gerd Knorr <kraxel@suse.de> wrote:
> 
> >    # find /dev/cd /dev/disk -type l -print | sort
> >    /dev/cd/by-id/HL-DT-ST_DVDRAM_GSA-4040B_K213BDG5213
> >    /dev/cd/by-id/LG_CD-RW_CED-8080B_2000_07_27e
> >    /dev/cd/by-path/pci-0000:00:04.1-ide-1:0
> >    /dev/cd/by-path/pci-0000:00:04.1-ide-1:1
> >    /dev/disk/by-id/IBM-DTLA-305040_YJEYJM36751
> >    /dev/disk/by-id/IBM-DTLA-305040_YJEYJM36751p1
> 
> Nice, but will be the Linux /dev/ fashion next year?

You simply shoudn't care.  Just open the /dev/whatever device
node passed by the user and be happy ;)

> >From my experiences it makes no sense to implement support
> for things like this before waiting long enough to know 
> whether this is something that will become ordinary.

I don't see what kind of special support you want implement in
cdrecord.  The user says "this device", cdrecord takes it and
opens it, tries a ioctl or two to figure what kind of device
handle that is (scsi generic or 2.6-style /dev/hdx), then uses
it to send scsi commands to the device.

You don't have to solve the problem of providing stable device
names within cdrecord.  That is the job of the operating system.
A udev-based linux distro can do that as you can see above.
cdrecord should just accept these device nodes, nothing more.

  Gerd

-- 
-mm seems unusually stable at present.
	-- akpm about 2.6.12-rc3-mm3
