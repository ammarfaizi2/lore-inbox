Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131020AbRAFTss>; Sat, 6 Jan 2001 14:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132029AbRAFTs3>; Sat, 6 Jan 2001 14:48:29 -0500
Received: from correo03.adinet.com.uy ([206.99.44.225]:3466 "EHLO
	correo03.adinet.com.uy") by vger.kernel.org with ESMTP
	id <S131020AbRAFTsW>; Sat, 6 Jan 2001 14:48:22 -0500
Message-ID: <3A576837.34E90872@adinet.com.uy>
Date: Sat, 06 Jan 2001 15:47:19 -0300
From: Ivan Baldo <lubaldo@adinet.com.uy>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-prerelease i586)
X-Accept-Language: es, en, it
MIME-Version: 1.0
To: flf@operamail.com, ben@imben.com, edolstra@students.cs.uu.nl,
        linux-kernel@vger.kernel.org, Linux Uruguay <linux-uy@linux.org.uy>,
        SET <salvador@inti.gov.ar>
Subject: How to make VFAT work right in 2.4.0-prerelease
Content-Type: multipart/mixed;
 boundary="------------5204AC694C043978588FF727"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------5204AC694C043978588FF727
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

	Hello.
HOWTO:
	- edit file fs/fat/inode.c, look in the function named
"fat_notify_change" (at about line 901), where it says:"
	/* FAT cannot truncate to a longer file */
	if (attr->ia_valid & ATTR_SIZE) {
		if (attr->ia_size > inode->i_size)
			return -EPERM;
	}
	", just delete all of it (or comment it out). This change wich has been
made in the -prerelease versión, makes Netscape Messenger not to work
with email stored on a VFAT partition, ok, I guess that maybe is
Netscape's fault though, but just removing that code makes Messenger at
least work somewhat.
	- apply attached patch made by Eelco Dolstra
<edolstra@students.cs.uu.nl>, I am testing and using this patch since
13.nov.2000 (a lot of time) and with various versions of the Linux
2.4.0-testXX series kernels and it works flawlessly! Without it you get
allocation errors when using the "truncate()" C function to grow files
(and Messenger seems to use it).
	- recompile the kernel and be happy!

	I don't know why this patch isn't applied yet on the official kernel
and why the kernel people made that change to the inode.c file, maybe
they could explain us (please!).

	Thanks a lot to everyone and special thanks to Eelco!
	Goodbye.

P.s.: yes, I am writing this email with Netscape Messenger with emails
stored on a VFAT partition and using the 2.4.0-prerelease kernel with
those changes: no problems so far.
-- 
Ivan Baldo:
lubaldo@adinet.com.uy - http://go.to/ibaldo - ICQ 10215364
Phone: (598) (2) 613 3223.
Caldas 1781, 11400 Malvin, Montevideo, Uruguay, South America.

(If you have problems with the previous addresses, try this ones:
ibaldo@usa.net, http://members.xoom.com/baldo.1).
--------------5204AC694C043978588FF727
Content-Type: application/x-gzip;
 name="parche-vfat-2.4.dif.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="parche-vfat-2.4.dif.gz"

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
aoMlyvwD2idvZjEWAAA=
--------------5204AC694C043978588FF727--



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
