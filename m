Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264635AbSJ3J2R>; Wed, 30 Oct 2002 04:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264639AbSJ3J2R>; Wed, 30 Oct 2002 04:28:17 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:43780 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264635AbSJ3J2Q>; Wed, 30 Oct 2002 04:28:16 -0500
Date: Wed, 30 Oct 2002 09:34:37 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Miles Bader <miles@gnu.org>, andersen@codepoet.org,
       Dave Cinege <dcinege@psychosis.com>, linux-kernel@vger.kernel.org
Subject: Re: Abbott and Costello meet Crunch Time -- Penultimate 2.5 merge candidate list.
Message-ID: <20021030093437.A27726@flint.arm.linux.org.uk>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Miles Bader <miles@gnu.org>, andersen@codepoet.org,
	Dave Cinege <dcinege@psychosis.com>, linux-kernel@vger.kernel.org
References: <200210272017.56147.landley@trommello.org> <200210300229.44865.dcinege@psychosis.com> <3DBF8CD5.1030306@pobox.com> <200210300322.17933.dcinege@psychosis.com> <20021030085149.GA7919@codepoet.org> <buofzuogv31.fsf@mcspd15.ucom.lsi.nec.co.jp> <3DBFA0F8.9000408@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DBFA0F8.9000408@pobox.com>; from jgarzik@pobox.com on Wed, Oct 30, 2002 at 04:06:00AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2002 at 04:06:00AM -0500, Jeff Garzik wrote:
> It should be pretty easy to populate initramfs from ROM...

Typical embedded initrds do fairly disgusting tricks to "work around"
the limitations of themselves.  These tricks are solved cleanly by
initramfs, but I'll guess that the reason embedded people will complain
is because it is different, and embedded people don't like to unlearn
old tricks.

Here's two things that initramfs does that there is no way in hell an
initrd can ever do:

- once you've finished with various stuff, you can remove it and
  thereby free up the space that file was occupying for use by anything
  without having to wait for the whole filesystem to become unused.

- there's no need to mount a ramfs filesystem, or a blockdev /dev/ram
  ext2fs-formatted filesystem for /tmp, /etc or /var/run (etc) since
  / is already a ramfs filesystem, thereby removing:
   + extra symlinks for writable files in these directories
   + extra mount points (with associated kernel structures)
   + ext2fs
   + rd

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

