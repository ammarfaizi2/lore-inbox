Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264310AbUBHSpg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 13:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264353AbUBHSpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 13:45:36 -0500
Received: from colo.khms.westfalen.de ([213.239.196.208]:650 "EHLO
	colo.khms.westfalen.de") by vger.kernel.org with ESMTP
	id S264310AbUBHSpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 13:45:34 -0500
Date: 08 Feb 2004 17:58:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <92VRVYaHw-B@khms.westfalen.de>
In-Reply-To: <pan.2004.02.06.18.59.44.936432@smurf.noris.de>
Subject: Re: VFS locking: f_pos thread-safe ?
X-Mailer: CrossPoint v3.12d.kh13 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
References: <pan.2004.02.06.18.59.44.936432@smurf.noris.de>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

smurf@smurf.noris.de (Matthias Urlichs)  wrote on 06.02.04 in <pan.2004.02.06.18.59.44.936432@smurf.noris.de>:

> Hi, viro wrote:
>
> > "Somebody made a guess about undefined behaviour"
>
> Guess what? The manpage says that read(2) return N bytes and advances the
> file pointer by N bytes. It doesn't talk, much less caution, about threads.

That's a defect in the man page, then.

POSIX says on <http://www.opengroup.org/onlinepubs/007904975/functions/ 
read.html>:

[...]
DESCRIPTION

The read() function shall attempt to read nbyte bytes from the file
associated with the open file descriptor, fildes, into the buffer pointed
to by buf. The behavior of multiple concurrent reads on the same pipe,
FIFO, or terminal device is unspecified.
[...]

That's a pretty explicit warning exactly where one would expect it.

If Linux read(2) doesn't say something like that, I'll consider that a  
serious bug.

OTOH ...

> YOU may immediately know, based on your kernel knowledge or whatever, that
> things get somewhat undefined when two threads do that at the same time,
> but it's NOT AT ALL obvious to a "normal" application programmer. There's
> plenty of system calls that CAN be done concurrently, after all.

... these days, programmers really *should* know enough to consult a free,  
current, and easily readable version of the relevant standard!

(If you forget where it is, it's easy to find from <http://www.unix- 
systems.org/>.)

> Please save your "translations" for stupid ideas that are obviously so
> without in-depth kernel knowledge or equivalent.

... such as the current case.

MfG Kai
