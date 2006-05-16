Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932066AbWEPPKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbWEPPKY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 11:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932075AbWEPPKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 11:10:24 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:33745 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id S932073AbWEPPKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 11:10:10 -0400
Message-ID: <4469EB4B.6000108@t-online.de>
Date: Tue, 16 May 2006 17:10:03 +0200
From: Bernd Schmidt <bernds_cb1@t-online.de>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       luke.yang@analog.com, gerg@snapgear.com
Subject: Re: Please revert git commit 1ad3dcc0
References: <4469B63B.6000502@t-online.de> <20060516065848.13028f9f.akpm@osdl.org> <4469E1AF.7040908@t-online.de> <Pine.LNX.4.64.0605160740070.3866@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605160740070.3866@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: XVIkz4ZQZe-aMa9126OMrIrGHTPkYMCrf-Da2alUYH3nq4pHOlW+6e
X-TOI-MSGID: 093e442e-8ddb-465c-958a-787935b51ba8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Side note: this would be a valid argument, except it's not always true. 
> I'm not sure why Luke wanted the fd in the first place, though, and 
> whether we want it.

The only reason was a failed LTP testcase which fills up the FD table 
and then called exec.

> Some loaders may actually want the fd value, see for example themisc 
> loader and MISC_FMT_OPEN_BINARY, and the ELF loader _does_ actually do it 
> for the (interpreter_type == INTERPRETER_AOUT) case.

The flat loader does not need a FD value.

>> Before the change, we didn't allocate or install a file descriptor, hence
>> there wasn't any reason to return EMFILE.  The spec at
>>   http://www.opengroup.org/onlinepubs/009695399/functions/exec.html
>> doesn't list EMFILE as a possible error.
> 
> Totally irrelevant.

I think it is relevant: if the spec does not require it, and the flat 
loader does not need the FD, then there is no reason to return EMFILE. 
Both conditions are true in this case.  If the spec did require it, then 
that would be an argument that the LTP testcase is valid, and for 
keeping the original patch.


Bernd
