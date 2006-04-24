Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751205AbWDXUdD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbWDXUdD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 16:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbWDXUdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 16:33:03 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:39438 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1751205AbWDXUdA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 16:33:00 -0400
To: Arjan van de Ven <arjan@infradead.org>
Cc: "Makan Pourzandi (QB/EMC)" <makan.pourzandi@ericsson.com>,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
       Serue Hallyen <serue@us.ibm.com>,
       Axelle Apvrille <axelle_apvrille@rc1.vip.ukl.yahoo.com>,
       disec-devel@lists.sourceforge.net
Subject: Re: [ANNOUNCE] Release Digsig 1.5: kernel module for run-timeauthentication of binaries
References: <6D19CA8D71C89C43A057926FE0D4ADAA29D361@ecamlmw720.eamcs.ericsson.se>
	<1145897277.3116.44.camel@laptopd505.fenrus.org>
From: Nix <nix@esperi.org.uk>
X-Emacs: more boundary conditions than the Middle East.
Date: Mon, 24 Apr 2006 21:32:39 +0100
In-Reply-To: <1145897277.3116.44.camel@laptopd505.fenrus.org> (Arjan van de Ven's message of "24 Apr 2006 17:49:52 +0100")
Message-ID: <87hd4ipvdk.fsf@hades.wkstn.nix>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Apr 2006, Arjan van de Ven announced authoritatively:
> On Mon, 2006-04-24 at 12:27 -0400, Makan Pourzandi (QB/EMC) wrote:
>> Hi Arjan, 
>> 
>> I hope I correctly understood your question, DigSig uses LSM hooks to
>> check the digital signature before loading it, then as long as your elf
>> loader uses kernel system calls, it's covered by DigSig. 
> 
> ok I have to admit that this answer worries me.
> 
> how can it be covered? How do you distinguish an elf loader application
> (which just uses open + mmap after all) with... say a grep-calling perl
> script?

It checks mmap and mprotect with PROT_EXEC, and execve().

> As long as you allow apps to mmap (or even just read() a file into
> memory).... they can start acting like an elf loader if they chose to do
> so. And.. remember it's not the files WITH signature you're protecting
> against (which you could check) but the ones WITHOUT. And there are many
> of those; and you can't sign ALL files I think, not without going
> through really great hoops anyway.

Why not? It's one command with bsign:

bsign -s -I -i / -e /proc

will sign every ELF shared object and executable on the system.

-- 
`On a scale of 1-10, X's "brokenness rating" is 1.1, but that's only
 because bringing Windows into the picture rescaled "brokenness" by
 a factor of 10.' --- Peter da Silva
