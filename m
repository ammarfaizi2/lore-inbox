Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275743AbRJNQ2O>; Sun, 14 Oct 2001 12:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275758AbRJNQ2F>; Sun, 14 Oct 2001 12:28:05 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:64968 "EHLO
	mailout06.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S275739AbRJNQ15>; Sun, 14 Oct 2001 12:27:57 -0400
Date: 14 Oct 2001 14:57:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Message-ID: <8Asil-B1w-B@khms.westfalen.de>
In-Reply-To: <Pine.LNX.4.33.0110130956350.8707-100000@penguin.transmeta.com>
Subject: Re: Security question: "Text file busy" overwriting executables but no
X-Mailer: CrossPoint v3.12d.kh7 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <Pine.LNX.4.33.0110130956350.8707-100000@penguin.transmeta.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

torvalds@transmeta.com (Linus Torvalds)  wrote on 13.10.01 in <Pine.LNX.4.33.0110130956350.8707-100000@penguin.transmeta.com>:

> Now, somebody who _isn't_ stupid (and that, of course, is me), immediately
> goes "well, _duh_, why don't you speed up read() instead?".

Probably because people think that's hard ... so they invent another thing  
that's even harder.

> The fact is, all the problems that "MAP_COPY" has just go away if you
> instead of thinking about a mmap(), you think about doing a "read()" and
> just marking the pages PAGE_COPY if they are exclusive.

That's part of the problem. The other is the idea that mmap only needs to  
read those pages actually needed.

Hmm.

Would it be possible - and cheap enough - to do this optimization:

When read()ing a file, *if* nobody else has that inode open (which is  
probably impossible to determine with networked filesystems, so one would  
probably have to exclude those), create mmap-like mappings where possible  
without actually reading the pages; at the moment someone else opens the  
file, actually read them in and mark them PAGE_COPY.

Or maybe just do it exclusive of writers, not readers.

(I don't think waiting for actual writes would be sensible.)

MfG Kai
