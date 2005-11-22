Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030264AbVKVX5q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030264AbVKVX5q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 18:57:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030265AbVKVX5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 18:57:45 -0500
Received: from web50110.mail.yahoo.com ([206.190.38.38]:41075 "HELO
	web50110.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1030264AbVKVX5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 18:57:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=mNSDt5zRRmkOgYH5OdAMJ+W9ZaGYjlBgitwOJAGqzmm9bU4ooYsPancjpIZmW6u+oWn+XDtOg4fYHxosMK9C0Z9iWol8zGkbS2uWz8zMoxPafSmEwOcahjqW5ijXCSaD5bdm1TneDYyRdsqU7cOYWLtIJWlwVR3CXepkFL6HqAc=  ;
Message-ID: <20051122235744.15404.qmail@web50110.mail.yahoo.com>
Date: Tue, 22 Nov 2005 15:57:44 -0800 (PST)
From: Doug Thompson <norsk5@yahoo.com>
Subject: [RFC] EDAC a new sysfs 'subsystem' under /sys/devices
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

EDAC is for detecting and logging memory ECC, PCI
Parity and (future) other hardware errors.

In my process of getting edac ready for kernel
submission:

I have been exploring mechanisms for placing EDAC
controls and attribute files into sysfs for a few days
now.

In the process, I "discovered" how sysfs subystems are
currently used. I have determined that EDAC itself
should be a subsystem, since more than one type of
EDAC device can be created.

I made a copy of drivers/base/sys.c to a new file,
drivers/base/edac.c (and corresponding .h file) and
refactored it to become a 'edacdev' subsystem.

I have mounted edac to: /sys/devices/edac because the
/sys/device/system subsystem is not exported (at the
moment. I suppose that could be changed). 

I now have:

/sys/devices/edac/mc/mc0/csrow0 kobjects working and
am adding attribute files to their respective
kobjects.

My RFC is:

Should I leave edac under /sys/devices OR refactor
drivers/base/sys.c and export the "system" subsystem
and mount edac under /sys/devices/system? 

Another RFC is:

Should EDAC really have a "new" subsystem in the
kernel?  (I believe it fits bets, but am looking for
alternatives)

It requires a new drivers/base/edac.c (and .h file +
plumbing).  I would like to see that, as it really
works nicely. The EDAC module currently in the -mm
tree will depend  on it, in order to implement the
requested sysfs features. (Other options are possible
I suppose)

The only problem I ran into was that I needed further
subdirectories under 'mc/mc0', and I had to resort to
using kobject_register() since the subsystem didn't
have methods for such creation. Yet that code now
works nicely.


I suppose I am looking for verification of the
direction I am progressing in.

Thanks for any input

doug t




"If you think Education is expensive, just try Ignorance"

"Don't tell people HOW to do things, tell them WHAT you
want and they will surprise you with their ingenuity."
                   Gen George Patton

