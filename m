Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292558AbSBUQQq>; Thu, 21 Feb 2002 11:16:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292632AbSBUQQh>; Thu, 21 Feb 2002 11:16:37 -0500
Received: from mx01-a.netapp.com ([198.95.226.53]:61313 "EHLO
	mx01-a.netapp.com") by vger.kernel.org with ESMTP
	id <S292558AbSBUQQ2>; Thu, 21 Feb 2002 11:16:28 -0500
Message-ID: <6440EA1A6AA1D5118C6900902745938E50CD87@black.eng.netapp.com>
From: "Lever, Charles" <Charles.Lever@netapp.com>
To: "'Neil Brown'" <neilb@cse.unsw.edu.au>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, phil@off.net,
        "Peter J. Braam" <braam@clusterfs.com>
Subject: RE: tmpfs, NFS, file handles
Date: Thu, 21 Feb 2002 08:16:04 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That means you are only hashing inodes exported by NFS, and you have
> a pretty good guarantee of uniqueness (providing time doesn't go
> backwards).

this may be obvious... apologies.

don't use the TOD directly -- it can go backwards if ntpd or an admin
sets it back.  better to use a monotonically increasing number that
you completely control yourself.

also, if your timer resolution isn't good enough, a window opens 
where two generated "uniquifiers" can be the same for all intents
and purposes.

if there's nothing else we've learned from NFS, it's that using
timestamps is a lousy way of managing cache coherency and file
identity.  ;-)
