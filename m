Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130375AbQLBVLi>; Sat, 2 Dec 2000 16:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130392AbQLBVL2>; Sat, 2 Dec 2000 16:11:28 -0500
Received: from weather.weather.fi ([193.94.59.30]:27438 "EHLO
	weather.weather.fi") by vger.kernel.org with ESMTP
	id <S130375AbQLBVLO>; Sat, 2 Dec 2000 16:11:14 -0500
Date: Sat, 2 Dec 2000 22:40:36 +0200
From: Jaakko Hyvätti <Jaakko.Hyvatti@weather.fi>
To: Adam <adam@cfar.umd.edu>
cc: linux-kernel@vger.kernel.org, Marc@Mutz.com
Subject: Re: 'holey files' not holey enough.
In-Reply-To: <Pine.GSO.4.21.0012020517290.20770-100000@chia.umiacs.umd.edu>
Message-ID: <Pine.SGI.4.10.10012022226530.26849308-100000@weather.weather.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi!

On Sat, 2 Dec 2000, Adam wrote:
> It seems you are right. If I remove the file first, then it will show
> correct amount.

  (For the list: In private mail it was discovered that this behaviour was
caused by the file 'holed.file' not being empty before the dd command.)

  dd behaves here correctly.  It does not append to file, but it just
opens the file for writing.  It does not remove or truncate it first.

  If you have executed this command:

dd if=/dev/zero of=holed.file bs=1000 count=1000

You have a simple file with zeroes, like this:

'000000000'

Then with this command dd opens the file for write but does not destroy
its contents - it is not supposed to do that.  (You can alter files with
dd, you can overwrite single bytes if you like.)

 dd if=/dev/zero of=holed.file bs=1000 seek=5000 count=1000

After opening the file dd seeks to what you specify, and at the same time
extends the file by seeking and Linux converts this to holes:

'000000000-----------------------------------------'

  And after seeking it writes the new block of zeroes:

'000000000-----------------------------------------000000000'

..and you have 2MB of stuff there instead of 1M!

Yours,
Jaakko

-- 
Weather Service Finland Ltd                          Jaakko.Hyvatti@weather.fi
Pursimiehenkatu 29-31 B, FIN-00150 Helsinki, Finland     http://www.weather.fi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
