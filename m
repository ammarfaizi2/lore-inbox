Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030212AbWJ2Ute@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030212AbWJ2Ute (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 15:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030213AbWJ2Ute
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 15:49:34 -0500
Received: from smtp-out.rrz.uni-koeln.de ([134.95.19.53]:31641 "EHLO
	smtp-out.rrz.uni-koeln.de") by vger.kernel.org with ESMTP
	id S1030212AbWJ2Utd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 15:49:33 -0500
Message-ID: <454513C8.1080403@rrz.uni-koeln.de>
Date: Sun, 29 Oct 2006 21:49:12 +0100
From: Berthold Cogel <cogel@rrz.uni-koeln.de>
User-Agent: IceDove 1.5.0.7 (X11/20061013)
MIME-Version: 1.0
To: Samuel Ortiz <samuel@sortiz.org>
CC: irda-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [irda-users] Oops in __wake_up_common with irda, linux-2.6.18
References: <45426EC0.3070004@rrz.uni-koeln.de>	<20061029175024.GA5356@sortiz.org> <45450422.4030706@rrz.uni-koeln.de>
In-Reply-To: <45450422.4030706@rrz.uni-koeln.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Berthold Cogel schrieb:

>> Could you try applying this patch:
>> http://marc.theaimsgroup.com/?l=linux-netdev&m=115792756816966&w=2
>>
>> It's supposed to fix this OOPS. Please let me know.
>>
>> Cheers,
>> Samuel.
> 
> Hello Samuel,
> 
> with 2.6.18 parts of the patch failed:
> 
> acer01:/usr/src/linux# patch -p1 < ../irda_patch.txt
> patching file net/irda/af_irda.c
> Hunk #1 FAILED at 132.
> Hunk #2 FAILED at 1213.
> Hunk #3 FAILED at 1223.
> Hunk #4 succeeded at 1356 with fuzz 2.
> Hunk #5 succeeded at 1409 with fuzz 2.
> 3 out of 5 hunks FAILED -- saving rejects to file net/irda/af_irda.c.rej
> 
> This happens with 2.6.18.1 too. I haven't tried 2.6.19-rc... yet.
> 
> I've attached af_irda.c.rej for 2.6.18.
> 

OK!

Hunk #1 .. #3 are already included in the kernel sources. And the other
parts of the patch did fix the Oops.

Now I get only (with 2.6.18):

acer01:~$ ircp -r
Waiting for incoming connection
srv_obex_event(): Link error

and in /var/log/kern.log:

Oct 29 21:35:59 localhost kernel: irlap_change_speed(), setting speed to
115200
Oct 29 21:35:59 localhost kernel: irlmp_state_dtr(), Unknown event
LM_LAP_CONNECT_CONFIRM on LSAP 0x10
Oct 29 21:35:59 localhost last message repeated 2 times
Oct 29 21:36:00 localhost kernel: irda_poll(), POLLHUP
Oct 29 21:36:00 localhost kernel: Assertion failed!
net/irda/af_irda.c:irda_recvmsg_stream:1409 !sock_error(sk)
Oct 29 21:36:02 localhost kernel: irlap_change_speed(), setting speed to
9600


Regards,

Berthold
