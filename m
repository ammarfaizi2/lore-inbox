Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263428AbRFRXtG>; Mon, 18 Jun 2001 19:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263430AbRFRXsq>; Mon, 18 Jun 2001 19:48:46 -0400
Received: from turnover.lancs.ac.uk ([148.88.17.220]:63480 "EHLO
	helium.chromatix.org.uk") by vger.kernel.org with ESMTP
	id <S263428AbRFRXsm>; Mon, 18 Jun 2001 19:48:42 -0400
Mime-Version: 1.0
Message-Id: <a05101001b75435c7291d@[192.168.239.105]>
In-Reply-To: <Pine.LNX.4.33.0106181527050.13084-100000@twinlark.arctic.org>
In-Reply-To: <Pine.LNX.4.33.0106181527050.13084-100000@twinlark.arctic.org>
Date: Tue, 19 Jun 2001 00:43:32 +0100
To: dean gaudet <dean-list-linux-kernel@arctic.org>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: Client receives TCP packets but does not ACK
Cc: Jan Hudec <bulb@ucw.cz>, <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > >  > Btw: can the aplication somehow ask the tcp/ip stack what was
>>  >actualy acked?
>>  >>  (ie. how many bytes were acked).
>>  >
>>  >no, but it's not necessarily a useful number anyhow -- because it's
>>  >possible that the remote end ACKd bytes but the ACK never arrives.  so you
>>  >can get into a situation where the remote application has the entire
>>  >message but the local application doesn't know.  the only way to solve
>>  >this is above the TCP layer.  (message duplicate elimination using an
>>  >unique id.)
>>
>>  No, because if the ACK doesn't reach the sending machine, the sender
>>  will retry the data until it does get an ACK.
>
>if the network goes down in between, the sender may never get the ACK.
>the sender will see a timeout eventually.  the receiver may already be
>done with the connection and closed it and never see the error.  if it
>were a protocol such as SMTP then the sender would retry later, and the
>result would be a duplicate message.  (which you can eliminate above the
>TCP layer using unique ids.)

But, if the sender does not attempt to close the socket until the ACK 
returns, then the receiver will see an unfinished connection and 
(hopefully) realise that the message is unsafe and not attempt to 
send it.

With SMTP, the last piece of data is a QUIT anyway, which occurs 
after the end-of-message marker - once the QUIT is sent and/or 
received, both ends know that the connection is finished with and 
will close the socket independently of each other.  If the network 
disappears before the QUIT comes along, the receiver should be 
discarding messages and the sender retrying later.
-- 
--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
website:  http://www.chromatix.uklinux.net/vnc/
geekcode: GCS$/E dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$
           V? PS PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)
tagline:  The key to knowledge is not to rely on people to teach you it.
