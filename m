Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131158AbQKGLLk>; Tue, 7 Nov 2000 06:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131213AbQKGLLa>; Tue, 7 Nov 2000 06:11:30 -0500
Received: from vill.ha.smisk.nu ([212.75.83.8]:519 "HELO mail.smisk.nu")
	by vger.kernel.org with SMTP id <S131158AbQKGLLV>;
	Tue, 7 Nov 2000 06:11:21 -0500
Message-ID: <009001c048ab$7d1a7fb0$020a0a0a@totalmef>
From: "Magnus Naeslund\(b\)" <mag@bahnhof.se>
To: "Matthew Sanderson" <matthew@DaMOO.csun.edu>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.96.1001106235858.875A-100000@DaMOO.csun.edu>
Subject: Re: 2.2.17: do_try_to_free_pages fails, no OOM
Date: Tue, 7 Nov 2000 12:11:34 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Sanderson" <matthew@DaMOO.csun.edu>
> I'm running 2.2.17 vanilla on a UP x86 box, and getting occasionally a
> couple of 'VM: do_try_to_free_pages failed' messages.
> The system appears to be running perfectly. It's almost out of real RAM,
> but has about 100M swap unused.
>
> I can't figure out how this happens. Specifically, how come the call to
> swap_out in do_try_to_free_pages didn't swap something out, return true,
> and avoid that message being printed?
> kswapd is not acting up in any way; the system doesn't appear to be OOM.
>
> If this isn't a bug then can we remove this printk'd message?
> If it does seem to be a bug and someone'll give me a crash course on this
> area of the VM I'll investigate further. I notice do_try_to_free_pages can
> be called either from kswapd, or under what look like memory-pressure
> conditions elsewhere.
>
> I'm not on lkml, so please cc me on any replies.
>
> --matt
>

I have this problem with one of my servers with kernel 2.2.16, and then
postgresql freaked out saying something like "AllocSet: memory exhausted".
I changed to 2.2.17, and the messages stopped turning up in the logs, but
pgsql still failes sometimes.
I have to restart the daemon completely to get it working again.
I dunno if there's something wrong with pgsql's memory/shared mem
management, or if it's the kernels fault.
(On 2.0.38 pgsql(different version tho) + box has a 700 day uptime)

Example log (2.2.16):
Oct 24 00:01:34 gimme kernel: VM: do_try_to_free_pages failed for
postmaster...
Oct 24 00:01:34 gimme kernel: VM: do_try_to_free_pages failed for klogd...
Oct 24 00:01:34 gimme kernel: VM: do_try_to_free_pages failed for caspd...
Oct 24 00:07:39 gimme kernel: VM: do_try_to_free_pages failed for
postmaster...

Magnus Naeslund

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
 Programmer/Networker [|] Magnus Naeslund
 PGP Key: http://www.genline.nu/mag_pgp.txt
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
