Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbUDIOp5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 10:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbUDIOp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 10:45:57 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:4880 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261378AbUDIOpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 10:45:55 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: "Nikita V. Youshchenko" <yoush@cs.msu.su>, linux-kernel@vger.kernel.org
Subject: Re: Local DoS (was: Strange 'zombie' problem both in 2.4 and 2.6)
Date: Fri, 9 Apr 2004 17:45:41 +0300
User-Agent: KMail/1.5.4
References: <200404091311.50787@zigzag.lvk.cs.msu.su>
In-Reply-To: <200404091311.50787@zigzag.lvk.cs.msu.su>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404091745.41473.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 April 2004 12:11, Nikita V. Youshchenko wrote:
> Hello.
>
> Several days ago I've posted to linux-kernel describing "zombie problem"
> related to sigqueue overflow.
>
> Futher exploration of the problem showed that the reason of the described
> behaviour is in user-space. There is a process that blocks a signal and
> later receives tons of such signals. This effectively causes sigqueue
> overflow.

One solution would be to watermark sigqueue and upon reaching
high mark, find the process with most signals queued and drop those.
This prevents one buggy process, even root-launched, from interfering
with non-buggy ones.

If low watermark is not reached, find _UID_ which have max # of
signals pending, and drop them all. This will work against rogue
user trying to DoS box who's careful enough to do it from multiple
processes.
--
vda

