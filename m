Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315420AbSGQRFN>; Wed, 17 Jul 2002 13:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315431AbSGQRFN>; Wed, 17 Jul 2002 13:05:13 -0400
Received: from khms.westfalen.de ([62.153.201.243]:55509 "EHLO
	khms.westfalen.de") by vger.kernel.org with ESMTP
	id <S315420AbSGQRFL>; Wed, 17 Jul 2002 13:05:11 -0400
Date: 17 Jul 2002 09:34:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8T0FFRWHw-B@khms.westfalen.de>
In-Reply-To: <20020717022252.GA30570@eskimo.com>
Subject: Re: close return value (was Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
X-Mailer: CrossPoint v3.12d.kh9 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
References: <1026867782.1688.108.camel@irongate.swansea.linux.org.uk> <20020716232225.GH358@codesourcery.com> <1026867782.1688.108.camel@irongate.swansea.linux.org.uk> <20020717022252.GA30570@eskimo.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

elladan@eskimo.com (Elladan)  wrote on 16.07.02 in <20020717022252.GA30570@eskimo.com>:

> I believe this demonstrates the need for a standard, one way, or the
> other.  :-)

So then let's see what the actual standard says ...

--- snip ---

                 The Open Group Base Specifications Issue 6
                            IEEE Std 1003.1-2001
     Copyright + 2001 The IEEE and The Open Group, All Rights reserved.
     _________________________________________________________________

    NAME

     close - close a file descriptor

    SYNOPSIS

     #include <unistd.h>
     int close(int fildes);

    DESCRIPTION

     The close() function shall deallocate the file descriptor indicated
     by fildes. To deallocate means to make the file descriptor
     available for return by subsequent calls to open() or other
     functions that allocate file descriptors. All outstanding record
     locks owned by the process on the file associated with the file
     descriptor shall be removed (that is, unlocked).

     If close() is interrupted by a signal that is to be caught, it
     shall return -1 with errno set to [EINTR] and the state of fildes
     is unspecified. If an I/O error occurred while reading from or
     writing to the file system during close(), it may return -1 with
     errno set to [EIO]; if this error is returned, the state of fildes
     is unspecified.

     When all file descriptors associated with a pipe or FIFO special
     file are closed, any data remaining in the pipe or FIFO shall be
     discarded.

     When all file descriptors associated with an open file description
     have been closed, the open file description shall be freed.

     If the link count of the file is 0, when all file descriptors
     associated with the file are closed, the space occupied by the file
     shall be freed and the file shall no longer be accessible.

     [XSR] [Option Start] If a STREAMS-based fildes is closed and the
     calling process was previously registered to receive a SIGPOLL
     signal for events associated with that STREAM, the calling process
     shall be unregistered for events associated with the STREAM. The
     last close() for a STREAM shall cause the STREAM associated with
     fildes to be dismantled. If O_NONBLOCK is not set and there have
     been no signals posted for the STREAM, and if there is data on the
     module's write queue, close() shall wait for an unspecified time
     (for each module and driver) for any output to drain before
     dismantling the STREAM. The time delay can be changed via an
     I_SETCLTIME ioctl() request. If the O_NONBLOCK flag is set, or if
     there are any pending signals, close() shall not wait for output to
     drain, and shall dismantle the STREAM immediately.

     If the implementation supports STREAMS-based pipes, and fildes is
     associated with one end of a pipe, the last close() shall cause a
     hangup to occur on the other end of the pipe. In addition, if the
     other end of the pipe has been named by fattach(), then the last
     close() shall force the named end to be detached by fdetach(). If
     the named end has no open file descriptors associated with it and
     gets detached, the STREAM associated with that end shall also be
     dismantled. [Option End]

     [XSI] [Option Start] If fildes refers to the master side of a
     pseudo-terminal, and this is the last close, a SIGHUP signal shall
     be sent to the process group, if any, for which the slave side of
     the pseudo-terminal is the controlling terminal. It is unspecified
     whether closing the master side of the pseudo-terminal flushes all
     queued input and output. [Option End]

     [XSR] [Option Start] If fildes refers to the slave side of a
     STREAMS-based pseudo-terminal, a zero-length message may be sent to
     the master. [Option End]

     [AIO] [Option Start] When there is an outstanding cancelable
     asynchronous I/O operation against fildes when close() is called,
     that I/O operation may be canceled. An I/O operation that is not
     canceled completes as if the close() operation had not yet
     occurred. All operations that are not canceled shall complete as if
     the close() blocked until the operations completed. The close()
     operation itself need not block awaiting such I/O completion.
     Whether any I/O operation is canceled, and which I/O operation may
     be canceled upon close(), is implementation-defined. [Option End]

     [MF|SHM] [Option Start] If a shared memory object or a memory
     mapped file remains referenced at the last close (that is, a
     process has it mapped), then the entire contents of the memory
     object shall persist until the memory object becomes unreferenced.
     If this is the last close of a shared memory object or a memory
     mapped file and the close results in the memory object becoming
     unreferenced, and the memory object has been unlinked, then the
     memory object shall be removed. [Option End]

     If fildes refers to a socket, close() shall cause the socket to be
     destroyed. If the socket is in connection-mode, and the SO_LINGER
     option is set for the socket with non-zero linger time, and the
     socket has untransmitted data, then close() shall block for up to
     the current linger interval until all data is transmitted.

    RETURN VALUE

     Upon successful completion, 0 shall be returned; otherwise, -1
     shall be returned and errno set to indicate the error.

    ERRORS

     The close() function shall fail if:
   [EBADF]
          The fildes argument is not a valid file descriptor.
   [EINTR]
          The close() function was interrupted by a signal.

     The close() function may fail if:
   [EIO]
          An I/O error occurred while reading from or writing to the file
          system.
     _________________________________________________________________

   The following sections are informative.

    EXAMPLES

      Reassigning a File Descriptor

     The following example closes the file descriptor associated with
     standard output for the current process, re-assigns standard output
     to a new file descriptor, and closes the original file descriptor
     to clean up. This example assumes that the file descriptor 0 (which
     is the descriptor for standard input) is not closed.
#include <unistd.h>
...
int pfd;
...
close(1);
dup(pfd);
close(pfd);
...

     Incidentally, this is exactly what could be achieved using:
dup2(pfd, 1);
close(pfd);

      Closing a File Descriptor

     In the following example, close() is used to close a file
     descriptor after an unsuccessful attempt is made to associate that
     file descriptor with a stream.
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>

#define LOCKFILE "/etc/ptmp"
...
int pfd;
FILE *fpfd;
...
if ((fpfd = fdopen (pfd, "w")) == NULL) {
    close(pfd);
    unlink(LOCKFILE);
    exit(1);
}
...

    APPLICATION USAGE

     An application that had used the stdio routine fopen() to open a
     file should use the corresponding fclose() routine rather than
     close(). Once a file is closed, the file descriptor no longer
     exists, since the integer corresponding to it no longer refers to a
     file.

    RATIONALE

     The use of interruptible device close routines should be
     discouraged to avoid problems with the implicit closes of file
     descriptors by exec and exit(). This volume of IEEE Std 1003.1-2001
     only intends to permit such behavior by specifying the [EINTR]
     error condition.

    FUTURE DIRECTIONS

     None.

    SEE ALSO

     STREAMS , fattach() , fclose() , fdetach() , fopen() , ioctl() ,
     open() , the Base Definitions volume of IEEE Std 1003.1-2001,
     <unistd.h>

    CHANGE HISTORY

     First released in Issue 1. Derived from Issue 1 of the SVID.

    Issue 5

     The DESCRIPTION is updated for alignment with the POSIX Realtime
     Extension.

    Issue 6

     The DESCRIPTION related to a STREAMS-based file or pseudo-terminal
     is marked as part of the XSI STREAMS Option Group.

     The following new requirements on POSIX implementations derive from
     alignment with the Single UNIX Specification:
     * The [EIO] error condition is added as an optional error.
     * The DESCRIPTION is updated to describe the state of the fildes
       file descriptor as unspecified if an I/O error occurs and an [EIO]
       error condition is returned.

     Text referring to sockets is added to the DESCRIPTION.

     The DESCRIPTION is updated for alignment with IEEE Std 1003.1j-2000
     by specifying that shared memory objects and memory mapped files
     (and not typed memory objects) are the types of memory objects to
     which the paragraph on last closes applies.

   End of informative text.
     _________________________________________________________________
     _________________________________________________________________

            UNIX « is a registered Trademark of The Open Group.
               POSIX « is a registered Trademark of The IEEE.
                  [ Main Index | XBD | XCU | XSH | XRAT ]
     _________________________________________________________________
--- snip ---

The standard is very explicit here: When close() returns an error,
*YOU LOSE*.

MfG Kai
