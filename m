Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315941AbSFJT6F>; Mon, 10 Jun 2002 15:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315942AbSFJT6E>; Mon, 10 Jun 2002 15:58:04 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:25078 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S315941AbSFJT6D>; Mon, 10 Jun 2002 15:58:03 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Mon, 10 Jun 2002 13:56:10 -0600
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Joseph Cheek <joseph@cheek.com>, linux-kernel@vger.kernel.org
Subject: Re: procedure for creating new ioctl?
Message-ID: <20020610195610.GO20388@turbolinux.com>
Mail-Followup-To: "Richard B. Johnson" <root@chaos.analogic.com>,
	Joseph Cheek <joseph@cheek.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3D04EB4F.4030107@cheek.com> <Pine.LNX.3.95.1020610141444.17491A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 10, 2002  14:17 -0400, Richard B. Johnson wrote:
> I use SIOCDEVPRIVATE as the starting value for new ioctls:
> 
> /*
>  *   Interface to the private device functions. User API sees this only.
>  */
> #define CHEK_SEEPROM   SIOCDEVPRIVATE + 0x07
> #define READ_SEEPROM   SIOCDEVPRIVATE + 0x08
> #define WRITE_SEEPROM  SIOCDEVPRIVATE + 0x09
> 
> 
> I've seen this in several drivers. I think this is the way to do it
> so there is no interference with other ioctls.

Of course there is.  That means that a program accidentally running on
the wrong device will get completely unexpected results because the
ioctl numbers will all be some value above SIOCDEVPRIVATE.

Since each of the drivers have (mostly) their own private ioctl handling,
there is less of an issue of actual ioctl number conflicts as there
is an issue that ioctl numbers should be globally unique to avoid
accidental side effects when running on an incorrect device.

Besides which, SIOCDEVPRIVATE is supposed to be for socket (networking)
ioctls and not just random ioctl values.  The comment above it also
indicates this value is deprecated...

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

