Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261170AbVF1ThL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbVF1ThL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 15:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbVF1Tg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 15:36:29 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:25604 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S261170AbVF1TdA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 15:33:00 -0400
Message-ID: <42C1A5E8.2040603@slaphack.com>
Date: Tue, 28 Jun 2005 14:32:56 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050325)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hubert Chan <hubert@uhoreg.ca>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Valdis.Kletnieks@vt.edu,
       Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Hans Reiser <reiser@namesys.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl>	<42BE563D.4000402@cisco.com> <42BE5DB6.8040103@slaphack.com>	<200506261816.j5QIGMdI010142@turing-police.cc.vt.edu>	<42BF08CF.2020703@slaphack.com>	<200506262105.j5QL5kdR018609@turing-police.cc.vt.edu>	<42BF2DC4.8030901@slaphack.com>	<200506270040.j5R0eUNA030632@turing-police.cc.vt.edu>	<42BF667C.50606@slaphack.com>	<5284F665-873C-45B7-8DDB-5F475F2CE399@mac.com>	<42BF7167.80201@slaphack.com>	<EC02A684-815A-4DF8-B5C1-9029FE45E187@mac.com>	<42C06D59.2090200@slaphack.com>	<CD59AE36-FD15-4A4C-9E1D-AB2F8B52D653@mac.com>	<42C08B5E.2080000@slaphack.com> <87y88vrzkg.fsf@evinrude.uhoreg.ca>	<EBD8F590-0113-4509-9604-E6967C65C835@mac.com>	<87mzpbrvpf.fsf@evinrude.uhoreg.ca>	<D3A4ABBF-8062-4399-B1EC-61722295944A@mac.com>	<87irzzrqu7.fsf@evinrude.uhoreg.ca>	<2B1C058D-C304-4E15-ACDA-C3337E67E981@mac.com> <87d5q6pdyv.fsf@evinrude.uhoreg.ca>
In-Reply-To: <87d5q6pdyv.fsf@evinrude.uhoreg.ca>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hubert Chan wrote:
> On Tue, 28 Jun 2005 02:01:12 -0400, Kyle Moffett <mrmacman_g4@mac.com> said:
> 
> 
>>On Jun 28, 2005, at 01:30:08, Hubert Chan wrote:
>>
>>>On Tue, 28 Jun 2005 00:38:38 -0400, Kyle Moffett
>>><mrmacman_g4@mac.com> said:
>>>
>>>>Ok.  Those things should probably be divided up.  Stuff like POSIX
>>>>extended attributes and such that have existing interfaces should
>>>>use those.
>>>
>>> One of the claimed advantages of the '...' interface is that
>>>everything is editable as a file.  So if someone wanted to edit the
>>>description extended attribute for foo.txt, he would just run
>>>"[editor] foo.txt/.../description" (or "[editor]
>>>/meta/fs/$(getattrpath foo.txt)/description"), instead of needing to
>>>use some special purpose editor.  It works well for things like being
>>>able to use Gimp to edit a thumbnail or icon attribute.
> 
> 
>>I don't disagree with the thumbnail/icon/description, but things like
>>POSIX acls and extended attributes have _existing_ interfaces which
>>should be used.

Any existing interface should be supported, but Reiser4 seems to want to
replace all existing interfaces except a direct open() and a proposed
new system call which opens lots of small files at once, efficiently.

The two approaches are not mutually exclusive, though.

> OK.  I agree with that.  Of course, Reiser4 can always present both
> interfaces, just like it presented two interfaces to the stat data --
> the regular interface and the metas (now '...') interface -- before
> file-as-dir got disabled by default.

The proposal I like right now is /meta, as a separate FS, which provides
access to what would be the '...' interface.  Check the archives.

>>I don't deny them the right to add other interfaces later, but such
>>should be a secondary or tertiary patch, after the rest of the stuff
>>is in.  In any case, if we were to provide an interface by which one
>>could $EDITOR the POSIX ACLs, it should be done in the VFS where all
>>filesystems can share it.
> 
> 
> I don't know if VFS is the right place for it, but I agree that it would
> be good to make it accessible to all filesystems.

You put it in /meta, which is available to all filesystems.

>>I think that part of Reiser4 needs more review than it's been given at
>>present.
> 
> 
> Looking forward to the flamewar that happens when Namesys decides that
> file-as-dir is ready to be turned on again. ;-)

Namesys still hasn't commented directly on the /meta proposal, have
they?  That would avoid the flamewar altogether.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQsGl6HgHNmZLgCUhAQK+OQ//Zhj9DPyXRaASbTmnj2oPcWYWHzY5+M8O
n0e7PsFPtVpb6mduDPYu91WTGYooPnicVOBBQezWUOVFYMN4SWxyVunTpDYbvTGn
xVwSLTjb5/AZ7dIuklVfverN72nwmLURCJjGZ41iqyylHJT/nCufYZHhQIPa15Pu
o0IzYlQahS3uxuYVJubDOms0G/K2pDuoFGuJJkk+JTPCbf9+2UEqjiUrL3FTqeG+
5RQ6wVeinz5CFPrUWmxl0CdipGqx3quCCYlBav31uRDJm2VwwqZNTxeEHWvZN/Y9
tXnkcVSVJkoaJtbGHUvu61g/TAs8ckxlEA9lnaG3SEhNNU5ZSm0aprZJTeRvs81e
iFxzlOKdgZA11GNx8rnj04Ii5MJapgQhDlz5CbOCxvOm6SkZZul+3n6VHxlCJzH2
pQD/GFcynPAbZYitOAyTWAU9K+fZ98dbCkDKJRLMbT8uiZwoc/m59m9ZniDVEKAn
IjUMFrIllpq9F8AZefEFqRV6l9vjM2vam5OS2HC4R+v753JEVKuvTjbJkR7mB9iv
zEGPBciVOjZAWuWmeQVartnDwx4ic2SECxv25w32wcPcrXUs9w0Z/hpIUfG7EAUl
z4dbGlKlXWybq8JLC6ojmL+cgKFAYs+4yfZvE73H9XHlhh1HrGbMc6sd342NCFJN
WjYRbkxGym0=
=LZpe
-----END PGP SIGNATURE-----
