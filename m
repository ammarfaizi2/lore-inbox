Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130469AbQLIIIS>; Sat, 9 Dec 2000 03:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130486AbQLIIII>; Sat, 9 Dec 2000 03:08:08 -0500
Received: from cr722548-a.crdva1.bc.wave.home.com ([24.115.203.90]:15920 "EHLO
	straylight.cyberhqz.com") by vger.kernel.org with ESMTP
	id <S130469AbQLIIH7>; Sat, 9 Dec 2000 03:07:59 -0500
From: Ryan Murray <rmurray@cyberhqz.com>
Date: Fri, 8 Dec 2000 23:37:30 -0800
To: linux-kernel@vger.kernel.org
Cc: ricdude@toad.net, "John M. Flinchbaugh" <glynis@butterfly.hjsoft.com>
Subject: Re: esound over tcp problem with linux-2.4.0-test[89]
Message-ID: <20001208233730.D2002@cyberhqz.com>
Mail-Followup-To: rmurray, linux-kernel@vger.kernel.org, ricdude@toad.net,
	"John M. Flinchbaugh" <glynis@butterfly.hjsoft.com>
In-Reply-To: <20001004120532.A32577@butterfly.hjsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001004120532.A32577@butterfly.hjsoft.com>; from glynis@butterfly.hjsoft.com on Wed, Oct 04, 2000 at 12:05:32PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2000 at 12:05:32PM -0400, John M. Flinchbaugh wrote:
> basically, when i added ram to my linux-2.4.0-test8 box taking it from
> 96M to 192M of ram. esd over tcpip started popping, hesitating,
> distorting.  if i limit the memory at kernel boot to 127M (and no

The popping and distorting are bugs of esound, which are fixed in the
0.2.22-1 Debian package.

The hesitating, however, seems like it may be a kernel problem:

esound on 2.2.x with localhost tcp sockets, or 2.4.x with unix domain
sockets return 4096 bytes per read of a sound stream (such as that
from an mp3 player).

esound on 2.4.x with localhost tcp sockets sometimes returns 4096 bytes,
sometimes less, and sometimes stops sending data for a second or two, causing
esd to "pause" and go to sleep, and stopping all audio output.  Forcing esound
to not read any more data (with a horrible sleep(1) in the code) causes enough
data to queue up on the socket that the hesitation vanishes.  If the stream
stops and starts again (ie: switches songs in your mp3 player), the hesitation
often comes back until esound sleeps for a second again.

So my question is whether there may be a problem in localhost TCP sockets
with streams of data like this?

-- 
Ryan Murray, (rmurray@cyberhqz.com, rmurray@debian.org, rmurray@stormix.com)
Projects Manager, Stormix Technologies Inc., Debian Developer
The opinions expressed here are my own.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
