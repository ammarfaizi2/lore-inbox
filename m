Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267731AbTAIV2x>; Thu, 9 Jan 2003 16:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267738AbTAIV2x>; Thu, 9 Jan 2003 16:28:53 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:38392 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267731AbTAIV2x> convert rfc822-to-8bit; Thu, 9 Jan 2003 16:28:53 -0500
Content-Type: text/plain; charset=US-ASCII
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux Solutions
To: Jason Lunz <lunz@falooley.org>, linux-kernel@vger.kernel.org
Subject: Re: detecting hyperthreading in linux 2.4.19
Date: Thu, 9 Jan 2003 13:37:04 -0800
User-Agent: KMail/1.4.3
References: <slrnb1rlct.g2c.lunz@stoli.localnet>
In-Reply-To: <slrnb1rlct.g2c.lunz@stoli.localnet>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301091337.04957.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 January 2003 12:02 pm, Jason Lunz wrote:
> Is there a way for a userspace program running on linux 2.4.19 to tell
> the difference between a single hyperthreaded xeon P4 with HT enabled
> and a dual hyperthreaded xeon P4 with HT disabled? The /proc/cpuinfos
> for the two cases are indistinguishable.
>
> Jason
>
> -

In the kernel that's no problem:

A) If the BIOS writers followed Intel's guidelines, just look at the physical 
APIC IDs.  HT siblings have odd IDs, the real ones have even.

B) Check the siblings table built up at boot time and used by the scheduler.

I don't know of any way to do this in userland.  The whole point is that the 
sibling processors are supposed to look like real ones.

You _could_ try running two processes simultaneously in tight spin loops for 
100 million cycles and comparing the amount of real time consumed.  That 
would be rather unreliable and kludgey though.

-- 
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com

