Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272137AbRIOHqj>; Sat, 15 Sep 2001 03:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272158AbRIOHq3>; Sat, 15 Sep 2001 03:46:29 -0400
Received: from cm038.32.234.24.lvcm.com ([24.234.32.38]:27396 "EHLO osafo.com")
	by vger.kernel.org with ESMTP id <S272137AbRIOHqO>;
	Sat, 15 Sep 2001 03:46:14 -0400
Message-ID: <3BA3075B.9010200@osafo.com>
Date: Sat, 15 Sep 2001 00:46:35 -0700
From: Colin Frank <kernel@osafo.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: Justin Guyett <justin@soze.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compining NetFilter: depmod, undefined symbols in 2.4.9 (solved)
In-Reply-To: <Pine.LNX.4.33.0109132216360.12327-100000@kobayashi.soze.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks.

The configuring the ip_tables stuff after installing pcmcia-cs-3.1.29
seemed to screw things up a little.  The trick: Do pcmcia last.
I need ip_tables + wvlan_cs wireless from pcmcia-cs-3.1.29.

Solution:
cp .config /tmp; make clean; make mrproper; mv /tmp/.config .
make dep; make bzlilo; make modules; make modules_install
cd pcmcia-cs-3.1.29
make config; make all;
cd pcmcia-cs-3.1.29/wireless; make ; make install

Colin...


Justin Guyett wrote:

>On Thu, 13 Sep 2001, Colin Frank wrote:
>
>>There seems to be a mismatch with /System.map and /proc/ksyms
>>form the coorresponding kernel.
>>make bzlilo; make modules; make modules_install, and boot on the
>>/vmlinuz kernel.
>>
>
>It means you either didn't do make clean, or make clean wasn't good enough
>and you needed to copy the .config away, make mrproper, and copy the
>config back.
>
>
>justin
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>


