Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129741AbRCCUel>; Sat, 3 Mar 2001 15:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129749AbRCCUec>; Sat, 3 Mar 2001 15:34:32 -0500
Received: from mailout00.sul.t-online.com ([194.25.134.16]:64010 "EHLO
	mailout00.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S129741AbRCCUeW>; Sat, 3 Mar 2001 15:34:22 -0500
Date: 03 Mar 2001 21:32:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <7xADLaBmw-B@khms.westfalen.de>
In-Reply-To: <Pine.LNX.4.21.0103021347010.1321-100000@localhost.localdomain>
Subject: Re: ftruncate not extending files?
X-Mailer: CrossPoint v3.12d.kh5 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <Pine.SGI.4.10.10103021611250.3250157-100000@Sky.inp.nsk.su> <Pine.LNX.4.21.0103021347010.1321-100000@localhost.localdomain>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hugh@veritas.com (Hugh Dickins)  wrote on 02.03.01 in <Pine.LNX.4.21.0103021347010.1321-100000@localhost.localdomain>:

> The SuSv2 quotations, above and in other mail, are just weasly.

The next version is less weasly. Right now it's still a draft; what it  
says in draft 5 is this (note the markers which show what's optional to  
which feature set; XSI aka SUS-next-generation _does_ require expansion):

15245 NAME
15246           ftruncate - truncate a file to a specified length
15247 SYNOPSIS
15248           #include <unistd.h>
15249           int ftruncate(int fildes, off_t length);
15250 DESCRIPTION
15251           If fildes is not a valid file descriptor open for writing, the ftruncate( ) function shall fail.
15252           If fildes refers to a regular file, the ftruncate( ) function shall cause the size of the file to be
15253           truncated to length. If the size of the file previously exceeded length, the extra data shall no
15254           longer be available to reads on the file. If the file previously was smaller than this size,
15255 XSI       ftruncate( ) shall either increase the size of the file or fail.  XSI-conformant systems shall increase
15256           the size of the file. If the file size is increased, the extended area shall appear as if it were zero- |
15257           filled. The value of the seek pointer shall not be modified by a call to ftruncate( ).                              |
15258           Upon successful completion, if fildes refers to a regular file, the ftruncate( ) function shall mark
15259           for update the st_ctime and st_mtime fields of the file and the S_ISUID and S_ISGID bits of the file
15260           mode may be cleared. If the ftruncate( ) function is unsuccessful, the file is unaffected.
15261 XSI       If the request would cause the file size to exceed the soft file size limit for the process, the
15262           request shall fail and the implementation shall generate the SIGXFSZ signal for the thread.                         |
15263           If fildes refers to a directory, ftruncate( ) shall fail.
15264           If fildes refers to any other file type, except a shared memory object, the result is unspecified.
15265 SHM       If fildes refers to a shared memory object, ftruncate( ) shall set the size of the shared memory
15266           object to length.
15267 MF|SHM If the effect of ftruncate( ) is to decrease the size of a shared memory object or memory mapped
15268           file and whole pages beyond the new end were previously mapped, then the whole pages
15269           beyond the new end shall be discarded.
15270 MPR       If the Memory Protection option is supported, references to discarded pages shall result in the
15271           generation of a SIGBUS signal; otherwise, the result of such references is undefined.
15272 MF|SHM If the effect of ftruncate( ) is to increase the size of a shared memory object, it is unspecified if the
15273           contents of any mapped pages between the old end-of-file and the new are flushed to the
15274           underlying object.
15275 RETURN VALUE
15276           Upon successful completion, ftruncate( ) shall return 0; otherwise, -1 shall be returned and errno
15277           set to indicate the error.
15278 ERRORS
15279           The ftruncate( ) function shall fail if:
15280           [EINTR]               A signal was caught during execution.
15281           [EINVAL]              The length argument was less than 0.
15282           [EFBIG] or [EINVAL]
15283                                 The length argument was greater than the maximum file size.
15284 XSI       [EFBIG]               The file is a regular file and length is greater than the offset maximum
15285                                 established in the open file description associated with fildes.
15286           [EIO]                 An I/O error occurred while reading from or writing to a file system.
15287              [EBADF] or [EINVAL]
15288                                   The fildes argument is not a file descriptor open for writing.
15289              [EINVAL]             The fildes argument references a file that was opened without write
15290                                   permission.
15291              [EROFS]              The named file resides on a read-only file system.
15292 EXAMPLES
15293              None.
15294 APPLICATION USAGE
15295              None.
15296 RATIONALE
15297              The ftruncate( ) function is part of IEEE Std 1003.1-200x as it was deemed to be more useful than |
15298              truncate( ). The truncate( ) function is provided as an XSI extension.
15299 FUTURE DIRECTIONS
15300              None.
15301 SEE ALSO
15302              open( ), truncate( ), the Base Definitions volume of IEEE Std 1003.1-200x, <unistd.h>                  |
15303 CHANGE HISTORY
15304              First released in Issue 4, Version 2.
15305 Issue 5
15306              Moved from X/OPEN UNIX extension to BASE and aligned with ftruncate( ) in the POSIX
15307              Realtime Extension. Specifically, the DESCRIPTION is extensively reworded and [EROFS] is
15308              added to the list of mandatory errors that can be returned by ftruncate( ).
15309              Large File Summit extensions are added.
15310 Issue 6
15311              The truncate( ) function has been split out into a separate reference page.
15312              The following new requirements on POSIX implementations derive from alignment with the
15313              Single UNIX Specification:
15314                * The DESCRIPTION is change to indicate that if the file size is changed, and if the file is a
15315                  regular file, the S_ISUID and S_ISGID bits in the file mode may be cleared.
15316              The following changes were made to align with the IEEE P1003.1a draft standard:
15317                * The DESCRIPTION text is updated.
15318              XSI-conformant systems are required to increase the size of the file if the file was previously
15319              smaller than the size requested.

You can get the whole draft by subscribing to the mailing list at
http://www.opengroup.org/austin/.

MfG Kai
