Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <160624-3562>; Sat, 20 Mar 1999 12:25:02 -0500
Received: by vger.rutgers.edu id <160193-3563>; Sat, 20 Mar 1999 12:24:41 -0500
Received: from wsdw01.win.tue.nl ([131.155.70.5]:2277 "EHLO wsdw01.win.tue.nl" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <157531-3563>; Sat, 20 Mar 1999 12:24:28 -0500
Date: Sat, 20 Mar 1999 18:27:51 +0100 (MET)
From: dwguest@win.tue.nl (Guest section DW)
Message-Id: <199903201727.SAA05941@wsdw01.win.tue.nl>
To: linux-kernel@vger.rutgers.edu
Subject: Re: disk head scheduling
Sender: owner-linux-kernel@vger.rutgers.edu

On Fri, 19 Mar 1999, Arvind Sankar wrote:

> IBM claims that my hard disk (Model IBM DHEA-38451) has 4 platters and 8 heads.
> I assume these are physical, since there are either 15 or 16 logical heads in
> CHS mode (settable via jumpers).

Yes, it looks like they are physical. In view of semi-recent discussions on
the size of a kilobyte or megabyte, it was amusing to read the data sheet:

# 1.1 Glossary
# Word     Meaning
# Kbpi     1 000 Bit Per Inch
# Mbps     1 000 000 Bit per second
# MB       1 000 000 bytes
# KB       1 000 bytes
# 32 KB    32 x 1 024 bytes
# 64 KB    64 x 1 024 bytes
# Mb/sq.in 1 000 000 bits per square inch


Now everyone knows in advance that an attempt to try and use this
geometry information would be misguided - it would lead to complex
code, with a performance that would not be much better than the present
(but possibly much worse).
And the code would need detailed information that is usually unavailable.

But just for fun: what would be the fastest way of writing a given
collection of sectors to disk? Hmm. Sounds like the travelling salesman
problem, which is NP complete in general. Moreover, there is the added
complication that during the travels of this salesman places to visit
are added to the list.

Does that data sheet give sufficient information to decide where on the disk
a given sector is? In case of errors, sectors are remapped to the inner rim
of the disk, but let us ignore that.
Implicitly we find from the data sheet that there are about 263 sectors
on the outer tracks and about 148 sectors on the inner tracks.
The number of tracks in each of the eight zones is unknown.
Maybe each zone has the same number of tracks, but the total number of
tracks is unknown (maybe about 10000?). The number of sectors per track
in each of the eight zones can only be estimated.
But what is the ordering of the sectors? Unless I overlooked something,
the data sheet is silent about that. But different disks use different
orders (as one can most easily demonstrate by making a graph of transfer
speed versus sector number; if that is roughly monotonically decreasing
the numbering is canonical and discontinuities in the graph show zone limits;
but one also sees different graphs, e.g. with a decrease followed by an increase).

So, maybe we lack information, and cannot really use the spec data to improve
the disk strategy for this single particular disk, even if we wanted to.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
