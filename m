Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314284AbSHFRYY>; Tue, 6 Aug 2002 13:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314278AbSHFRXU>; Tue, 6 Aug 2002 13:23:20 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:56547 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S314149AbSHFRXR>;
	Tue, 6 Aug 2002 13:23:17 -0400
Date: Tue, 06 Aug 2002 10:23:56 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel <linux-kernel@vger.kernel.org>, colpatch@us.ibm.com
Subject: Re: [PATCH] NUMA-Q xquad_portio declaration
Message-ID: <1253454051.1028629435@[10.10.2.3]>
In-Reply-To: <1028656471.18156.179.camel@irongate.swansea.linux.org.uk>
References: <1028656471.18156.179.camel@irongate.swansea.linux.org.uk>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The STANDALONE thing? I'm not convinced that's really any cleaner,
>> it makes even more of a mess of io.h than there was already (though
>> we could consider that a lost cause ;-)). 
>> 
>> What's your objection to just throwing in a defn of xquad_portio?
>> A preference for burying the messy stuff in header files? Seems to
>> me that as you have to define STANDALONE now, the point is moot.
> 
> Because you are assuming there will be -one- kind of wackomatic PC
> system - IBM's. The chances are there will be more than one as other
> vendors like HP, Compaq and Dell begin shipping stuff. Having
> __STANDALONE__ works for all the cases instead of exporting xquad this
> hpmagic that and compaq the other in an ever growing cess pit

OK, fair enough. Would a simpler approach to what you've done be
to do in io.h something like:

#ifdef CONFIG_MULTIQUAD
 #ifdef STANDALONE
  #define xquad_portio 0
 #else
  extern void *xquad_portio;    /* Where the IO area was mapped */
 #endif
#endif /* CONFIG_MULTIQUAD */

Or something along these lines ... ? Would make the changeset
somewhat smaller. Seems to work from 30 seconds thought, but 
haven't tried it (yet).

M.

