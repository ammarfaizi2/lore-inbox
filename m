Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130415AbQLSTF1>; Tue, 19 Dec 2000 14:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130476AbQLSTFR>; Tue, 19 Dec 2000 14:05:17 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:64271 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S130467AbQLSTFK>;
	Tue, 19 Dec 2000 14:05:10 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: whtdrgn@mail.cannet.com
Date: Tue, 19 Dec 2000 19:33:09 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Time problem
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <10223C2E0ED7@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Dec 00 at 10:37, Timothy A. DeWees wrote:
> 
>     I am having a weird time problem when mounting Novell 5.1 volumes with
> ncpmount.  The Novell server is located in a different timezone, and once I
> mount the volume my system time gets set back 5 hours (to match the Novell
> server).  

You are running nwfstime against your Novell server. Do not do that.
It is normal that you'll get times on ncp filesystem wrong, it is not
bug, it is a feature. But ncpfs itself will never touch your system time.

> I am also loosing my mounts periodically.  

Buy better connectivity between your computer and Netware. I'm sure, that
if you'll look into your log, you'll find 'NCP server not responding...',
eventually together with 'connection lost'.

> The system is running
> Red Hat 6.2 with stock 2.2.14-5.0 (up) kernel.  Can anyone point me to doc
> on how to fix this, or to the ncpfs maintainers so I can bug them.  TIA!

ncpfs maintainer is me. There is ncpfs specific list linware@sh.cvut.cz.
Just read MAINTAINERS file. If you are running Netware over long distance
wire, you should upgrade to 2.4.0-test13-pre3, ncpfs-2.2.0.19.pre29,
and mount server with '-o tcp'. In that case it will use TCP instead of
UDP or IPX. And as TCP is much more robust against short dropouts than
NCP itself, it will work much better. Also, due to NCP window being
60KB instead of 1KB, you'll get much better throughput.

Linux kernel 2.4.0-test13-pre3 is available through standard kernel.org
mirrors, ncpfs pre is avilable from ftp://platan.vc.cvut.cz/private/ncpfs.

I do not plan to teach kernel ncpfs about different timezones. If someone
has another opinion... I was talking about this two (or three) years ago,
but it was shot down as unnecessary bloat. So now I know that there is
at least one person which uses Netware server from another timezone.
                                        Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
                
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
