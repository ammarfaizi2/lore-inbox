Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268739AbRG3XMr>; Mon, 30 Jul 2001 19:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268733AbRG3XMh>; Mon, 30 Jul 2001 19:12:37 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:56069 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S268739AbRG3XMe>; Mon, 30 Jul 2001 19:12:34 -0400
Message-ID: <3B65E9E6.E6444256@namesys.com>
Date: Tue, 31 Jul 2001 03:12:38 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Christoph Hellwig <hch@caldera.de>, linux-kernel@vger.kernel.org
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
In-Reply-To: <Pine.LNX.4.33L.0107301946380.5582-100000@duckman.distro.conectiva>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Rik van Riel wrote:

> > If you could halve linux memory manager performance and check as
> > many things as reiserfs checks, would you do it.
> 
> I haven't removed a single debugging check from the
> 2.4 VM. Performance is MUCH more reliant on things
> like evicting the right page from RAM or reading in
> the right page at the right time.
> 
> CPU usage is only secondary.
> 
> > .. You made the right choice.
> 
> Thanks ;)    [yeah, yeah ... flame me about out-of-context]
> 
> > Now, if you add a #define, you can check as many things as
> > ReiserFS checks, and still go just as fast....
> 
> I'm sure these checks make reiserfs a tad more CPU hungry,
> but isn't the real win in reiserfs supposed to come from
> superior disk layout, readahead across files, etc... ?
> 
> Or is that all just a myth ?
> 
> regards,
> 
> Rik
> --
> Executive summary of a recent Microsoft press release:
>    "we are concerned about the GNU General Public License (GPL)"
> 
>                 http://www.surriel.com/
> http://www.conectiva.com/       http://distro.conectiva.com/


A tree is a complex structure.  You can check it, and the temporary structures
involved in balancing it, quite a lot of ways while balancing it.  I believe you
that the checks you need for your code have no significant performance impact. 
Ours sometimes do.  Consistency checks can be quite a bit more than a tad
consumptive of CPU.  Like I said, there were a few checks we removed after the
bug was gone because we got tired waiting for our debugging iterations taking so
long because of them.

Using the #define means we don't have to think about the effect on performance
of a check, we just leave it in.  Some checks belong outside the #define
(checking to see if garbage came back from disk is left outside the define
nowadays.)  Distros should trust the developers in these tradeoff decisions. 
Otherwise, things just get stupid.

Hans
