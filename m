Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271834AbTG2Pp6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 11:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271839AbTG2Pp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 11:45:58 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:56068 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S271834AbTG2Pp4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 11:45:56 -0400
Date: Tue, 29 Jul 2003 17:52:48 +0200
To: Timothy Miller <miller@techsource.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ingo Molnar and Con Kolivas 2.6 scheduler patches
Message-ID: <20030729155248.GA5495@hh.idb.hist.no>
References: <1059211833.576.13.camel@teapot.felipe-alfaro.com> <200307271046.30318.phillips@arcor.de> <20030726113522.447578d8.akpm@osdl.org> <200307271517.55549.phillips@arcor.de> <3F267CF9.40500@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F267CF9.40500@techsource.com>
User-Agent: Mutt/1.5.4i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 29, 2003 at 09:56:09AM -0400, Timothy Miller wrote:
> I have a couple of questions about the interactive scheduling.
> 
> 
> First, since we're dealing with real-time and audio issues, is there any 
> way we can do this:  When the interrupt arrives from the sound card so 
> that the driver needs to set up DMA for the next block or whatever it 
> does, move any processes which talk to an audio device to the head of 
> the process queue?  Can this idea be applied to other things, such as 
> moving X to the head of the queue when the DRI driver gets a "there is 
> free space in the command queue" interrupt from the graphics engine?
> 
This is sort of what interactivity bonus is all about, although
on a more general level.  I.e. app wait for io, io
happens, app wakes up with priority bonus which it may use for processing
the io or start another one.

This goes for sound, graphichs, and ordinary disk file io.

There is no explicit connection between sound drivers and
processes - the processes get the bonus because they waited for
the io (in this case sound) to happen.  Explicit connections
of this kind is hard to set up, because there may be several
processes using the sound device, or even several sound devices.
Even more so for graphichs - lots of processes use the same display.

If you care more about sound than  anything else, run your
sound apps at higher priority than other processes.

Helge Hafting

