Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261345AbSJYKBp>; Fri, 25 Oct 2002 06:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261347AbSJYKBp>; Fri, 25 Oct 2002 06:01:45 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:48069 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261345AbSJYKBo>; Fri, 25 Oct 2002 06:01:44 -0400
Subject: Re: [SECURITY] CERT/CC VU#464113, SYN plus RST/FIN
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <87vg3qq4ec.fsf@deneb.enyo.de>
References: <87vg3qq4ec.fsf@deneb.enyo.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 25 Oct 2002 11:25:21 +0100
Message-Id: <1035541521.13244.18.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-10-25 at 10:00, Florian Weimer wrote:
> This patch prevents SYN+RST and SYN+FIN segments which arrive in the
> LISTEN state from initiating a three-way handshake.
> 
> I'm not sure if it is correct, but it's better than nothing (so far, I
> haven't seen any patch for this issue).

I would disagree with the th->fin check. We don't want to break stuff
that is doing T/TCP initially. (Yes the advice people gave is badly
wrong - SYN|ACK|FIN is legal for example and some stacks generate it)

The th->rst is clearly correct however

