Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318032AbSIFGmT>; Fri, 6 Sep 2002 02:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318086AbSIFGmT>; Fri, 6 Sep 2002 02:42:19 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:57870 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S318032AbSIFGmS>; Fri, 6 Sep 2002 02:42:18 -0400
Message-ID: <3D784F8A.CE0CF1DB@aitel.hist.no>
Date: Fri, 06 Sep 2002 08:47:38 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.33 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: One more bio for for floppy users in 2.5.33..
References: <Pine.LNX.4.33.0209051310190.5983-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
[...]
> I do think we might make the read-ahead window configurable, and make slow
> devices have slightly smaller windows.
> 
> On the other hand, I don't think the 64kB IO actually _hurts_ per se, as
> long as it doesn't delay the stuff we care about.

I can think of one case where large readahead hurts for floppy, even
with partial completion:

1. Grab a stack of floppies
2. Try mounting (or mount+ls) one after another,
   in search of the right one.

You'll get the results on screen fast enough 
(mount succeeded/failed or ls showed the right/wrong files)
but when it is the wrong floppy you have to wait for
several tracks to read before you may eject and try
the next one.  

Sure, it is only reading so ejecting "by force" won't
hurt the fs but then you have to wait on io errors instead.

So I think a smaller readahead might make sense for floppies,
unless people don't do this sort of search anymore.  I don't.

Helge Hafting
