Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312846AbSDXXv0>; Wed, 24 Apr 2002 19:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312850AbSDXXvZ>; Wed, 24 Apr 2002 19:51:25 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:3084 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S312846AbSDXXvY>; Wed, 24 Apr 2002 19:51:24 -0400
From: Daniel Quinlan <quinlan@transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15559.17638.605450.368606@transmeta.com>
Date: Wed, 24 Apr 2002 16:51:02 -0700 (PDT)
To: linux-kernel@vger.kernel.org
Cc: Johan Adolfsson <johan.adolfsson@axis.com>, quinlan@transmeta.com
Subject: Re: [PATCH and RFC] Compact time in cramfs 
In-Reply-To: <Pine.LNX.4.33.0204241009040.24998-100000@ado-2.axis.se>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: quinlan@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johan Adolfsson writes:

> The following patch gives a cramfs filesystem a single timestamp
> stored in the superblock. It uses the "future" field so no space is
> wasted.  mkcramfs uses the newest mtime or ctime from the
> filesystem.

Agreed, it seems like a good idea to have a filesystem timestamp.

The future field should probably be saved for use as the offset of a
"secondary superblock" (or something like that) rather than squandered
for one field.  At least, I think that was the original intent for the
field and it has always been my plan.

Maybe it would be easiest to overload the super.fsid.edition field?
Then you could have an option (probably a backward-compatible flag in
the superblock, but could be compile-time or mount-time) that indicates
that the edition number is a timestamp.

- Dan
