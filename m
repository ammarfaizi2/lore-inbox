Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293010AbSCRWHq>; Mon, 18 Mar 2002 17:07:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293092AbSCRWHg>; Mon, 18 Mar 2002 17:07:36 -0500
Received: from fungus.teststation.com ([212.32.186.211]:34059 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S293089AbSCRWH2>; Mon, 18 Mar 2002 17:07:28 -0500
Date: Mon, 18 Mar 2002 23:07:25 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: puw@cola.teststation.com
To: SeongTae Yoo <alloying@nownuri.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: file listing problem in smbfs, kernel 2.4.18
In-Reply-To: <3C91B206.6EA173B7@nownuri.net>
Message-ID: <Pine.LNX.4.44.0203182148020.15143-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Mar 2002, SeongTae Yoo wrote:

> I have mounted a share of w2k server(SP2). All file lists is not seen
> in a specific sub directory.
> 
> The error log is follows as:
> 
>     smb_proc_readdir_long: name=, result=-2, rcls=1, err=123

This error code has been seen with readdir requests before. Seems like it
is used for a few different things, but I think it indicates a problem
with how smbfs sends requests.

One of the cases sounds a lot like yours. Directory listings that fail on
some directories, adding a file or renaming one changes something to
trigger failure or not.
(possibly the sum of the length of the filenames matters, that could be a
 useful test case ...)

If this is the same thing then it was believed fixed in 2.2.16 by moving
to "infolevel" 260 and not using resume keys.

I'm a bit busy with non-linux things right now so I haven't tested
anything myself yet but you could help by answering some of the questions
below.

You could also try the smbfs unicode patch for 2.4.18, and see if that
changes anything.
    http://www.hojdpunkten.ac.se/054/samba/index.html
    (Note the additional samba patch and mount flags needed)


Do you have trouble with this set of files elsewhere?

If you have more than one server, does it make any difference if you copy
the files to some other server?

Does it matter how deep in the file hierarchy the dir is, for example is
there any difference between these two:
   //server/share/some/long/path/the-dir-that-fails/
   //server/share/the-dir-that-fails/


(If the files are large you could do something like this on your linux
 box:

mkdir apa
cd apa
touch `cat ../filelist.txt`
cd ..
zip -r apa.zip apa

to create a zip of empty files and then unpack apa.zip in various places.
It is most likely only the filenames that matter.)

/Urban

