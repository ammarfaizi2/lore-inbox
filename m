Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263980AbRFMPJY>; Wed, 13 Jun 2001 11:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263981AbRFMPJO>; Wed, 13 Jun 2001 11:09:14 -0400
Received: from 216-60-128-137.ati.utexas.edu ([216.60.128.137]:31872 "HELO
	tsunami.webofficenow.com") by vger.kernel.org with SMTP
	id <S263980AbRFMPJD>; Wed, 13 Jun 2001 11:09:03 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@webofficenow.com>
Reply-To: landley@webofficenow.com
To: Luigi Genoni <kernel@Expansa.sns.it>, Ben Greear <greearb@candelatech.com>
Subject: Re: Hour long timeout to ssh/telnet/ftp to down host?
Date: Wed, 13 Jun 2001 06:07:49 -0400
X-Mailer: KMail [version 1.2]
Cc: <landley@webofficenow.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0106131138390.22415-100000@Expansa.sns.it>
In-Reply-To: <Pine.LNX.4.33.0106131138390.22415-100000@Expansa.sns.it>
MIME-Version: 1.0
Message-Id: <01061306074902.00703@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 13 June 2001 05:40, Luigi Genoni wrote:
> On Tue, 12 Jun 2001, Ben Greear wrote:

> > You can tune things by setting the tcp-timeout probably..I don't
> > know exactly where to set this..
>
> /proc/sys/net/ipv4/tcp_fin_timeout
>
> default is 60.

Never got that far.  My problem was actually tcp_syn_retries. Remember, I was 
talking to a host that was unplugged.  (I wasn't even getting "host 
unreachable" messages, the packets were just disappearing.)  The default 
timeout in that case is rediculous do to the exponentially increasing delays 
between retries.  10 retries wound up being something like 20 minutes.

I set it to 5 and everything works beautifully now.  ssh (which retries the 
connection 4 times, and used to take over an hour to time out) now takes just 
over 3 minutes, which I can live with.

Rob
