Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261547AbRFRQyA>; Mon, 18 Jun 2001 12:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261577AbRFRQxu>; Mon, 18 Jun 2001 12:53:50 -0400
Received: from turnover.lancs.ac.uk ([148.88.17.220]:38643 "EHLO
	helium.chromatix.org.uk") by vger.kernel.org with ESMTP
	id <S261547AbRFRQxr>; Mon, 18 Jun 2001 12:53:47 -0400
Mime-Version: 1.0
Message-Id: <a05101000b753df30ddaa@[192.168.239.105]>
In-Reply-To: <Pine.LNX.4.33.0106180913560.312-100000@twinlark.arctic.org>
In-Reply-To: <Pine.LNX.4.33.0106180913560.312-100000@twinlark.arctic.org>
Date: Mon, 18 Jun 2001 17:48:19 +0100
To: dean gaudet <dean-list-linux-kernel@arctic.org>, Jan Hudec <bulb@ucw.cz>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: Client receives TCP packets but does not ACK
Cc: <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > Btw: can the aplication somehow ask the tcp/ip stack what was 
>actualy acked?
>>  (ie. how many bytes were acked).
>
>no, but it's not necessarily a useful number anyhow -- because it's
>possible that the remote end ACKd bytes but the ACK never arrives.  so you
>can get into a situation where the remote application has the entire
>message but the local application doesn't know.  the only way to solve
>this is above the TCP layer.  (message duplicate elimination using an
>unique id.)

No, because if the ACK doesn't reach the sending machine, the sender 
will retry the data until it does get an ACK.  So the sender always 
has information about some amount of data which is guaranteed to have 
arrived at the other end.  The receiver might know about this sooner, 
but that's simply a function of network latency.

The fundamental problem, if I understand right, is that some stacks 
allow packets indicating closing of a connection (FIN) to arrive 
before the actual data at the end of the connection does.  The only 
workaround I can think of for this is for the closing stack to wait 
until all sent data has been ACKed before sending the FIN.  The ACK 
may, of course, never arrive, but that's what round-trip timeouts are 
for.
-- 
--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
website:  http://www.chromatix.uklinux.net/vnc/
geekcode: GCS$/E dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$
           V? PS PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)
tagline:  The key to knowledge is not to rely on people to teach you it.
