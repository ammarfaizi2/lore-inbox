Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319029AbSHSVg0>; Mon, 19 Aug 2002 17:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319033AbSHSVg0>; Mon, 19 Aug 2002 17:36:26 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:60820 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S319029AbSHSVgZ> convert rfc822-to-8bit; Mon, 19 Aug 2002 17:36:25 -0400
Content-Type: text/plain; charset=US-ASCII
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux Solutions
To: Xuehua Chen <namniardniw@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: A question about cache coherence
Date: Mon, 19 Aug 2002 14:40:23 -0700
User-Agent: KMail/1.4.1
References: <20020819182121.93059.qmail@web13008.mail.yahoo.com>
In-Reply-To: <20020819182121.93059.qmail@web13008.mail.yahoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208191440.23786.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 August 2002 11:21 am, Xuehua Chen wrote:
> Met a problem in my research. I run some code on a
> Xeon
> dual-processor machine. It seems to me that there is a
>  cache coherence problem. As I am not so familiar
> to this topic, I would like to ask some experts about
> the following questions.
>
> 1. Do Xeon processors have hardware mechanisms to
> maintain cache coherence?

Someone at Intel can correct me, but I believe they use a modified MESI cache 
coherency protocol.  Note that this coherency does not guarantee indivisible 
read-modify-write operations unless atomic opcodes are used.  (xchg or lock 
<opcode>)

> 2. Does the SMP kernel handle the cache coherence
> problem

See Alan's and others' postings.  The kernel relies on the hardware to keep 
its act straight, then takes care of MMU coherency.

> 3. What should I do if both of them don't handle cache
> coherence.

See 1 and 2.  Consider using futexes or some other mutex mechanism appropriate 
to user or kernel code.

> Thanks.
>
> Frank Samuel

-- 
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com

