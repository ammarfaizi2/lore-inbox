Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261898AbUJZC5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbUJZC5E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 22:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbUJZC4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 22:56:37 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:5515 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261898AbUJZCuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 22:50:06 -0400
Message-ID: <417DBB5A.6020207@acm.org>
Date: Mon, 25 Oct 2004 21:50:02 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Race betwen the NMI handler and the RTC clock in practially all
 kernels II
References: <417D2305.3020209@acm.org.suse.lists.linux.kernel> <p73u0sik2fa.fsf@verdi.suse.de> <Pine.LNX.4.58L.0410252054370.24374@blysk.ds.pg.gda.pl> <20041025201758.GG9142@wotan.suse.de> <20041025204144.GA27518@wotan.suse.de> <Pine.LNX.4.58L.0410252157440.10974@blysk.ds.pg.gda.pl> <417D786F.4020101@acm.org> <Pine.LNX.4.58L.0410260031050.10974@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.58L.0410260031050.10974@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej W. Rozycki wrote:

>>And you need a mutex for SMP systems.  If one processor is handling an 
>>NMI, another processor may still be accessing the device.
>>    
>>
> Actually this path is meant to be ever accessed by one CPU only (one that
>has its LINT1 line enabled), but it may be reached by other ones due to
>the NMI watchdog as code does not check if its run by the right processor.  
>This probably qualifies as a bug.  Only the watchdog code of the NMI
>handler is expected to run everywhere.
>  
>
Yes, only one processor will run through the NMI code, but another 
processor may be accessing the RTC or something else in CMOS.  The mutex 
will prevent the NMI and the RTC access from conflicting.

-Corey
