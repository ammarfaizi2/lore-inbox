Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbWAWAKG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWAWAKG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 19:10:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbWAWAKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 19:10:06 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:56397 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932164AbWAWAKF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 19:10:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=em77jtoJPKNfuuNJxTtHjKHd/Gx9zbU2iJOdgXmMLzsaZjsSY0d/xP0+Db5hMEAeNZoiZ17oJY5LEYZkeviZc6LiEGjHpRDof4DiBOqU94eCiUwpkqIJ1Rpomd951VGWN46SQsYYNzwi7QsobZr/58d49nplAshDKvuuvkzjvI0=
Message-ID: <787b0d920601221602h3504a74dqf654c08387427253@mail.gmail.com>
Date: Sun, 22 Jan 2006 19:02:45 -0500
From: Albert Cahalan <acahalan@gmail.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, olh@suse.de
Subject: Re: [PATCH] disable per cpu intr in /proc/stat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While ripping this out may break things, leaving it in has
been breaking things as well. That line just keeps growing.
Many times, I have found that my buffer was too small to
read that file. (shall I make it a megabyte or what?)

Looking around a bit, I can only find use of the first number.
(so don't remove that)

I suggest removing the excess values for all architectures.
It's in /proc/interrupts anyway.

If some architectures will keep the data, then please limit
the data to the original 16 PC-AT interrupts and #if it like so:

#if defined(CONFIG_X86) && defined(CONFIG_ISA)
        for (i = 0; i < 16; i++)  /* only the 16 legacy ones */
                seq_printf(p, " %u", kstat_irqs(i));
#endif

Those 16 are the only ones you can hope to identify
without looking in /proc/interrupts anyway.
