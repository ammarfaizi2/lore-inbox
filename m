Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261847AbVF0GCS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261847AbVF0GCS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 02:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261859AbVF0GBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 02:01:41 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:49412 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S261847AbVF0FyZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 01:54:25 -0400
Message-ID: <42BF9489.9080202@slaphack.com>
Date: Mon, 27 Jun 2005 00:54:17 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050325)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
Cc: Hubert Chan <hubert@uhoreg.ca>, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>, Hans Reiser <reiser@namesys.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl> <42BCD93B.7030608@slaphack.com> <200506251420.j5PEKce4006891@turing-police.cc.vt.edu> <42BDA377.6070303@slaphack.com> <200506252031.j5PKVb4Y004482@turing-police.cc.vt.edu> <42BDC422.6020401@namesys.com> <42BE3645.4070806@cisco.com> <e692861c05062522071fe380a5@mail.gmail.com> <42BE563D.4000402@cisco.com> <42BE5DB6.8040103@slaphack.com> <200506261816.j5QIGMdI010142@turing-police.cc.vt.edu> <42BF08CF.2020703@slaphack.com> <200506262105.j5QL5kdR018609@turing-police.cc.vt.edu> <42BF2DC4.8030901@slaphack.com> <200506270040.j5R0eUNA030632@turing-police.cc.vt.edu>            <87y88webpo.fsf@evinrude.uhoreg.ca> <200506270459.j5R4xdZp005659@turing-police.cc.vt.edu>
In-Reply-To: <200506270459.j5R4xdZp005659@turing-police.cc.vt.edu>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Valdis.Kletnieks@vt.edu wrote:
> On Sun, 26 Jun 2005 23:10:43 EDT, Hubert Chan said:
> 
>>On Sun, 26 Jun 2005 20:40:29 -0400, Valdis.Kletnieks@vt.edu said:
> 
> 
>>Reiser4 plugins have to be compiled into the kernel.  (They're not
>>plugins in the sense that most people use that word.)  And any admin who
>>would compile that kind of plugin into the kernel needs to have his head
> 
> 
> Oh?  You saying that it *wont* be permitted for a user to say:
> 
> mkdir $HOME/zipped
> chattr "files under here are ZIP files" $HOME/zipped
> 
> and instead you have to do that chattr by hand for *every* *single* zip file?

chown works this way.  At least for username, there's no default user
possible per directory.  But scroll down a bit...

> Or "files on this filesystem are encrypted by default"?
> 
> I suspect that this sort of thing is going to be one of the *first* things
> that will get created, and any admin who tries to sell this idea to the users
> *without* that sort of functionality will be handed their head.

I think it may be possible to set defaults to a certain extent, but I
think that it's still actually a per-file setting whether the file is
encrypted.  Obviously, the keys have to be shared somehow, so there's
probably more grouping than just defaults...

There has been some mention of inheritance, but I've forgotten how
that's supposed to work.  If there's some sort of inheritance where
children inherit properties of their parent directory, and also inherit
changes to those properties, than Hans probably wants that to be the
prefered way of doing things?

I don't think there's that kind of inheritance, though.

> And notice that it doesn't *have* to be quite so obvious - how about if a
> user creates a directory $HOME/zipped/ and flags it as "anything under here
> is a zipped file".
> 
> Now throw in multiple users and CPU limits.  User A enters that directory and
> references everything, causing the buffer cache to get filled up.  While there,
> A makes changes, so the pages are dirty - "for i in */*; do echo " " >> $i; done"
> would do the job...  User B now does something that causes a writeback of one
> of those buffer cache pages.
> 
> A) What process currently gets ticked for the CPU and I/O for the writeback?
> 
> B) In your model, who will get ticked for the resources?
> 
> C) Will the users riot? (Note that you can't win here - currently, the "price"
> of writing back A's and B's pages are about equal.  However, if A gets dinked
> for an expensive writeback due to B's process, A will get miffed.  If B gets
> charge for an expensive writeback of A's, B will get miffed. If you say "screw it"
> and bill it to a kernel thread, the bean counters will get miffed... ;)

If I understand this correctly, this is somewhat like if user A creates
a 50 meg file on a system with 100 megs free RAM, and user B runs
"sync".  Also similar to if B were to suddenly fill up 75 megs of RAM,
forcing A's file to be flushed -- last I checked, in Reiser4, only a
sync or memory pressure causes writes to flush.

Right?  This is tempting to comment on, but I want to make sure I grok
it first...

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQr+UiHgHNmZLgCUhAQK+KBAAm6BSQuoFNeY5+cPQQaVK2BACqwJZabMH
Ze440Hjf9Pgn6Is/xWbCKKv6Mx4Vfx5P4+E4dkZJOyFBaVym6v5wy7ovPhFZVD8f
oW8IOUnCngnQ/Ea7fhxwr+hst2L4jEbMF0deG3zg328zYKwHoY0NA7hQZg2xLhF6
+J5jQWNR+CWyhFCBMD/NG+XwtSd4pxzOjb42e7zlEuKoCgGiTB92qPGDcOYMw/Te
3ez1Z+iJ6gIMUgwrzO4J6TzsgR9d9W0rJKMpm6ulto0AQtg1Joln3Vj5pxBX6ULe
5hkV6zeNOW8Uisz6+tdUX6PC+hjfSPvJhzkPMccTm8cJGyiF+j+PI5nUj37hyAz6
iL8kBPMrsulrGphuJzeb81yLzmgknX4+tc6WrVqMPcCpP4iIYOi0RMpWxSxQuRH9
ooSUnN/JRuhHaz4JeJ6VOvkwwl4nw1dcChBnBiws4IlFQS+mgKTAzZHhHm/+/E6q
nHY/uiFo1Tr95wyxrWyNcdGA/axriSIAaCXc1bEpQpzpOOcXr5d437TwEhBTIeXr
UlXwM6CdSrA3XGy7ksHovRghdm/7MOmNxL4SagVvY98Dlc+UlWi755rpin7JRget
9tFGtH0IESmPwSXfsBJYNIZCk4bG8X9d2W1/6e96yVtvKdn16MgX6n3Hdt3aVgzv
Ec9kEA42Ixs=
=qALY
-----END PGP SIGNATURE-----
