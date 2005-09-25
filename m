Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbVIYKoa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbVIYKoa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 06:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbVIYKoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 06:44:30 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:60058 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S1751250AbVIYKoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 06:44:30 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Grant Coady <grant_lkml@dodo.com.au>
Subject: Re: New inventions in rounding up in catc.c?
Date: Sun, 25 Sep 2005 13:43:47 +0300
User-Agent: KMail/1.8.2
Cc: Simon Evans <spse@secret.org.uk>, Vojtech Pavlik <vojtech@suse.cz>,
       linux-kernel@vger.kernel.org
References: <200509241343.42464.vda@ilport.com.ua> <l27bj1hjeqsl9ifg4ogb0drj56fsm0j62a@4ax.com>
In-Reply-To: <l27bj1hjeqsl9ifg4ogb0drj56fsm0j62a@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509251343.47892.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 24 September 2005 21:46, Grant Coady wrote:
> On Sat, 24 Sep 2005 13:43:42 +0300, Denis Vlasenko <vda@ilport.com.ua> wrote:
> > 		/* F5U011 only does one packet per RX */
> > 		if (catc->is_f5u011)
> > 			break;
> >-		pkt_start += (((pkt_len + 1) >> 6) + 1) << 6;
> >+		pkt_start += ((pkt_len + 2) + 63) & ~63;
> 
>   		pkt_start += ((pkt_len + 1) + 64) & ~63;
> 
> Seems more clear to me.

Why?

((pkt_len + 2) + 63) & ~63 is "add 2 and round up to next 64".
((pkt_len + 1) + 64) & ~63 is "???!"

It's strange code anyway, I hope maintainer can clarify what's going on.
(I suspect it was intended to be pkt_len - 1, not +, in the first place)
--
vda
