Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751395AbWIDOND@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbWIDOND (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 10:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbWIDOND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 10:13:03 -0400
Received: from web36712.mail.mud.yahoo.com ([209.191.85.46]:59793 "HELO
	web36712.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751395AbWIDONA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 10:13:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=BHfC8x9k9kAHQgt5XpswPiOWjJFuVyZTbi3SmVBQXxwN9nwQP9PDdsH654p7DVeq0GTeg/Rh5Kml3KYE1n6r0QRbsliWdfrWN+jbOfslMP1Jli793xxRdwwf7e9bJwmBvse36EaJoEeV98yJjVtUDeSwDC4ue5dRajUXSTVcEV0=  ;
Message-ID: <20060904141300.87440.qmail@web36712.mail.mud.yahoo.com>
Date: Mon, 4 Sep 2006 07:12:59 -0700 (PDT)
From: Alex Dubov <oakad@yahoo.com>
Subject: Re: Support for TI FlashMedia (pci id 104c:8033, 104c:803b) flash card readers
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44FAA88C.9040401@drzeus.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Pierre Ossman <drzeus-list@drzeus.cx> wrote:

> 
> I suppose it's a matter of taste, but personally I think the mere
> mentioning of 'for' allows you to directly see that there is some kind
> of looping involved. And it shouldn't be terribly complex:
> 
> for (i = 0;i < 8;i++) {
>     resp[i] = readw(addr + RESPONSE + (7 - i)*4) << 16;
>     resp[i] |= readw(addr + RESPONSE + (6 - i)*4);
> }
> 

The actual loop is slightly different (there are 4 elements in cmd->resp):
for (i=0; i < 4; i++) {
      resp[i] = readl(addr + RESP + (7 - 2 * i) * 4) << 16;
      resp[i] |= readl(addr + RESP + (6 - 2 * i) * 4);
}
As there are only 4 iterations it's not a lot of work to spare the compiler from address
calculation. readl also seems more appropriate than readw, as resp is array of u32.


> The problem is that it's a big difference between
> seeing "data TO" and
> seeing "data to" in the code. How about using the
> three letter
> abbreviations in those places? I.e. "cto" and "dto"?
I changed the variable and function names to *_timeout, but left the macros as *_TO. This way,
the macro name corresponds to the datasheet and the meaning is evident from context:

writel(data_timeout, sock->addr + SOCK_MMCSD_DATA_TO);


Additionally, I added defines for response and command types.


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
