Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261963AbTBJPNA>; Mon, 10 Feb 2003 10:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261733AbTBJPNA>; Mon, 10 Feb 2003 10:13:00 -0500
Received: from 12-237-214-24.client.attbi.com ([12.237.214.24]:13843 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S261724AbTBJPM6>;
	Mon, 10 Feb 2003 10:12:58 -0500
Message-ID: <3E47C3BF.6030609@mvista.com>
Date: Mon, 10 Feb 2003 09:22:39 -0600
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021204
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: suparna@in.ibm.com
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
       Kenneth Sumrall <ken@mvista.com>, linux-kernel@vger.kernel.org,
       lkcd-devel@lists.sourceforge.net
Subject: Re: Kexec, DMA, and SMP
References: <3E448745.9040707@mvista.com> <m1isvuzjj2.fsf@frodo.biederman.org> <3E45661A.90401@mvista.com> <m1d6m1z4bk.fsf@frodo.biederman.org> <20030210174243.B11250@in.ibm.com> <3E47AF93.8030807@mvista.com> <20030210203715.A11739@in.ibm.com>
In-Reply-To: <20030210203715.A11739@in.ibm.com>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Suparna Bhattacharya wrote:

|On Mon, Feb 10, 2003 at 07:56:35AM -0600, Corey Minyard wrote:
|
|>-----BEGIN PGP SIGNED MESSAGE-----
|>Hash: SHA1
|>
|>Suparna Bhattacharya wrote:
|>
|>|Yes. It actually saves a formatted compressed dump in memory,
|>|and later writes it out to disk as is.
|>
|>MCL coredump does funny memory shuffling, too.  It compresses
|>pages into a contiguous area of memory, and as it runs into output
|>pages that it has not yet compressed, it moves them into pages that
|>it has already compressed and keeps track of where everything is
|
|
|AFAICR, the MCL coredump implementation I'd seen (and used as
|a reference to model some of this code for lkcd) seemed to
|save only a kernel dump (not user space pages), so it would
|use the free and user pages as destination for compressed
|dump. What you are describing sounds a little different and
|closer to what we are doing. I'd be interested in takng a look
|at the implementation you are working with if it actually
|saves the whole memory by making use of pages it has already
|compressed. Could you point me to the code ?

I remembered incorrectly here.  I was thinking of bootimg, which does to 
some wierd
page shuffling.  MCL coredump does not save in a contiguous region, it 
keeps a free list
of pages it has alread compressed and allocates destination pages from 
it's free list,
and stores those in a map.

- -Corey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+R8NemUvlb4BhfF4RApfrAJ4tWv3mU8N4TDYXaymM4FBXJurJ3ACfef4r
qHRXTq8OS/+fb7KSFqWMKiw=
=h6qs
-----END PGP SIGNATURE-----


