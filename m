Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285178AbRLMVCY>; Thu, 13 Dec 2001 16:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285181AbRLMVCG>; Thu, 13 Dec 2001 16:02:06 -0500
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:35499 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S285169AbRLMVCB>; Thu, 13 Dec 2001 16:02:01 -0500
Message-Id: <5.1.0.14.2.20011213205108.04fc3760@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 13 Dec 2001 21:01:54 +0000
To: Andrew Pimlott <andrew@pimlott.ne.mediaone.net>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: reiser4 (was Re: [PATCH] Revised extended attributes 
  interface)
Cc: Hans Reiser <reiser@namesys.com>, Nathan Scott <nathans@sgi.com>,
        Andreas Gruenbacher <ag@bestbits.at>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@oss.sgi.com
In-Reply-To: <20011213102729.B3812@pimlott.ne.mediaone.net>
In-Reply-To: <3C1873A2.1060702@namesys.com>
 <20011205143209.C44610@wobbly.melbourne.sgi.com>
 <20011207202036.J2274@redhat.com>
 <20011208155841.A56289@wobbly.melbourne.sgi.com>
 <3C127551.90305@namesys.com>
 <20011211134213.G70201@wobbly.melbourne.sgi.com>
 <5.1.0.14.2.20011211184721.04adc9d0@pop.cus.cam.ac.uk>
 <3C1678ED.8090805@namesys.com>
 <20011212204333.A4017@pimlott.ne.mediaone.net>
 <3C1873A2.1060702@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 15:27 13/12/01, Andrew Pimlott wrote:
>(Anton, does NTFS define any reserved filename characters, or only
>win32?)

It does. RTFS. (-8

 From ntfs-driver-tng/linux/fs/ntfs/layout.h:

/*
  * The maximum allowed length for a file name.
  */
#define MAXIMUM_FILE_NAME_LENGTH 255

/*
  * Possible namespaces for filenames in ntfs (8-bit).
  */
typedef enum {
         FILE_NAME_POSIX                 = 0x00,
                 /* This is the largest namespace. It is case sensitive and
                    allows all Unicode characters except for: '\0' and '/'.
                    Beware that in WinNT/2k files which eg have the same name
                    except for their case will not be distinguished by the
                    standard utilities and thus a "del filename" will delete
                    both "filename" and "fileName" without warning. */
         FILE_NAME_WIN32                 = 0x01,
                 /* The standard WinNT/2k NTFS long filenames. Case 
insensitive.
                    All Unicode chars except: '\0', '"', '*', '/', ':', '<',
                    '>', '?', '\' and '|'. Further, names cannot end with a '.'
                    or a space. */
         FILE_NAME_DOS                   = 0x02,
                 /* The standard DOS filenames (8.3 format). Uppercase only.
                    All 8-bit characters greater space, except: '"', '*', '+',
                    ',', '/', ':', ';', '<', '=', '>', '?' and '\'. */
         FILE_NAME_WIN32_AND_DOS         = 0x03,
                 /* 3 means that both the Win32 and the DOS filenames are
                    identical and hence have been saved in this single filename
                    record. */
} __attribute__ ((__packed__)) FILE_NAME_TYPE_FLAGS;

The whole of layout.h can be viewed here (link to view of CVS):

http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/linux-ntfs/ntfs-driver-tng/linux/fs/ntfs/layout.h?rev=1.6&content-type=text/vnd.viewcvs-markup

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

