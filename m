Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263925AbUDNGzI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 02:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263932AbUDNGzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 02:55:07 -0400
Received: from p4.ensae.fr ([195.6.240.202]:34621 "EHLO pc809.ensae.fr")
	by vger.kernel.org with ESMTP id S263925AbUDNGy7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 02:54:59 -0400
From: Guillaume =?iso-8859-1?q?Lac=F4te?= <Guillaume@Lacote.name>
Reply-To: Guillaume@Lacote.name
Organization: Guillaume@Lacote.name
To: =?iso-8859-1?q?J=F6rn=20Engel?= <joern@wohnheim.fh-wedel.de>
Subject: Re: Using compression before encryption in device-mapper
Date: Wed, 14 Apr 2004 08:54:56 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, Linux@glacote.com
References: <200404131744.40098.Guillaume@Lacote.name> <20040413174516.GB1084@wohnheim.fh-wedel.de>
In-Reply-To: <20040413174516.GB1084@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200404140854.56387.Guillaume@Lacote.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your answers.
Le Mardi 13 Avril 2004 19:45, Jörn Engel a écrit :

>> 0) Has this problem already been adressed, and if yes, where ?
> Yes, on the filesystems level.  Jffs2 is usable, although not
> well-suited for disks and similar, ext2compr appears to be unusable.
> On the device level, I haven't heard of anything yet.
Thank you, I didn't know about Jffs2; however I believe it is not an 
implemendation at the device level as I would like.

> > 1) Using dm:
> I'd go for a dm implementation.
>
> > 2) Block I/O boundaries:
> > 3) Compressed sectors have varying sizes ...
> > 4) Block allocation on writes: 
>
> If you really want to deal with this, you end up with a device that
> can grow and shrink depending on the data.  Unless you have a strange
> fetish for pain, you shouldn't even think about it.
Since space efficiency is _not_ my aim I plan to forcibly allocate 3 physical 
blocks for every 2 "compressed" blocks (as it should (?) always fit with a 
dynamic Huffman encoding).

>
> > 5) As a workaround to 2,3,4 I plan to systematically allocate 2 sectors
> > per real sector (space efficiency is _not_ my aim, growing entropy per
> > bit is) and to use a trivial dynamic huffman compression algorithm. Is
> > this solution (which means having half less space than physically
> > available) acceptable ?
>
> Makes sense.  One of the zlib developers actually calculated the
> maximum expansion when zlib-compressing data, so you could even get
> away with more than 50% net size, but that makes the code more
> complicated.  Your call.
Oops ! I thought it was possible to guarantee with the Huffman encoding (which 
is more basic than Lempev-Zif) that the compressed data use no more than 1 
bit for every byte (i.e. 12,5% more space).

>
> Performance should not be a big issue, as encryption is a performance
> killer anyway.
I am not sure that this is good news ;)
>
> Whether it is acceptable depends on the user.  Make it optional and
> let the user decide.
>
> > 6) Shall this whole idea of compression be ruled out of dm and only be
> > implemented at the file-system level (e.g. as a plugin for ReiserFS4) ?
>
> Again, depends on the user.  But from experience, there are plenty of
> users who want something like this.
Unfortunately I failed to find substantial code/documentation on encryption 
plugin for Reiser4, for example. Do you know about some ?

>
> Jörn
Thank you, Guillaume.

