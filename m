Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129107AbRBGXK6>; Wed, 7 Feb 2001 18:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129135AbRBGXKj>; Wed, 7 Feb 2001 18:10:39 -0500
Received: from hilbert.umkc.edu ([134.193.4.60]:50697 "HELO tesla.umkc.edu")
	by vger.kernel.org with SMTP id <S129107AbRBGXKe>;
	Wed, 7 Feb 2001 18:10:34 -0500
Message-ID: <3A81D5B4.9CBC9B0D@kasey.umkc.edu>
Date: Wed, 07 Feb 2001 17:09:40 -0600
From: "David L. Nicol" <david@kasey.umkc.edu>
Organization: University of Missouri - Kansas City   supercomputing infrastructure
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
CC: "Miller, Brendan" <Brendan.Miller@Dialogic.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: bidirectional named pipe?
In-Reply-To: <E14OxTz-0007yS-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > I'm porting some software to Linux that requires use of a bidirectional,
> > named pipe.  The architecture is as follows:  A server creates a named pipe
> 
> Pipes are not bidirectional in Linux. We follow traditional non stream
> behaviour
> 
> > /dev/spx".  I experiemented with socket-based pipes under Linux, but I
> > couldn't gain access to them by open()ing the name.  Is there help?  I
> 
> AF_UNIX sockets are bidirectional but like all sockets use bind() and
> connect().

How hard would it be to add? The limitation on fifos that you get the same
one every time you open it makes some things tricky -- the server has to
move the fifo and mkfifo a new one to replace its data with something else,
for instance, which is not atomic.

I don't understand, in the original problem, how the server opens
the named bipipe differently from the servers, to be on one end rather than
the other.

A way to map a file name to a socket pair would be nice, the first to open
it could get one end of it and everyone else would get the other end, or there
would be a switch.

You could patch the file system code, I wonder how deep the changes would have
to be, if you did it in terms of lots of fifos.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
