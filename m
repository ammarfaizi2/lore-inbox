Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <157230-27300>; Sun, 31 Jan 1999 03:35:53 -0500
Received: by vger.rutgers.edu id <154209-27302>; Sun, 31 Jan 1999 03:35:45 -0500
Received: from noc.nyx.net ([206.124.29.3]:3110 "EHLO noc.nyx.net" ident: "mail") by vger.rutgers.edu with ESMTP id <154241-27302>; Sun, 31 Jan 1999 03:35:18 -0500
Date: Sun, 31 Jan 1999 01:47:23 -0700 (MST)
From: Colin Plumb <colin@nyx.net>
Message-Id: <199901310847.BAA07662@nyx10.nyx.net>
X-Nyx-Envelope-Data: Date=Sun Jan 31 01:47:23 1999, Sender=colin, Recipient=, Valsender=colin@localhost
To: lm@bitmover.com
Subject: Re: Page coloring HOWTO [ans]
Cc: linux-kernel@vger.rutgers.edu
Sender: owner-linux-kernel@vger.rutgers.edu

Larry McVoy wrote:

> Page allocation becomes hash on virtual address and take a page from
> the bucket.However, here's the trick that fans them out in the cache,
> you hash on virtual address plus pid (I don't remember the exact details
> but you'll get it immeditately when you implement it - you just process
> 0 to take page 0 from bucket 0, process 1 to take page 0 from bucket 1,
> and so on).

Um, this is difficult, given that the same virtual->physical mapping
may be present in multiple processes.  Which pid do I use?

I think that assigning a colour to the vm_area_struct would be better.
You *would* have essentially random relationships between the colour offsets
of the various vm_area_structs in a process (text, data, stack).

Erm, I just thought of COW issues.  which arise because the data
segment is mapped COW from the backing file.  Do the cow-copied pages
have different colour offsets then the pages htey're copied from?

I can see disadvnatages to both possible answers.
-- 
	-Colin

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
