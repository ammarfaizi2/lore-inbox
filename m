Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129675AbRAWT2O>; Tue, 23 Jan 2001 14:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129780AbRAWT2F>; Tue, 23 Jan 2001 14:28:05 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:13319
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129675AbRAWT1u>; Tue, 23 Jan 2001 14:27:50 -0500
Date: Tue, 23 Jan 2001 11:27:02 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.1-test10
In-Reply-To: <Pine.LNX.4.10.10101231103190.2888-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.10.10101231115130.10492-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jan 2001, Linus Torvalds wrote:

> 
> 
> On Tue, 23 Jan 2001, Marcelo Tosatti wrote:
> > 
> > Any technical reason why the background page aging fix was not applied?
> 
> Because I have not heard anybody claim that it makes a huge difference..

Linus,

If it could help speed up the page_list movements because of what appears
to be an offset seek and step direction, thus it is referrence frame for
find these pages is local.  The local reference frame could/should be tied
back to either the head or tail of the page_list for track purposes.

The idea is if we can keep ahead of the laundry list, we may avoid crunch
time in the event that a request of a huge chunk is requested and the busy
beaver has quietly gotten most of the needed pages prepared.  Thus the
possible system-wide delay that can occur may be minimized.

Obviously if you have several big request you get slapped hard.

The point may be that if we have some extra cycles spinning, why not use
them to a painful task when it will not hurt as much?

Just my nickel on the issue.

Cheers,

Andre Hedrick
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
