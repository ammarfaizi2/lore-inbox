Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261786AbVF0DYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbVF0DYk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 23:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbVF0DYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 23:24:40 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:33806 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S261786AbVF0DYa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 23:24:30 -0400
Message-ID: <42BF7167.80201@slaphack.com>
Date: Sun, 26 Jun 2005 22:24:23 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050325)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Valdis.Kletnieks@vt.edu, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>, Hans Reiser <reiser@namesys.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl> <42BCD93B.7030608@slaphack.com> <200506251420.j5PEKce4006891@turing-police.cc.vt.edu> <42BDA377.6070303@slaphack.com> <200506252031.j5PKVb4Y004482@turing-police.cc.vt.edu> <42BDC422.6020401@namesys.com> <42BE3645.4070806@cisco.com> <e692861c05062522071fe380a5@mail.gmail.com> <42BE563D.4000402@cisco.com> <42BE5DB6.8040103@slaphack.com> <200506261816.j5QIGMdI010142@turing-police.cc.vt.edu> <42BF08CF.2020703@slaphack.com> <200506262105.j5QL5kdR018609@turing-police.cc.vt.edu> <42BF2DC4.8030901@slaphack.com> <200506270040.j5R0eUNA030632@turing-police.cc.vt.edu> <42BF667C.50606@slaphack.com> <5284F665-873C-45B7-8DDB-5F475F2CE399@mac.com>
In-Reply-To: <5284F665-873C-45B7-8DDB-5F475F2CE399@mac.com>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Kyle Moffett wrote:
> On Jun 26, 2005, at 22:37:48, David Masover wrote:
> 
>> $ make -C linux-2.6.12.zip/.../contents
> 
> 
> I've yet to see how such automatic unzipping does not inherently  introduce
> system insecurity into _existing_ applications by changing POSIX and  UNIX
> semantics.
> 
> When I do this in my suid perl script:
> 
> open my $fh, '<', $ARGV[0];
> 
> I do _not_ mean this:
> system '/bin/zip', 'x', $path1, $path2;
> 
> Neither do I want the kernel to unzip it, because that just  introduces the
> kernel to a whole series of normally application-level vulnerabilities.

That just means the zip plugin has to be more carefully written than I
thought.  It would have to be sandboxed and limited to prevent buffer
overruns and zip bombs.

I think that you could create a situation where an untrusted zip could
be explored, and the worst side effect would be that the files you see
inside the untrusted zip wouldn't be what you expect.  But that's no
surprise -- if the zip is really malicious, there's no amount of
sandboxing that would give you valid files anyway.

I was probably taking this too lightly, though.

Remember that zip, at least, would not be in the kernel.  I think what
is going in the kernel is gzip and lzo, and it's being done so
transparently that you never actually see the compressed version.

> Can you illustrate for me with precise, clear, and unambiguous arguments

That will take some time.  And some thinking.

> how this can avoid all possible pitfalls,

Especially if you want perfection.

> including the automatic encryption/decryption and most other non- standard
> filesystem features (Basically the whole '...' directory), should  probably
> be left out of any patch submitted for inclusion until they can be 
> _proven_
> (or at least thoroughly checked) not to have undesirable results.

I am doing that out of habit.  Actually, it probably ends up more as:
  .../foo.zip/
instead of
  foo.zip/.../

But, it is left out.  At least that interface.

Now, the cryptocompress as it currently stands does not involve ... and
does not introduce any new security holes in the way that you are
describing.  There might be some issues with key management (someone
hinted vaguely at that), but nothing insurmountable.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQr9xZ3gHNmZLgCUhAQKmOA/9EGus4fGXKnBPoK4Rpd9K/6tgy0A7QFIO
EeF50BSgl7M5sot9Vp28Dg1DA9X8gXHf/BxWIUse2doEdrbYKy3HFNd4ZChPFXCS
j4ZtJo/eGYQntIFZ+exNJG2gDeprSBUH9AnMxF9xBfG8CxBdl6WL1dx8d7kc7ip/
UYGiu+9WmC9LanEb0ezhsO8I0KBvjx73Q3FTbD9N0cMIzK1Drv7p9r9rhswsoIzg
eZnKrT2Z0u8BASbd0GfCAT3DH3Zn6zHf6Zk9FOaPaqcLwWlXbELaTbFvBp+2rpnH
9j3NwKHTtCKX5Z2BOQqtiEDEE8QInuDlcEV2K/y4g9YM1mMw3TNoXswaZrbPWWeF
RD/YyzknaDhfgQdz9kQ2bfHJM7//Y9IUJZp/3NmWhvhc2+QBhXBBoTb8UEnRl7tK
D9UIgsDFDVHlLcO9KPKokjyf3fRL57dd0ictHFORvicVIK6NFSfFP9LY/ZsmUXF9
Fbqwwuu8/5n9z5j9IyIqf5m7XJkHcZCeLFDkn89VS4ZM8W1aB0g3yRIlhSEDDkVt
0nZZRzvIlRHCPoPMZuoFhWSngi50ZAYXlRicKrHQERP8f7ECkB1JvY2rLSFqM+FX
BGUZpXxgHe/zgg806ACNbfdnny5WgZ7qXl/IXD9svQa3lIgxY6We8ACj8Oi6c7eu
5ooBcT7AmRE=
=pBA8
-----END PGP SIGNATURE-----
