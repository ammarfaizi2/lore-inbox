Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135589AbREIGA2>; Wed, 9 May 2001 02:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135867AbREIGAS>; Wed, 9 May 2001 02:00:18 -0400
Received: from otter.mbay.net ([206.40.79.2]:48399 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S135589AbREIGAH> convert rfc822-to-8bit;
	Wed, 9 May 2001 02:00:07 -0400
From: jalvo@mbay.net (John Alvord)
To: Larry McVoy <lm@bitmover.com>
Cc: Marty Leisner <leisner@rochester.rr.com>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Wow! Is memory ever cheap!
Date: Wed, 09 May 2001 05:59:41 GMT
Message-ID: <3b13d85d.102553842@mail.mbay.net>
In-Reply-To: <lm@bitmover.com> <200105090424.AAA05768@soyata.home> <20010508222210.B14758@work.bitmover.com>
In-Reply-To: <20010508222210.B14758@work.bitmover.com>
X-Mailer: Forte Agent 1.5/32.451
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 May 2001 22:22:10 -0700, Larry McVoy <lm@bitmover.com>
wrote:
>
>Just to make sure you understand:  I think ECC is a fine thing.  If I'm
>running systems with no other integrity checks, I'll take ECC and like it.
>However, having ECC does not mean that I trust that my data is safe,
>that is most certainly not a true statement.  The bus, the disks, the
>disk controller, the disk driver, the buffer cache, etc, can all corrupt
>the data.   Oh, yeah, let's not forget NFS.  I have seen each and every
>one of those things corrupt data.

This is an interesting observation of a truth that was well known in
the second generation computers of the 1950s and 1960s. I first worked
at John Hancock... they had a bunch of 7074 machines. All those
systems made use of programmed checksums in each tape block and in
each full file. The reason was that those machines did not have ECC...
they did have parity checking if I remember right. With IBM's third
generation computers (S/360s) and probably other manufacturers, ECC
became a standard feature. Parity checking was added through different
data paths such as channel memory, buffer memory, etc. There was so
much protection added that the programmed checksums became
superfluous.

There were still odd moments. I remember working on an Amdahl computer
problem where some internal data paths... where the contents of one
register moved to an internal storage area... and the path did not
have parity. There was a machine fault... the path was electrically
open, so the contents of the register always became zero. But since it
wasn't parity checked, there was no machine check. I remember another
problem on the IBM 3033. Cosmic rays (really) caused one bit errors in
channel memory. That was parity but not ECC so you got a weird channel
check. Back at the diagnosis ranch, the board looked good. It was only
when someone noticed that the rate of such problems was proportional
to the height above sea level that the light bulb went on.

The lesson is that when paths are not checked, hardware or software,
data being held or transformed can change. Old lesson but a good one
to know.

john alvord
