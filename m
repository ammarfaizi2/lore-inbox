Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265957AbUAHULI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 15:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266354AbUAHUJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 15:09:09 -0500
Received: from pat.uio.no ([129.240.130.16]:51704 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S266353AbUAHUIw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 15:08:52 -0500
Message-ID: <33178.141.211.133.197.1073592524.squirrel@webmail.uio.no>
Date: Thu, 8 Jan 2004 21:08:44 +0100 (CET)
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
From: <trond.myklebust@fys.uio.no>
To: <hpa@zytor.com>
In-Reply-To: <3FFDB272.8030808@zytor.com>
References: <33128.141.211.133.197.1073590355.squirrel@webmail.uio.no>
        <3FFDB272.8030808@zytor.com>
X-Priority: 3
Importance: Normal
Cc: <viro@parcelfarce.linux.theplanet.co.uk>, <linux-kernel@vger.kernel.org>,
       <raven@themaw.net>, <Michael.Waychison@sun.com>, <thockin@sun.com>
X-Mailer: SquirrelMail (version 1.2.11 - UIO)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=-4.74, required 12,
	BAYES_00 -4.90, NO_REAL_NAME 0.16)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> If anyone wants evidence of how broken the whole daemon thing is, then
>> see the workarounds that had to be made in RFC-2623 to disable strong
>> authentication for GETATTR etc. on the NFSv2/v3 mount point.
>>
>
> It's not broken as much as what you want to do is outside the scope of
> automount.  automount is one particular user of these facilities, and as
> you correctly point out, it can't solve the problems for all of them.
> The right thing for AFS and NFSv4 is clearly to do something different.

My point is that the above problem crops up in almost *all* combinations
of automounter daemon with remote filesystem and strong authentication.
In order to correctly mount the remote filesystem, the automounter
itself needs a minimum set of remote privileges (typically it needs to be
able
to browse the remote filesystem).

RFC-2623 describes how to add RPCSEC_GSS to NFSv2/v3. The
workarounds (hacks really) that I refer to above had to be deliberately
added in order to make Sun's automounter work in this environment.
The alternative would have been to have a global "machine" credential
for use by the automounter when browsing /net. Hardly secure...

> That being said, mount traps in particular, and possibly this "trap
> filesystem" are more generic kernel facilities which should be of use to
> other things than automount.  AFS/NFSv4 are the obvious examples, quite
> possibly other things like intermezzo might be interested, and we don't
> want to have to reinvent the wheel every time.

Certainly. I believe CIFS might also have a similar mechanism.

Cheers,
   Trond


