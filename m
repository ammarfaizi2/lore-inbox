Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132512AbRDNSNo>; Sat, 14 Apr 2001 14:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132514AbRDNSNe>; Sat, 14 Apr 2001 14:13:34 -0400
Received: from ip166-128.fli-ykh.psinet.ne.jp ([210.129.166.128]:26819 "EHLO
	standard.erephon") by vger.kernel.org with ESMTP id <S132512AbRDNSNX>;
	Sat, 14 Apr 2001 14:13:23 -0400
Message-ID: <3AD911CD.55F1CDA3@yk.rim.or.jp>
Date: Sun, 15 Apr 2001 12:13:17 +0900
From: Ishikawa <ishikawa@yk.rim.or.jp>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: ja, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Swap Corruption in 2.4.3 ?
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 10 Apr 2001, Richard Russon wrote:

> VM: Undead swap entry 000bb300
> VM: Undead swap entry 00abb300
> VM: Undead swap entry 016fb300

I have seen similar mysterious crashes of X server
when I began accessing large web page using Netscape
navigator. It was reproducible the first few times I noticed.

Today, a similar problem occurred and luckily I noticed
console messages printed on a virtual console.
There ware many lines like the following.

swap_free: Trying to freee non-existent swap page
Bad Swap Entry: 00000008
Bad Swap Entry: 0000008
    ...
VM: Kiling process jserver
Swap_free: Trying to free non-existent swap  page
   ...

It seems that there was some sort of kernel data corruption.
(In my case, the kernel could not find the swap page and
failed to swap out memory and thus the
VM's selective process killer was invoked to free up memory?)

Then eventually I got
Unable to handle kernel NULL pointer defreence at ...
message and the system crashed.
(I was also typing Alt+SysReq+keystroke to see if I could sync disk.)
.

Anyway, this probem seems to be in 2.4.2, too from what I recall about
the
first mysterious X server crash.

On Apri 20 Rik van Riel wrote:
>Known bug ... unknown cause ;(
>
>http://www.linux-mm.org/bugzilla.shtml has it already listed

The symptom there didn't match mine, but I do suspect
a (new) problem in VM of 2.4.3 (2.4.2, too. 2.4.1, I am not sure.).

Happy Hacking


