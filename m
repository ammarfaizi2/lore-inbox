Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281929AbRKUQxU>; Wed, 21 Nov 2001 11:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281928AbRKUQxO>; Wed, 21 Nov 2001 11:53:14 -0500
Received: from mcp.csh.rit.edu ([129.21.60.9]:40205 "EHLO mcp.csh.rit.edu")
	by vger.kernel.org with ESMTP id <S281927AbRKUQw5>;
	Wed, 21 Nov 2001 11:52:57 -0500
Date: Wed, 21 Nov 2001 11:52:49 -0500
From: Jeff Mahoney <jeffm@suse.com>
To: Nikita Danilov <Nikita@namesys.com>
Cc: Dieter =?unknown-8bit?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Andreas Dilger <adilger@turbolabs.com>,
        ReiserFS List <reiserfs-list@namesys.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [reiserfs-list] Re: [REISERFS TESTING] new patches on ftp.namesys.com: 2.4.15-pre7
Message-ID: <20011121115249.D17894@fury.csh.rit.edu>
In-Reply-To: <200111210110.fAL1Atc11275@beta.namesys.com> <20011121011655.M1308@lynx.no> <15355.31671.983925.611542@beta.reiserfs.com> <20011121102517Z281563-17408+16912@vger.kernel.org> <15355.39821.401925.96954@beta.reiserfs.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="3Gf/FFewwPeBMqCJ"
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <15355.39821.401925.96954@beta.reiserfs.com>; from Nikita@namesys.com on Wed, Nov 21, 2001 at 03:18:21PM +0300
X-Operating-System: SunOS 5.8 (sun4u)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3Gf/FFewwPeBMqCJ
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 21, 2001 at 03:18:21PM +0300, Nikita Danilov wrote:
> Dieter N=FCtzel writes:
>  > PS Have you read about the latest ACL discussion on LKML?
>=20
> Yes, but Hans thinks we shouldn't do ACL reiserfs 3.x and concentrate on
> v4 in stead. You can try to persuade him though. Same for extended
> attributes.

    I started to write ACL support based on Andreas Gr=FCnbacher's patches =
at
    http://acl.bestbits.at a few months ago. Since there was no decided upon
    format, I stopped development so that I wouldn't leave non-standard
    filesystems in my wake. Once the ACL/EA format/API is finalized, I'll
    probably continue development on it.

    On a more technical note, adding a new item type, such as an
    extended attribute item will cause problems for implementations that
    don't know about them. An idea kicked around a few months ago was to
    simply change the version string so that implementations that don't
    know about ACL support can't mount the new version. "can't mount"
    could conceivably be changed to "can only mount read-only", but certain=
ly
    not read-write, since non-solid items need special handling (every item
    but stat data is non-solid).

    This creates the following scenario:
    * Versions that don't know about the new version string will
      refuse to mount the fs.
    * Versions that know about the new version, but don't implement support
      will be read-only. This is because items get moved during balancing, =
even
      to un-related items. Knowledge of the inside non-solid items is requi=
red
      to move them around. So, even if there is a single ACL on the system,=
 in
      some deep directory, it could affect balancing (cause a panic).
    * Versions that know about the new version, and implement support will
      be read-write.

    I see something along the lines of EXT2's compatibility matrix happening
    here, but due to the inherent incompatibilities, this may not be a prime
    candidate for 2.4 inclusion.

    -Jeff

--=20
Jeff Mahoney           |   "Bill Gates is a monocle and a Persian cat away
jeffm@suse.com         |    from being the villain in a James Bond movie."
jeffm@csh.rit.edu      |                   -- Dennis Miller

--3Gf/FFewwPeBMqCJ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (SunOS)
Comment: For info see http://www.gnupg.org

iD8DBQE7+9vgLPWxlyuTD7IRAliVAJ9xadC9Cyr5oO38ZUSwIdjT9kIvwQCfbtY+
XH6Ol06qXaFMZ0doiEJC5Aw=
=ihFo
-----END PGP SIGNATURE-----

--3Gf/FFewwPeBMqCJ--
