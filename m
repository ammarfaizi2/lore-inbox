Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265051AbUHHEIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265051AbUHHEIe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 00:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265074AbUHHEIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 00:08:34 -0400
Received: from hibernia.jakma.org ([212.17.55.49]:56704 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S265051AbUHHEIc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 00:08:32 -0400
Date: Sun, 8 Aug 2004 05:07:53 +0100 (IST)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
cc: mj@ucw.cz, James.Bottomley@steeleye.com, axboe@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
In-Reply-To: <200408071053.i77Aromi006941@burner.fokus.fraunhofer.de>
Message-ID: <Pine.LNX.4.60.0408080400550.2622@fogarty.jakma.org>
References: <200408071053.i77Aromi006941@burner.fokus.fraunhofer.de>
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Aug 2004, Joerg Schilling wrote:

> 5)	Take a look at /etc/path_to_inst and call "man path_to_inst"

The irony here is that the kernel you point at does *not* try to map 
unrelated busses into the same namespace, that the tools and files 
like path_to_inst exist precisely to deal with the fact that topology 
information is no more than ephemereal, and that even the end-user 
device naming does *not* try to map IDE into SCSI.

That the /dev/dsk names typically encode some *logical* topology 
information into the names is beside the point, it's just the Solaris 
convention, the real point is that they abstract the device location, 
so that the user is not required to know that their disk is really 
at, eg:

 	/devices/pci@0,0/pci-ide@7,1/ide@1/sd@0,0:d,raw

Which is where the /dev/ node would symlink to. The /dev/ name has 
nothing to do with physical topology (though might be vaguely 
similar). Also note that the logical /dev/ symlink name is encoded 
*differently* for IDE versus SCSI. Trying to plaster SCSI notations 
into IDE topology is just not useful. Indeed, some devices are not 
dependent on topology at all, they depend on some other topology 
independent identifier, eg FC UUID.

Having user utilities try invent their own namespace, inconsistent 
with both the physical topology and the system's conventions is even 
less useful.

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
QOTD:
 	"I drive my car quietly, for it goes without saying."
