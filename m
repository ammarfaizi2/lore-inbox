Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266435AbTAOOlq>; Wed, 15 Jan 2003 09:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266453AbTAOOlq>; Wed, 15 Jan 2003 09:41:46 -0500
Received: from k100-145.bas1.dbn.dublin.eircom.net ([159.134.100.145]:47373
	"EHLO corvil.com.") by vger.kernel.org with ESMTP
	id <S266435AbTAOOlq>; Wed, 15 Jan 2003 09:41:46 -0500
Message-ID: <3E257488.3000006@Linux.ie>
Date: Wed, 15 Jan 2003 14:47:36 +0000
From: Padraig@Linux.ie
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Larry Sendlosky <Larry.Sendlosky@storigen.com>
CC: Dave Jones <davej@codemonkey.org.uk>,
       Miklos Szeredi <Miklos.Szeredi@eth.ericsson.se>,
       linux-kernel@vger.kernel.org
Subject: Re: VIA C3 and random SIGTRAP or segfault
References: <7BFCE5F1EF28D64198522688F5449D5AC63352@xchangeserver2.storigen.com>
In-Reply-To: <7BFCE5F1EF28D64198522688F5449D5AC63352@xchangeserver2.storigen.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry Sendlosky wrote:
> We're seeing the same thing on a mini-ITX based system.
> init is segfaulting :(( .  We've never seen this on our
> other non-C3 systems running the same codebase. We've instrumented
> the kernel to help catch the initial problem, hopefully it will
> trigger soon.
> 
> Dave, will the cmov generate a segfault or illegal instr trap (SIGILL?) ?

segfault is what I saw. Something seems to be corrupted (by a cmov
SIGILL?) and from then the app will crash in the same
(arbitrary) place until the machine is restarted. Some apps
are more susceptible than others. Note a Samuel II would work fine?

Hmm, just checking an ssh binary and associated libs that I know
crashed every so often (only in interactive mode, not with ssh -c),
I noticed that libnsl.so.1 (network services lib (part of glibc))
had cmov instructions. Other things noticed to crash were bash,
vi, php, snmpd. So I guess libnsl could be the root of our probs?
Note we built the whole system from SRPMs with the appropriate
flags for C3, but obviously these were ignored for libnsl anyway!
Also possibly related is that most problematic binaries
(php/snmpd/ssh) were linked to libcrypto.so.2 which may be relevant?

To find if a binary has CMOV instructions:
   objdump --disassemble binary | grep cmov

Pádraig.

