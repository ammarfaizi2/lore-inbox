Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268065AbTAJAID>; Thu, 9 Jan 2003 19:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268058AbTAJAID>; Thu, 9 Jan 2003 19:08:03 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:46032 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S268066AbTAJAIB> convert rfc822-to-8bit; Thu, 9 Jan 2003 19:08:01 -0500
Content-Type: text/plain; charset=US-ASCII
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux Solutions
To: John Bradford <john@grabjohn.com>
Subject: Re: detecting hyperthreading in linux 2.4.19
Date: Thu, 9 Jan 2003 16:16:14 -0800
User-Agent: KMail/1.4.3
Cc: lunz@falooley.org, linux-kernel@vger.kernel.org
References: <200301092154.h09Ls5SX005123@darkstar.example.net>
In-Reply-To: <200301092154.h09Ls5SX005123@darkstar.example.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301091616.14195.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 January 2003 01:54 pm, John Bradford wrote:
> > > Is there a way for a userspace program running on linux 2.4.19 to tell
> > > the difference between a single hyperthreaded xeon P4 with HT enabled
> > > and a dual hyperthreaded xeon P4 with HT disabled? The /proc/cpuinfos
> > > for the two cases are indistinguishable.
> >
> > I don't know of any way to do this in userland.  The whole point is that
> > the sibling processors are supposed to look like real ones.
> >
> > You _could_ try running two processes simultaneously in tight spin loops
> > for 100 million cycles and comparing the amount of real time consumed. 
> > That would be rather unreliable and kludgey though.
>
> If /proc/interrupts shows a processor is handling interrupts then it
> is definitely a 'real' one.  If it isn't handling interrupts, it may
> or may not be a 'real' one.  That's another unreliable and kludgey way
> to tell the difference :-).
>
> John.
> -

Not quite.  The "logical" or "sibling" processor has its own local APIC.  This 
is necessary to send it the Startup IPI and soft IPIs while the system is 
running.

However, it is a full function APIC and can receive I/O interrupts.  I have 
seen this happen many times.

-- 
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com

