Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262423AbTCIFiB>; Sun, 9 Mar 2003 00:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262424AbTCIFiB>; Sun, 9 Mar 2003 00:38:01 -0500
Received: from ip-33-237-104-152.anlai.com ([152.104.237.33]:46095 "EHLO
	exchsh01.viatech.com.cn") by vger.kernel.org with ESMTP
	id <S262423AbTCIFh7>; Sun, 9 Mar 2003 00:37:59 -0500
Message-ID: <C373923C3B6ED611874200010250D52E155E27@exchsh01.viatech.com.cn>
From: "Guangyu Kang (Shanghai)" <GuangyuKang@viatech.com.cn>
To: "'Elladan'" <elladan@eskimo.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Help please: DVD ROM read difficulty
Date: Sun, 9 Mar 2003 13:48:19 +0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="GB2312"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, and I forget to cc every one :-P
I just come up from the lower layer, I suspected that it's the ide/ide-cd's
flaw.
If the upper layer is fine, there should be some thing due to interface. 
To me, ide just seems fine, ide-cd have some trival issue on error handling,
I don't think they are so bad that can be called flaw. While do abort on
this or that error case is just all I can do in ide-cd.

Now I do not have any more point - I will try what I said, just wait for my
result, hehe.

On Sun, Mar 09, 2003 at 11:35:53AM +0800, Guangyu Kang (Shanghai) wrote:
> >> Looks like:
> >> CDROM_IOCTL_LOCK
> >> CDROM_IOCTRL_REALTIME_LOGICBLOCK_READ
> >> The lock will make the driver refuse any more open to the driver, thus
> the
> >> driver can concdern on read
> >> operation from my ioctl while not the request. If some one opened the
> driver
> >> already, lock will fail.
> >> The read will be an re-organize of request handler code, adding more
> >> straight-forward error handling,
> >> which will get data from drive and copy it to user. Without the cache
> layer,
> >> in player case,
> >> better performance may be the additional gain.
> 
> >Maybe what you need here is a variant of O_DIRECT ?
> -J
> 
> 
> 
> Yeah should be it. Now I got another advice to use RAW device feature.
> 
> My old idea of the two ioctl will work like the stand alone DVD player set
> which put its output directly into a TV. I mean there will be a single
> buffer managed by player, seeking will done by player itself, and the dvd
> rom driver works much more straight forward. 
> 
> And I took a look at the raw device code yesterday, it looks like an
> re-organize of request processing code in ide-cd.c, I mean it works in a
> loop that send the request one by one, there will not be too much request
> that causes long delay. I think the cache mechanism will send a lot of
> requests and thus driver must do a lot of 10 second device time out.
> 
> RAW read still will not return failt easily, and it has its own seeking
> mechanism. This is troublesome.  You know libdvdread I'm using will do its
> own UDF handling and seeking, etc. and then read the device /dev/hdc.
> 
> I think a combine of modified ide-cd.c that abort on HARDWARE_ERROR and
RAW
> and read/seek check will be sufficient.

I dunno, I really don't know enough about the IDE driver and the block
layer to help much here.  :-(

I tried to read the IDE/Block/ISO9660 layers once to figure out why it
sometimes crashes and puts processes into permanent D state, and the
block and fs layers were nice and sensible, but as soon as I hit the IDE
driver I just gave up.  Ugh.  More special cases than code.

People in the mailist list don't seem all that interested, though, but
they're the one with a clue...

-J
