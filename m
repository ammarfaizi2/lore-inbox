Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282080AbRLLUch>; Wed, 12 Dec 2001 15:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281932AbRLLUc1>; Wed, 12 Dec 2001 15:32:27 -0500
Received: from cs182072.pp.htv.fi ([213.243.182.72]:2688 "EHLO
	cs182072.pp.htv.fi") by vger.kernel.org with ESMTP
	id <S281910AbRLLUcP>; Wed, 12 Dec 2001 15:32:15 -0500
Message-ID: <3C17BEB0.FDE8E9EB@welho.com>
Date: Wed, 12 Dec 2001 22:31:44 +0200
From: Mika Liljeberg <Mika.Liljeberg@welho.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kuznet@ms2.inr.ac.ru
CC: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: TCP LAST-ACK state broken in 2.4.17-pre2
In-Reply-To: <200112111751.UAA02766@ms2.inr.ac.ru>
Content-Type: multipart/mixed;
 boundary="------------B4BB1D6FA5E496C27784F1D4"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------B4BB1D6FA5E496C27784F1D4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Alexey,

Looks like there are still problems after applying your quick patch.
Back at the lab we observed a case where the FIN-ACK packet is dropped
and Linux fails to retransmit it. See the attached dump for the details
(Linux is 10.0.5.11). The action ends there, with Linux timing out to
CLOSED state and the remote stuck in FIN-WAIT-2.

Cheers,

	MikaL
--------------B4BB1D6FA5E496C27784F1D4
Content-Type: text/plain; charset=us-ascii;
 name="last-ack.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="last-ack.txt"

11:11:57.149389 10.0.5.3.3071 > 10.0.5.11.1327: P 254033:255481(1448) ack 1 win 7300 <timestamp 3704210538 8515686,eol> (DF) (ttl 63, id 860, len 1500)
11:11:57.149451 10.0.5.11.1327 > 10.0.5.3.3071: . [tcp sum ok] 1:1(0) ack 255481 win 65160 <nop,nop,timestamp 8544990 3704210538> (DF) (ttl 64, id 30696, len 52)
11:11:57.661595 10.0.5.3.3071 > 10.0.5.11.1327: FP 255481:256001(520) ack 1 win 7300 <timestamp 3705679288 8515686,eol> (DF) (ttl 63, id 861, len 572)
11:11:57.661660 10.0.5.11.1327 > 10.0.5.3.3071: F [tcp sum ok] 1:1(0) ack 256002 win 65160 <nop,nop,timestamp 8545041 3705679288> (DF) (ttl 64, id 30697, len 52)
11:12:11.340666 10.0.5.3.3071 > 10.0.5.11.1327: FP 255481:256001(520) ack 1 win 7300 <timestamp 3727069913 8515686,eol> (DF) (ttl 63, id 863, len 572)
11:12:11.340698 10.0.5.11.1327 > 10.0.5.3.3071: . [tcp sum ok] 2:2(0) ack 256002 win 65160 <nop,nop,timestamp 8546409 3727069913,nop,nop,sack sack 1 {255481:256002} > (DF) (ttl 64, id 30698, len 64)

--------------B4BB1D6FA5E496C27784F1D4--

