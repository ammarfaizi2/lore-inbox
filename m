Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268405AbRGXRxW>; Tue, 24 Jul 2001 13:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268400AbRGXRxD>; Tue, 24 Jul 2001 13:53:03 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:27153 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S268401AbRGXRwx>; Tue, 24 Jul 2001 13:52:53 -0400
Date: Tue, 24 Jul 2001 14:52:50 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Mike Castle <dalgoda@ix.netcom.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Optimization for use-once pages
In-Reply-To: <20010724104453.G5835@thune.mrc-home.com>
Message-ID: <Pine.LNX.4.33L.0107241451210.20326-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, 24 Jul 2001, Mike Castle wrote:
> On Tue, Jul 24, 2001 at 02:07:32PM -0300, Rik van Riel wrote:
> > > I hate to bother you directly, but I don't wish to start a flame
> > > war on lkml. How exactly would you explain two accesses as
> > > being "used once"?
> >
> > Because they occur in a very short interval, an interval MUCH
> > shorter than the time scale in which the VM subsystem looks at
> > referenced bits, etc...
>
> Would mmap() then a for(;;) loop over the range be an example of
> such a use?

Yes. The problem here, however, would be that we'll only find
the referenced bit in the page table some time later.

This is another reason for having a "new" queue like 2Q's A1in
queue. It means we can both count all accesses in the first short
period as one access AND we can avoid actually doing anything
special as these accesses happen....

regards,

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

