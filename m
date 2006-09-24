Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751698AbWIXI4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698AbWIXI4z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 04:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751785AbWIXI4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 04:56:54 -0400
Received: from wx-out-0506.google.com ([66.249.82.236]:57960 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751698AbWIXI4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 04:56:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jfwGpsa966h3qVjVEYy0Yr0eF26DDjmepYI0dYFhnXVNV27ldfz2QDCU+gHcSfd8EZIjTwpCVWNND6E1aqUFt5yn/6i0031O4Fs1kV6Qoh7CaWfsN3sDAJvqQO57xF0t0mXIwgckBor5dg4QxgfTVNeMAKphBh1dkFJP7lCDNvk=
Message-ID: <62b0912f0609240156p21caf564qc20b82b2ee4d8f43@mail.gmail.com>
Date: Sun, 24 Sep 2006 10:56:53 +0200
From: "Molle Bestefich" <molle.bestefich@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: ext3 corruption
Cc: "Helge Hafting" <helge.hafting@aitel.hist.no>
In-Reply-To: <44DB2436.6080501@aitel.hist.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <62b0912f0607131332u5c390acfrd290e2129b97d7d9@mail.gmail.com>
	 <62b0912f0608081647p2d540f43t84767837ba523dc4@mail.gmail.com>
	 <Pine.LNX.4.61.0608090723520.30551@chaos.analogic.com>
	 <62b0912f0608090822n2d0c44c4uc33b5b1db00e9d33@mail.gmail.com>
	 <1A5F0A2F95110B3F35E8A9B5@dhcp-2-206.wgops.com>
	 <62b0912f0608091128n4d32d437h45cf74af893dc7c8@mail.gmail.com>
	 <20060810030602.GA29664@mail>
	 <62b0912f0608100248w2b3c2243xec588aee8c5a9079@mail.gmail.com>
	 <44DB2436.6080501@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
> I have a ~1TB filesystem that failed to mount today, the message is:
>
> EXT3-fs error (device loop0): ext3_check_descriptors: Block bitmap for
> group 2338 not in group (block 1607003381)!
> EXT3-fs: group descriptors corrupted !
>
> Yesterday it worked flawlessly.

Helge Hafting wrote:
> > And voila, that difficult task of assessing in which order to do
> > things is out of the hands of distros like Red Hat, and into the
> > hands of those people who actually make the binaries.
>
> Not so easy.  You do not want to shut down md devices because
> samba is using them. Someone else may run samba on a single
> harddisk and also have some md-devices that they take down
> and bring up a lot.  So having samba generally depend on md doesn't
> work.  Your setup need it, others may have different needs.

I've looked hard at things and just found that maybe it's not the init
order that's to blame..

It seems that unmounting the filesystem fails with a "device busy" error.
I'm not sure why there's still open files on the device, but perhaps a
remote user is copying a file or some such (likely).

Anyway, the system is shutting down, so it should just forcefully
unmount the device, but it doesn't.
The halt script tries "umount" three times, which all fail with:
"device is busy".
It then actually tries "umount -f" three times, which all fail with
"Device or resource busy"
At which point the halt script turns off the machine and the
filesystem is ruined.

How to fix forceful unmount so it works?
