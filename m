Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278099AbRJaA2f>; Tue, 30 Oct 2001 19:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278103AbRJaA2b>; Tue, 30 Oct 2001 19:28:31 -0500
Received: from atlrel6.hp.com ([192.151.27.8]:45073 "HELO atlrel6.hp.com")
	by vger.kernel.org with SMTP id <S278087AbRJaA2R>;
	Tue, 30 Oct 2001 19:28:17 -0500
Message-ID: <3BDF45B6.5B7FA397@fc.hp.com>
Date: Tue, 30 Oct 2001 17:28:38 -0700
From: Khalid Aziz <khalid@fc.hp.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: rjk@greenend.org.uk
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: problem with ide-scsi and IDE tape drive
In-Reply-To: <mailman.1004484541.12716.linux-kernel2news@redhat.com> <200110302359.f9UNxht09639@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev wrote:
> 
> > I originally found this under 2.2.19, and upgraded to 2.4.13 to see if
> > the problem was still there when running more recent code.  It is.
> 
> >     mt -f $TAPE rewind
> >     echo "tape 1" | dd conv=sync of=$TAPE bs=$hsize count=1
> >
> >     for x in 1 2 3; do
> >       mt -f $TAPE rewind
> >       dd if=$TAPE of=/dev/null bs=$hsize
> >       date
> >       tar -c -b 20 -f $TAPE /boot
> >     done
> 
> Try "mt fsf" instead dd, see if that helps.
> 
> -- Pete


dd is not guaranteed toposition you beyond the filemark after the first
record. You have to be positioned beyond the filemark to start writing.
Pete's suggestion is a good one. "mt fsf" will position the tape beyond
the filemark and writing to the tape should work at that point.

-- 
Khalid

====================================================================
Khalid Aziz                              Linux Systems Operation R&D
(970)898-9214                                        Hewlett-Packard
khalid@fc.hp.com                                    Fort Collins, CO
