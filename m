Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <970999-19466>; Tue, 24 Mar 1998 13:41:36 -0500
Received: from nyx10.nyx.net ([206.124.29.2]:3589 "EHLO nyx10.nyx.net" ident: "colin") by vger.rutgers.edu with ESMTP id <971003-19466>; Tue, 24 Mar 1998 13:40:28 -0500
Date: Tue, 24 Mar 1998 11:43:28 -0700 (MST)
From: Colin Plumb <colin@nyx.net>
Message-Id: <199803241843.LAA25640@nyx10.nyx.net>
X-Nyx-Envelope-Data: Date=Tue Mar 24 11:43:28 1998, Sender=colin, Recipient=linux-kernel@vger.rutgers.edu, Valsender=colin@localhost
To: linux-kernel@vger.rutgers.edu
Subject: Re: Modified floppies can crash Linux (fwd)
Sender: owner-linux-kernel@vger.rutgers.edu

Something that might be helpful when fixing this:

A very efficient way to detect loops in a chain is to compare each element
chain[i] with chain[j], where j is the largest power of 2 less than i.

E.g.

void
traverse_linked_list(struct linked_list *p)
{
	struct linked_list *bookmark = NULL;
	unsigned counter = 0;

	while (p && p != bookmark) {
		process_node(p);
		counter++;
		if (!(counter & (counter-1))	/* Is counter a power of 2? */
			bookmark = p;
		p = p->next;
	}
	if (p) {
		/* We have processed part of the chain twice, but
		 * at least we can escape the loop.
		 */
		printk("Bad chain, aborting traversal.");
	}
}

Hacking this into kernel code is left as an exercise for the reader...
-- 
	-Colin

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
