Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750964AbWBJU1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbWBJU1b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 15:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbWBJU1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 15:27:30 -0500
Received: from uproxy.gmail.com ([66.249.92.199]:32816 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750964AbWBJU1a convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 15:27:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=r3DQlP3Jw1RozmWk6CjNTpH6Hqks1Grq2GdVtbdI7yat+qEfBbVIMwG4FeDK0culo7XT4D5ZVfOqOoEBtogsjl8INO2hA5GLDwcomwshRb3NWnN8FA/nr5XTupLXGJx2BMbGoWmNU8R8ly5BxWZV9TJoodqIF25cU3pHKmUMzEU=
Message-ID: <62b0912f0602101227q719e712bq40da5b2f0c5422c5@mail.gmail.com>
Date: Fri, 10 Feb 2006 20:27:28 +0000
From: Molle Bestefich <molle.bestefich@gmail.com>
To: device-mapper development <dm-devel@redhat.com>
Subject: Re: Support HDIO_GETGEO on device-mapper volumes
Cc: "Darrick J. Wong" <djwong@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <43ECAD5B.9070308@cfl.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43EBEDD0.60608@us.ibm.com>
	 <20060210145348.GA12173@agk.surrey.redhat.com>
	 <43ECAD5B.9070308@cfl.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Susi wrote:
> Yes, I think this could also be fixed on grub's end.  It seems that
> fdisk assumes usable default values for the geometry but grub has
> different defaults that cause it problems.  I think that the defaults
> could be modified in grub so that it will work when HDIO_GETGEO fails.

It would be better to make the decision once and for all, in one place.

It would be even better for the HDIO_GETGEO call to return the same
geometry that the BIOS uses, so that Grub is handed numbers that
actually mean *something*.

When 'dmraid' has assembled an array, it should find the matching BIOS
drive in /proc/bios/int13_dev* and then it should tell device-mapper
to present that geometry to whomever asks via HDIO_GETGEO.

And while we're at it, <some component> should do the same for eg.
/dev/hd?.  It's very annoying trying to fix up a harddrive's partition
table when the numbers you see in Linux is different to the numbers
you'll see when rebooting into DOS, or Windows XP, or whatever it is
that's on the disk you're trying to fix.
