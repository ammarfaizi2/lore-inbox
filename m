Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131664AbRASPAe>; Fri, 19 Jan 2001 10:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131629AbRASPAZ>; Fri, 19 Jan 2001 10:00:25 -0500
Received: from host213-120-148-5.btopenworld.com ([213.120.148.5]:65123 "EHLO
	nvlonlx01.nv.london") by vger.kernel.org with ESMTP
	id <S131466AbRASPAJ>; Fri, 19 Jan 2001 10:00:09 -0500
Date: Fri, 19 Jan 2001 14:59:45 +0000 (UTC)
From: Mo McKinlay <mmckinlay@gnu.org>
To: Michael Rothwell <rothwell@holly-springs.nc.us>
cc: Mo McKinlay <mmckinlay@gnu.org>, Peter Samuelson <peter@cadcamlab.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: named streams, extended attributes, and posix
In-Reply-To: <3A685190.A8CB3D1F@holly-springs.nc.us>
Message-ID: <Pine.LNX.4.30.0101191455570.2331-100000@nvws005.nv.london>
Organization: inter/open Labs
X-URL: http://www.interopen.org/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


  > Well, EAs are accessed via a special API. The paper also covers that.
  > Streams, however, are by nature accessed as files; this is what makes
  > them not EAs. EAs are set and retrieved atomically. Streams can be used
  > with open(), seek(), read(), write(), etc. This is actually more "unixy"
  > than EAs, as the usual set of Unix functions and tools can work with
  > streams unmodified; i.e., without knowledge of a special API. Of course,
  > cp() is the exception. It would have to be able to enumerate and copy
  > all the streams.

Hokay, I've skimmed the paper, most of it makes sense, although I still
think the additional separator is a bad idea (which I know isn't what I
said last time around, originally, but I've had a chance to ponder a
little more since :). Hence, I reckon we should have:

openstream(file, stream, flags)

Where 'file' should be an fd (although i'm sure the VFS gods will think of
plenty of reasons why this is a bad idea, at which point I'll
conventiently change my mind ;). Stream is simply the name of the stream,
flags are as with open() (O_RDONLY, et al). openstream() then returns an
fd which can be read/written/sendfiled/closed as the programmer wishes.

How daft does this sound?

Apart from the additional of a new open()-type call, your paper seems to
be fairly solid.

Mo.

- -- 
Mo McKinlay
mmckinlay@gnu.org
- -------------------------------------------------------------------------
GnuPG/PGP Key: pub  1024D/76A275F9 2000-07-22








-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjpoVmMACgkQRcGgB3aidfnLuACfSZqvswA0B1xnWilVWQcSHubM
yQAAn2T+RFRN3qznuQ8wOeWXxIBVGb45
=SUm5
-----END PGP SIGNATURE-----

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
