Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267922AbTBLXMr>; Wed, 12 Feb 2003 18:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267926AbTBLXMr>; Wed, 12 Feb 2003 18:12:47 -0500
Received: from aramis.rutgers.edu ([128.6.4.2]:61074 "EHLO aramis.rutgers.edu")
	by vger.kernel.org with ESMTP id <S267922AbTBLXMp>;
	Wed, 12 Feb 2003 18:12:45 -0500
Subject: Re: O_DIRECT foolish question
From: Bruno Diniz de Paula <diniz@cs.rutgers.edu>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1045090977.21195.87.camel@urca.rutgers.edu>
References: <1045084764.4767.76.camel@urca.rutgers.edu>
	 <20030212140338.6027fd94.akpm@digeo.com>
	 <1045088991.4767.85.camel@urca.rutgers.edu>
	 <20030212224226.GA13129@f00f.org>
	 <1045090977.21195.87.camel@urca.rutgers.edu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-YAvp5XW/ysTX2UgQkmrE"
Organization: Rutgers University
Message-Id: <1045092155.21195.93.camel@urca.rutgers.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 12 Feb 2003 18:22:35 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YAvp5XW/ysTX2UgQkmrE
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Just to complete the information, I am trying to read a file with 5
bytes, and here is the piece of code I am using:

    char *message;
    int fd =3D open("/var/tmp/testopen.txt", O_RDONLY|O_DIRECT);
    int len, pagesize =3D getpagesize();

    posix_memalign((void **)&message, pagesize, pagesize);
    if(fd < 0) {
        printf("Unable to open file, errno is %d.\n", errno);
    } else {
        if((len =3D read(fd, message, pagesize)) < 0) {
			perror("read");
        } else {
            printf("%d bytes read from file.\n", len);
	    printf("Message: %s", message);
        }
    }
    close(fd);

Thanks,

Bruno.

On Wed, 2003-02-12 at 18:02, Bruno Diniz de Paula wrote:
> On Wed, 2003-02-12 at 17:42, Chris Wedgwood wrote:
> > On Wed, Feb 12, 2003 at 05:29:52PM -0500, Bruno Diniz de Paula wrote:
> >=20
> > > But I am using multiples of page size in both buffer alignment and
> > > buffer size (2nd and 3rd parameters of read).  The issue is that
> > > when I try to read files with sizes that are NOT multiples of block
> > > size (and therefore also not multiples of page size), the read
> > > syscall returns 0, with no errors.
> >=20
> > What filesystem?
>=20
> ext2.
>=20
> >=20
> > Can you send an strace of this occurring?
>=20
> execve("./testopen", ["./testopen"], [/* 30 vars */]) =3D 0
> uname({sys=3D"Linux", node=3D"urca", ...})  =3D 0
> brk(0)                                  =3D 0x80497fc
> open("/etc/ld.so.preload", O_RDONLY)    =3D -1 ENOENT (No such file or
> directory)
> open("/etc/ld.so.cache", O_RDONLY)      =3D 3
> fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D57677, ...}) =3D 0
> old_mmap(NULL, 57677, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x40012000
> close(3)                                =3D 0
> open("/lib/libc.so.6", O_RDONLY)        =3D 3
> read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0]Z\1\000"...,
> 1024) =3D 1024
> fstat64(3, {st_mode=3DS_IFREG|0755, st_size=3D1102984, ...}) =3D 0
> old_mmap(NULL, 1112740, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =3D
> 0x40021000
> mprotect(0x40129000, 31396, PROT_NONE)  =3D 0
> old_mmap(0x40129000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED,
> 3, 0x107000) =3D 0x40129000
> old_mmap(0x4012f000, 6820, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x4012f000
> close(3)                                =3D 0
> old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
> -1, 0) =3D 0x40131000
> munmap(0x40012000, 57677)               =3D 0
> open("/var/tmp/testopen.txt", O_RDONLY|O_DIRECT) =3D 3
> brk(0)                                  =3D 0x80497fc
> brk(0x804c7fc)                          =3D 0x804c7fc
> brk(0)                                  =3D 0x804c7fc
> brk(0x804d000)                          =3D 0x804d000
> read(3, "", 4096)                       =3D 0
> fstat64(1, {st_mode=3DS_IFCHR|0600, st_rdev=3Dmakedev(136, 4), ...}) =3D =
0
> old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
> -1, 0) =3D 0x40012000
> write(1, "0 bytes read from file.\n", 240 bytes read from file.
> ) =3D 24
> close(3)                                =3D 0
> write(1, "Message: ", 9Message: )                =3D 9
> munmap(0x40012000, 4096)                =3D 0
> exit_group(0)                           =3D ?
>=20
> Thanks a lot,
>=20
> Bruno.
>=20
> >=20
> > > So the question remains, am I able to read just files whose size is
> > > a multiple of block size?
> >=20
> > No.
> >=20
> > You ideally should be able to read any length file with O_DIRECT.
> > Even a 1-byte file.
> >=20
> >=20
> >=20
> >   --cw
--=20
Bruno Diniz de Paula <diniz@cs.rutgers.edu>
Rutgers University

--=-YAvp5XW/ysTX2UgQkmrE
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+Stc6ZGORSF4wrt8RAs/XAJ9KAFnw/DkGohp/h+KNIio5irBZIgCggODP
tmaKCxkQ9Bz2i9M21vhB8QI=
=t7kJ
-----END PGP SIGNATURE-----

--=-YAvp5XW/ysTX2UgQkmrE--

