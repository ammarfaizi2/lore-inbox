Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312987AbSDYIhZ>; Thu, 25 Apr 2002 04:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312988AbSDYIhY>; Thu, 25 Apr 2002 04:37:24 -0400
Received: from krynn.axis.se ([193.13.178.10]:43939 "EHLO krynn.axis.se")
	by vger.kernel.org with ESMTP id <S312987AbSDYIhX>;
	Thu, 25 Apr 2002 04:37:23 -0400
From: johan.adolfsson@axis.com
Message-ID: <00a001c1ec34$ad5703a0$adb270d5@homeip.net>
Reply-To: <johan.adolfsson@axis.com>
To: <quinlan@transmeta.com>, <linux-kernel@vger.kernel.org>
Cc: "Johan Adolfsson" <johan.adolfsson@axis.com>
In-Reply-To: <Pine.LNX.4.33.0204241009040.24998-100000@ado-2.axis.se> <15559.17638.605450.368606@transmeta.com>
Subject: Re: [PATCH and RFC] Compact time in cramfs 
Date: Thu, 25 Apr 2002 10:39:12 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Daniel Quinlan writes:


> Johan Adolfsson writes:
>
> > The following patch gives a cramfs filesystem a single timestamp
> > stored in the superblock. It uses the "future" field so no space is
> > wasted.  mkcramfs uses the newest mtime or ctime from the
> > filesystem.
>
> Agreed, it seems like a good idea to have a filesystem timestamp.
>
> The future field should probably be saved for use as the offset of a
> "secondary superblock" (or something like that) rather than squandered
> for one field.  At least, I think that was the original intent for the
> field and it has always been my plan.

Ok, I wondered what the intent really was.

> Maybe it would be easiest to overload the super.fsid.edition field?

Makes sense.

> Then you could have an option (probably a backward-compatible flag in
> the superblock, but could be compile-time or mount-time) that indicates
> that the edition number is a timestamp.

Using a flag should be enough I think:
#define CRAMFS_FLAG_FSID_EDITION_IS_TIMESTAMP  0x00000004 /* edition field
used as timestamp */

And mkcramfs should perhaps have support for
-e timestamp
(the string timestamp) which would set the edition field to the timestamp
according to the files in the image and set the timestamp flag.
Perhaps another option to set the timestamp flag but use whatever number
is supplied in the -e option might be useful for some, although I personally
don't think I need it. E.g. -f FSID_EDITION_IS_TIMESTAMP


Another mkcramfs feature we have at Axis is the support for metafiles with
file info used when creating the image. That allows us to create device
nodes, change userid etc. without being root which is good when building
for embedded devices.
It was first posted in October last year but without any feedback:
http://www.ussg.iu.edu/hypermail/linux/kernel/0110.0/0098.html
What do you think about that?

> - Dan

/Johan


