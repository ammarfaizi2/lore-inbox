Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315388AbSE2OfN>; Wed, 29 May 2002 10:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315413AbSE2OfM>; Wed, 29 May 2002 10:35:12 -0400
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:37904 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315388AbSE2OfL>; Wed, 29 May 2002 10:35:11 -0400
Date: Wed, 29 May 2002 15:35:04 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Gerald Champagne <gerald@io.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.18 IDE 73
Message-ID: <20020529153504.C30585@flint.arm.linux.org.uk>
In-Reply-To: <1022680784.2945.24.camel@wiley> <3CF4D19F.9080402@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2002 at 03:03:27PM +0200, Martin Dalecki wrote:
> Dear Gerald please look closer. The hdparm -i is executing the
> drive id command directly and does *not* rely on the internally

hdparm -i uses the HDIO_GET_IDENTITY ioctl, which returns drive->id.
It doesn't obtain the ID from the drive.  hdparm -I asks the
identity from the drive.

hdparm --help gives some hints:

 -i   display drive identification
 -I   read drive identification directly from drive

and the man page is quite clear:

       -i     Display the identification info that  was  obtained
              from the drive at boot time, if available.  This is
              a feature of modern IDE drives, and may not be sup­
              ported  by older devices.  The data returned may or
              may not be current,  depending  on  activity  since
              booting  the system.  However, the current multiple
              sector mode count is  always  shown.   For  a  more
              detailed interpretation of the identification info,
              refer to AT Attachment Interface  for  Disk  Drives
              (ANSI  ASC X3T9.2 working draft, revision 4a, April
              19/93).

       -I     Request  identification  info  directly  from   the
              drive,  which  is displayed in its raw form with no
              endian changes or corrections.   Text  strings  may
              appear mangled when using -I but that is NOT a bug.
              Otherwise similar to the -i option.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

