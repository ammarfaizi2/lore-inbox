Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292317AbSBUHKW>; Thu, 21 Feb 2002 02:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292318AbSBUHKL>; Thu, 21 Feb 2002 02:10:11 -0500
Received: from c37690.carlnfd1.nsw.optusnet.com.au ([203.164.24.124]:51441
	"EHLO cskk.homeip.net") by vger.kernel.org with ESMTP
	id <S292317AbSBUHKB>; Thu, 21 Feb 2002 02:10:01 -0500
Date: Thu, 21 Feb 2002 18:10:48 +1100
From: Cameron Simpson <cs@zip.com.au>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: syscall latency improvement #1
Message-ID: <20020221071048.GA7127@amadeus.home>
Reply-To: cs@zip.com.au
In-Reply-To: <18993.1011984842@warthog.cambridge.redhat.com> <200201281018.g0SAIIE22462@Port.imtp.ilyichevsk.odessa.ua> <3C55282C.7D607CFB@zip.com.au> <200201290859.g0T8xGE26936@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200201290859.g0T8xGE26936@Port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10:59 29 Jan 2002, Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> wrote:
| > - If a function has a single call site and is static then it
| >   is always correct to inline.

I'm thinking: any decent compiler will inline this on its own, _without_
an inline keyword. So _don't_ use inline here.

| And what if later you (or someone else!) add another call? You may forget to 
| remove inline. It adds maintenance trouble while not buying much of speed:

Indeed. And handled by the null case of "no inline" used above - the
compiler will get this right if you leave out the inline keywords,
while adding it causes the above issue.

| if func is big, inline gains are small, if it's small, it should be inlined 
| regardless of number of call sites.

Wasn't that case #2? Inline when func < some small number of bytes?
-- 
Cameron Simpson, DoD#743        cs@zip.com.au    http://www.zip.com.au/~cs/

My father was a despatch rider during the last war. He rode BSAs but, for
reasons I still don't understand, he never bothered to tell me that they
were useless, unreliable piles of shit.	- Grant Roff, _Two Wheels_ Nov96
